#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# tmux master stack
# dwm like split management

import subprocess
import re
import json
import sys
from math import ceil

TMUX_BUFFER_NAME = 'dwm'
LAYOUTS = ['horizontal', 'vertical']

def default_window(win_id):
    """return default config for one window"""
    win = {}
    win['win_id']    = win_id
    win['mfact']     = 0.55
    win['nmaster']   = 1
    win['layout']    = 'horizontal'
    win['zoomed']    = False
    win['num_panes'] = 1
    win['last_master_pane_id'] = None
    win['last_non_master_pane_id'] = None
    return win

def get_windows_status():
    """Retrieve current window status from tmux"""
    print_format = '{"win_id": "#{session_id}:#{window_id}", ' \
            '"is_active": #{window_active}, ' \
            '"is_zoomed": #{window_zoomed_flag},' \
            '"width": #{window_width},' \
            '"height": #{window_height},' \
            '"num_panes": #{window_panes},' \
            '"layout_string": "#{window_layout}"' \
            '}'
    result = subprocess.run(['tmux', 'list-windows', '-F', print_format], stdout=subprocess.PIPE)
    windows = [json.loads(l) for l in result.stdout.splitlines()]
    return {win["win_id"]: win for win in windows}

def get_panes_status():
    """Retrieve current_pane status from tmux"""
    print_format = '{"win_id": "#{session_id}:#{window_id}", ' \
            '"pane_index": #{pane_index},' \
            '"pane_id": "#{pane_id}",' \
            '"is_active": #{pane_active}' \
            '}'
    result = subprocess.run(['tmux', 'list-panes', '-F', print_format], stdout=subprocess.PIPE)
    panes = [json.loads(l) for l in result.stdout.splitlines()]

    # get active pane id
    active_pane = None
    for pane in panes:
        if pane['is_active'] == 1:
            active_pane = pane
            break

    return {'panes': panes, 'active_pane': active_pane}

def load_config():
    """Load saved config"""
    try:
        result = subprocess.run(['tmux', 'save-buffer', '-b', TMUX_BUFFER_NAME, '-'], check=True, stdout=subprocess.PIPE)
        config = json.loads(result.stdout)

    except subprocess.CalledProcessError:
        config = {'windows': {}, 'active_window': None}

    current_windows = get_windows_status()
    # find active window
    active_window = None
    for window in current_windows.values():
        if window['is_active'] == 1:
            active_window = window
            break

    if active_window is not None:
        win_id = active_window['win_id']
        if win_id not in config['windows']:
            config['windows'][win_id] = default_window(win_id)
        config['windows'][win_id].update(active_window)
        config['active_window'] = config['windows'][win_id]

    # win_id is $xxx:@xxx
    current_session = active_window['win_id'].split(':')[0]
    window_ids = list(config['windows'].keys())
    for win_id in window_ids:
        if win_id.startswith(current_session) and win_id not in current_windows:
            del config['windows'][win_id]

    return config

def save_config(config):
    """Save current config to tmux buffer as json"""
    subprocess.run(['tmux', 'set-buffer', '-b', TMUX_BUFFER_NAME, json.dumps(config)])

re_panel = re.compile(r'(\d+)x(\d+),(\d+),(\d+)(?:,(\d+)(?!x))?')
def _parse_layout(layout, next_index = 0):
    """panes from

    :layout: The layout string
    :next_index: the index of next character to be parsed
    :returns: (root, next_index)

    """

    match = re_panel.match(layout[next_index:])
    width, height, x, y, id = match.groups()
    next_index += match.span()[1]

    panel = Pane(id, int(x), int(y), int(width), int(height))

    if next_index == len(layout):
        return (panel, next_index)

    next_char = layout[next_index]
    if next_char == '[':
        panel.type = 'TOP-BOTTOM'
    elif next_char == '{':
        panel.type = 'LEFT-RIGHT'

    if next_char == '[' or next_char == '{':
        next_index += 1
        while len(layout[next_index:]) > 0 and layout[next_index] != '}' and layout[next_index] != ']':
            child, next_index = _parse_layout(layout, next_index)
            panel.children.append(child)
        # consume the last ']' or '}'
        next_index += 1

    if next_index < len(layout) and layout[next_index] == ',':
        next_index += 1

    return (panel, next_index)

def parse_layout(layout):
    index = layout.find(',')
    root, _ = _parse_layout(layout[index+1:])
    return root

def layout_checksum(layout):
    csum = 0
    for c in layout:
        csum = ((csum >> 1) + ((csum & 1) << 15) + ord(c)) & 0xFFFF

    return '%04x' % (csum)

