#-----------------------------------------------------------------------------#
# File:     ~.config/zsh/.zshrc (archlinux @ 'silent')
# Date:     Sat 25 Mqy 2024 03:00
# Update:   Sun 16 Jun 2024 00:20
# Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
#-----------------------------------------------------------------------------#


# load aliases and shortcuts if existent
[ -f "$HOME/.config/zsh/aliasrc" ] && source "$HOME/.config/zsh/aliasrc"

# load exports (default programs and paths) if existent
[ -f "$HOME/.config/zsh/exportrc" ] && source "$HOME/.config/zsh/exportrc"

# load fzf functions if existent
[ -f "$HOME/.config/zsh/fzfrc" ] && source "$HOME/.config/zsh/fzfrc"
#[ -f "$HOME/.fzf/shell/completion.zsh" ] && source "$HOME/.fzf/shell/completion.zsh"
#[ -f "$HOME/.fzf/shell/key-bindings.zsh" ] && source "$HOME/.fzf/shell/key-bindings.zsh"
#[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

#eval "$(oh-my-posh init zsh --config ~/.config/omp/zen.toml)"

#{{{ zinit

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Completion styling
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
#zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
#zstyle ':completion:*' menu no
#zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
#zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

#}}}

#{{{ prompt

## prompt
autoload -Uz promptinit
promptinit

# new line above prompt
NEWLINE=$'\n'

# left prompt
if [[ -n "$TMUX" ]]; then
    local LVL=$(($SHLVL - 2))
else
    local LVL=$(($SHLVL - 1))
fi

#local SUFFIX=$(printf '%%F{white}\u276f%.0s%%f' {1..$LVL})
#PROMPT='${NEWLINE}  %B%~%b  %F{yellow}%B%(1j.*.)%(?..!)%b%f%B ${SUFFIX}  %b'
#PROMPT='${NEWLINE}  %B%~%b  %F{yellow}%B%(1j.*.)%(?..!)%b%f%B ▶  %b'
PROMPT='${NEWLINE}%B%~%b %F{yellow}%B%(1j.*.)%(?..!)%b%f%  '
#PROMPT='${NEWLINE}%F{red}%n%f  %B%~%b %F{yellow}%B%(1j.*.)%(?..!)%b%f%  '
#PROMPT='${NEWLINE}  %B%~%b  %F{yellow}%B%(1j.*.)%(?..!)%b%f%B   %b'

#PS1=$'${(r:$COLUMNS::_:)}'$'\n'$PS1

# right prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_

# vcs info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%F{green} ●%f"              # default 'S'
zstyle ':vcs_info:*' unstagedstr "%F{yellow} ●%f"           # default 'U'
zstyle ':vcs_info:*' use-simple false
zstyle ':vcs_info:git+set-message:*' hooks git-untracked
zstyle ':vcs_info:git*:*' formats '[%b%m%c%u ]'             # default ' (%s)-[%b]%c%u-'
zstyle ':vcs_info:git*:*' actionformats '[%b|%a%m%c%u ]'    # default ' (%s)-[%b|%a]%c%u-'
function +vi-git-untracked() {
  emulate -L zsh
  if [[ -n $(git ls-files --exclude-standard --others 2> /dev/null) ]]; then
    hook_com[unstaged]+="%F{blue} ●%f"
  fi
}

# Delay (in seconds) after which the command time is shown. Only integers
# allowed, set at `0` if you want to constantly show command time.
source ~/.config/zsh/zsh-command-time/zsh-command-time.plugin.zsh

# nvim mode indicator for in right prompt
# updates editor information when the keymap changes
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}
zle -N zle-keymap-select
function nvim_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/[% N]%}/(main|viins)/[% I]%}"
}

# define right prompt, regardless of whether the theme defined it
RPS1='%B$vcs_info_msg_0_''$(nvim_mode_prompt_info)'
RPS2=$RPS1

#}}}

#{{{ nvim mode

# nvim mode
bindkey -v
export KEYTIMEOUT=1

# add shell hotkeys
bindkey -a '^l' clear
bindkey -a '^d' exit

# add missing nvim hotkeys
bindkey -a u undo
bindkey -a '^R' redo