class Pane(object):
    """Represents a pane, mainly used for handling layout"""
    def __init__(self, id, x=0,y=0,width=0,height=0, parent=None, type='CHILD'):
        super(Pane, self).__init__()
        self.id = 0 if id is None else id
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.minimized = False
        self.type = type
        self.children = []

    def split(self, n=2):
        if self.type == 'CHILD':
            return

        if n <= 1:
            self.type = 'CHILD'
            return

        if self.type == 'LEFT-RIGHT':
            # y and height is the same.
            width_unit = (self.width - (n-1)*1) // n
            next_x = self.x
            for _ in range(n-1):
                pane = Pane(None, next_x, self.y, width_unit, self.height, self)
                self.children.append(pane)
                next_x += width_unit + 1

            # the last one
            pane = Pane(None, next_x, self.y, self.width - next_x, self.height, self)
            self.children.append(pane)

        elif self.type == 'TOP-BOTTOM':
            # x and width is the same.
            height_unit = (self.height - (n-1)*1) // n
            next_y = self.y
            for _ in range(n-1):
                pane = Pane(None, self.x, next_y, self.width, height_unit, self)
                self.children.append(pane)
                next_y += height_unit + 1

            # the last one
            pane = Pane(None, self.x, next_y, self.width, self.height - next_y, self)
            self.children.append(pane)

    def dump_layout(self):
        if self.type == "CHILD":
            return "{}x{},{},{},{}".format(self.width, self.height, self.x, self.y, self.id)
        else:
            lparen = '[' if self.type == 'TOP-BOTTOM' else '{'
            rparen = ']' if self.type == 'TOP-BOTTOM' else '}'
            return '{}x{},{},{}{lparen}{children}{rparen}'.format(self.width, self.height, self.x, self.y,
                    lparen=lparen,
                    children = ','.join([c.dump_layout() for c in self.children]),
                    rparen=rparen)

    def __repr__(self, level=0):
        lines = ['{}{}: {}x{},{},{}({})'.format('    '*level, self.id, self.width, self.height, self.x, self.y, self.type)]
        for c in self.children:
            lines.append(c.__repr__(level+1))
        return '\n'.join(lines)

def reconstruct_layout(win):
    n = win['num_panes']

    if win['layout'] == 'vertical':
        if n <= win['nmaster']:
            root_pane = Pane(None, 0, 0, win['width'], win['height'], type='LEFT-RIGHT')
            root_pane.split(n)
        else:
            root_pane = Pane(None, 0, 0, win['width'], win['height'], type='TOP-BOTTOM')
            up_pane = Pane(None, 0, 0, win['width'], ceil(win['height']*win['mfact']), type='LEFT-RIGHT')
            down_pane = Pane(None, 0, ceil(win['height']*win['mfact'])+1, win['width'], win['height']-ceil(win['height']*win['mfact'])-1, type='LEFT-RIGHT')

            up_pane.split(win['nmaster'])
            down_pane.split(n - win['nmaster'])

            root_pane.children = [up_pane, down_pane]

    elif win['layout'] == 'horizontal':
        if n <= win['nmaster']:
            root_pane = Pane(None, 0, 0, win['width'], win['height'], type='TOP-BOTTOM')
            root_pane.split(n)
        else:
            root_pane = Pane(None, 0, 0, win['width'], win['height'], type='LEFT-RIGHT')
            left_pane = Pane(None, 0, 0, int(win['width']*win['mfact']), win['height'], type='TOP-BOTTOM')
            right_pane = Pane(None, int(win['width']*win['mfact'])+1, 0, win['width']-int(win['width']*win['mfact'])-1, win['height'], type='TOP-BOTTOM')

            left_pane.split(win['nmaster'])
            right_pane.split(n - win['nmaster'])

            root_pane.children = [left_pane, right_pane]
    return root_pane.dump_layout()

def reconstruct(config):
    layout = reconstruct_layout(config['active_window'])
    subprocess.run(['tmux', 'selectl', '{},{}'.format(layout_checksum(layout),layout)])