# edit line in nvim with ctrl-o
autoload edit-command-line; zle -N edit-command-line
bindkey '^o' edit-command-line

# unbind ctrl-e and ctrl-y
bindkey -r '^E'
bindkey -r '^Y'

#}}}

#{{{ history

# History
HISTSIZE=5000
HISTFILE=~/.cache/zsh/zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

#}}}

#{{{ archives

## extract all compressed files with 'extract'
## usage: extract <file>
extract ()
{
        if [[ -f "$1" ]]
        then
                case "$1" in
                        *.tar.bz2)  bzip2 -v -d "$1" ;;
                        *.tar.gz)   tar -xvzf "$1"   ;;
                        *.tar.xz)   tar xvf "$1"     ;;
                        *.ace)      unace e "$1"     ;;
                        *.rar)      unrar x "$1"     ;;
                        *.deb)      ar -x "$1"       ;;
                        *.bz2)      bzip2 -d "$1"    ;;
                        *.lzh)      lha x "$1"       ;;
                        *.gz)       gunzip -d "$1"   ;;
                        *.tar)      tar -xvf "$1"    ;;
                        *.tgz)      gunzip -d "$1"   ;;
                        *.tbz2)     tar -jxvf "$1"   ;;
                        *.zip)      unzip "$1"       ;;
                        *.Z)        uncompress "$1"  ;;
                        *.shar)     sh "$1"          ;;
                        *)          echo "'"$1"' Error. Please go away" ;;
                esac
        else
                echo "'"$1"' is not a valid file"
        fi
}

# compress files or a directory (defaults to tar.gz)
# usage: compress <file> (<type>)
compress()
{
if [ '$2' ]; then
case '$2' in
tgz | tar.gz)   tar -zcvf$1.$2 '$1' ;;
tbz2 | tar.bz2) tar -jcvf$1.$2 '$1' ;;
                        tar.Z)          tar -Zcvf$1.$2 '$1' ;;
                        tar)            tar -cvf$1.$2  '$1' ;;
                        gz | gzip)      gzip           '$1' ;;
                        bz2 | bzip2)    bzip2          '$1' ;;
*)
echo "Error: $2 is not a valid compression type" ;;
esac
else
compress '$1' tar.gz
fi
}

# show archive without extracting
# usage: show <archive>
show()
{
        if [[ -f $1 ]]
        then
                case $1 in
                        *.tar.gz)      gunzip -c $1 | tar -tf - -- ;;
                        *.tar)         tar -tf $1 ;;
                        *.tgz)         tar -ztf $1 ;;
                        *.zip)         unzip -l $1 ;;
                        *.bz2)         bzless $1 ;;
                        *)             echo "'$1' Error. Please go away" ;;
                esac
        else
                echo "'$1' is not a valid archive"
        fi
}

#}}}

#{{{ color

# color the st (not linux) tty terminal
sd linux st $HOME/.cache/wal/colors-tty.sh

# color by 'wal'
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background
# ( ) #  hide shell job control messages
(cat $HOME/.cache/wal/sequences & )

# To add support for TTYs this line can be optionally added.
source $HOME/.cache/wal/colors-tty.sh

#}}}

#{{{ misc

# cd & lsa
cdl() {
        cd "$@" && lsa;
}

# ddg search and open in lynx
lxd () {
    declare url=$*
    lx "https://lite.duckduckgo.com/lite?kd=-1&kp=-1&q=$*"
}

# google search and open in lynx
lxg () {
    declare url=$*
    lx "https://google.com/search?q=$*"
}

# ddg search and open in w3m
w3d () {
    declare url=$*
    w3m "https://lite.duckduckgo.com/lite?kd=-1&kp=-1&q=$*"
}

# google search and open in w3m
w3g () {
    declare url=$*
    w3m "https://google.com/search?q=$*"
}

# set window title to command just before running it
preexec() { printf "\x1b]0;%s\x07" "$1"; }

# set window title to terminal (st) after returning from a command
precmd() { printf "\x1b]0;%s\x07" "$TERM" }

## icons for lf
#[ -f "$HOME/.config/lf/icons" ] && source "$HOME/.config/lf/icons"

#}}}