#==============================================================================
# Commands
class LayoutManager(object):
    def __init__(self, config):
        super(LayoutManager, self).__init__()
        self.config = config

    def cmd_increase_nmaster(self, n=1):
        current_nmaster = self.config['active_window']['nmaster']
        target_nmaster = max(1, current_nmaster + n)
        self.config['active_window']['nmaster'] = target_nmaster
        self.on_layout_change()

    def cmd_decrease_nmaster(self, n=1):
        self.cmd_increase_nmaster(-n)

    def _update_last_pane_status(self):
        pane_status = get_panes_status()
        active_pane = pane_status['active_pane']
        active_window = self.config['active_window']

        if active_pane['pane_index'] < active_window['nmaster']:
            self.config['active_window']['last_master_pane_id'] = active_pane['pane_id']
        else:
            self.config['active_window']['last_non_master_pane_id'] = active_pane['pane_id']

    def before_select_pane(self):
        """record last pane id of current_window"""
        self._update_last_pane_status()

    def pane_exited(self):
        self.on_layout_change()

        # update pane status

        pane_status = get_panes_status()
        active_pane = pane_status['active_pane']
        active_window = self.config['active_window']
        nmaster = active_window['nmaster']

        last_master_pane_id_found = False
        last_non_master_pane_id_found = False
        for pane in pane_status['panes']:
            if pane['pane_id'] == self.config['active_window']['last_master_pane_id'] and pane['pane_index'] < nmaster:
                last_master_pane_id_found = True
            if pane['pane_id'] == self.config['active_window']['last_non_master_pane_id'] and pane['pane_index'] >= nmaster:
                last_non_master_pane_id_found = True

        if not last_master_pane_id_found:
            self.config['active_window']['last_master_pane_id'] = None
        if not last_non_master_pane_id_found:
            self.config['active_window']['last_non_master_pane_id'] = None

    def cmd_swap_pane_with_master(self):
        pane_status = get_panes_status()
        panes = pane_status['panes']
        active_pane = pane_status['active_pane']

        active_window = self.config['active_window']
        nmaster = active_window['nmaster']

        src_pane_id = active_pane['pane_id']
        if active_pane['pane_index'] < nmaster:
            # active pane is master window, swap with last pane
            last_pane_id = active_window['last_non_master_pane_id']
            if last_pane_id is not None or len(panes) > nmaster:
                # last pane exist, or pane number > nmaster
                dst_pane_id = last_pane_id if last_pane_id is not None else panes[nmaster]['pane_id']
                subprocess.run(['tmux', 'swap-pane', '-s', src_pane_id, '-t', dst_pane_id])
                self.config['active_window']['last_non_master_pane_id'] = src_pane_id
        else:
            # active pane is not master
            last_pane_id = active_window['last_master_pane_id']
            dst_pane_id = last_pane_id if last_pane_id is not None else panes[0]['pane_id']
            subprocess.run(['tmux', 'swap-pane', '-s', dst_pane_id, '-t', src_pane_id])
            self.config['active_window']['last_non_master_pane_id'] = dst_pane_id

    def before_split_window(self):
        self._update_last_pane_status()
        pane_status = get_panes_status()
        active_pane = pane_status['active_pane']

    def after_split_window(self):
        pane_status = get_panes_status()
        active_pane = pane_status['active_pane']

        self._update_last_pane_status()
        if active_pane['pane_index'] >= self.config['active_window']['nmaster']:
            self.cmd_swap_pane_with_master()
        self.on_layout_change()

    def on_layout_change(self):
        reconstruct(self.config)

    def cmd_next_layout(self):
        index = LAYOUTS.index(self.config['active_window']['layout'])
        self.config['active_window']['layout'] = LAYOUTS[(index+1) % len(LAYOUTS)]
        self.on_layout_change()

    def cmd_increase_mfact(self, n):
        win = self.config['active_window']
        if win['layout'] == 'horizontal':
            new_fact = max(2, win['width'] * win['mfact'] + n) / win['width']
        elif win['layout'] == 'vertical':
            new_fact = max(2, win['height'] * win['mfact'] + n) / win['height']
        else:
            return

        new_fact = max(0.01, min(new_fact, 0.99))
        win['mfact'] = new_fact
        self.on_layout_change()
    def cmd_decrease_mfact(self, n):
        self.cmd_increase_mfact(-n)

    def after_resize_pane(self):
        win = self.config['active_window']
        if win['num_panes'] <= win['nmaster']:
            return

        root = parse_layout(win['layout_string'])
        if win['layout'] == 'horizontal':
            new_fact = root.children[0].width / root.width
        elif win['layout'] == 'vertical':
            new_fact = root.children[0].height / root.height
        win['mfact'] = new_fact

if __name__ == '__main__':

    config = load_config()
    layout_manager = LayoutManager(config)

    if len(sys.argv) == 1:
        layout_manager.on_layout_change()
    elif sys.argv[1] == 'increase-nmaster':
        try:
            n = int(sys.argv[2])
        except:
            n = 1
        layout_manager.cmd_increase_nmaster(n)
    elif sys.argv[1] == 'decrease-nmaster':
        try:
            n = int(sys.argv[2])
        except:
            n = 1
        layout_manager.cmd_decrease_nmaster(n)
    elif sys.argv[1] == 'increase-mfact':
        try:
            n = int(sys.argv[2])
        except:
            n = 2
        layout_manager.cmd_increase_mfact(n)
    elif sys.argv[1] == 'decrease-mfact':
        try:
            n = int(sys.argv[2])
        except:
            n = 2
        layout_manager.cmd_decrease_mfact(n)
    elif sys.argv[1] == 'before-select-pane':
        layout_manager.before_select_pane()
    elif sys.argv[1] == 'pane-exited':
        layout_manager.pane_exited()
    elif sys.argv[1] == 'swap-master':
        layout_manager.cmd_swap_pane_with_master()
    elif sys.argv[1] == 'before-split-window':
        layout_manager.before_split_window()
    elif sys.argv[1] == 'after-split-window':
        layout_manager.after_split_window()
    elif sys.argv[1] == 'next-layout':
        layout_manager.cmd_next_layout()
    elif sys.argv[1] == 'after-resize-pane':
        layout_manager.after_resize_pane()

    save_config(config)
