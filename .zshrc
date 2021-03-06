#-----------------------------------------------------------------------------#
# File:     ~.zshrc (archlinux @ 'silent'
# Date:     Thu 23 Apr 2020 12:02
# Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
#-----------------------------------------------------------------------------#


# enable colors
autoload -U colors && colors

# more colors in terminal
TERM=xterm-256color
# TERM=screen-256color


# load aliases and shortcuts if existent.
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"


# prompt
autoload -Uz promptinit
promptinit

# new line above prompt
NEWLINE=$'\n'

# left prompt
if [[ -n "$TMUX" ]]; then
    local LVL=$(($SHLVL - 3))
else
    local LVL=$(($SHLVL - 2))
fi
local SUFFIX=$(printf '%%F{white}\u276f%.0s%%f' {1..$LVL})
#PROMPT='${NEWLINE}%B%~  ${SUFFIX}  %b'
PROMPT='${NEWLINE} %B%~ %b%F{yellow}%B%(1j.*.)%(?..!)%b%f%B ${SUFFIX}  %b'

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
zstyle ':vcs_info:hg*:*' formats '(%m%b ) '
zstyle ':vcs_info:hg*:*' actionformats '(%b|%a%m ) '
zstyle ':vcs_info:hg*:*' branchformat '%b'
zstyle ':vcs_info:hg*:*' get-bookmarks true
zstyle ':vcs_info:hg*:*' get-revision true
zstyle ':vcs_info:hg*:*' get-mq false
zstyle ':vcs_info:hg*+gen-hg-bookmark-string:*' hooks hg-bookmarks
zstyle ':vcs_info:hg*+set-message:*' hooks hg-message

function +vi-hg-bookmarks() {
  emulate -L zsh
  if [[ -n "${hook_com[hg-active-bookmark]}" ]]; then
    hook_com[hg-bookmark-string]="${(Mj:,:)@}"
    ret=1
  fi
}

function +vi-hg-message() {
  emulate -L zsh

  # Suppress hg branch display if we can display a bookmark instead.
  if [[ -n "${hook_com[misc]}" ]]; then
    hook_com[branch]=''
  fi
  return 0
}

function +vi-git-untracked() {
  emulate -L zsh
  if [[ -n $(git ls-files --exclude-standard --others 2> /dev/null) ]]; then
    hook_com[unstaged]+="%F{blue} ●%f"
  fi
}


# history in cache directory:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=$HOME/.cache/zsh/history

# command execution time stamp shown in the history command output
HIST_STAMPS="dd.mm.yyyy"


# basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)                                   # Include hidden files.

# enable autosuggestions
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# autocd
setopt autocd

# autocorrection
setopt correctall

# ignore dot file names as spelling corrections
export CORRECT_IGNORE_FILE='.*'


# nvim mode
bindkey -v
export KEYTIMEOUT=1

# add shell hotkeys
bindkey -a '^l' clear
bindkey -a '^d' exit

# add missing nvim hotkeys
bindkey -a u undo
bindkey -a '^R' redo

# edit line in nvim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# nvim mode indicator
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
RPS1='$vcs_info_msg_0_''$(nvim_mode_prompt_info)'
RPS2=$RPS1


# exit shell with Ctrl+d
exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh

# cd & lsa
cdl() {
        cd "$@" && lsa;
}


# extract all compressed files with 'extract'
function extract {
 if [ -z "$1" ]; then
     # display usage if no parameters given
    echo "Usage: extract ."
 else
if [ -f $1 ] ; then
        # NAME=${1%.*}
        # mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2) tar xvjf ../$1 ;;
          *.tar.gz) tar xvzf ../$1 ;;
          *.tar.xz) tar xvJf ../$1 ;;
          *.lzma) unlzma ../$1 ;;
          *.bz2) bunzip2 ../$1 ;;
          *.rar) unrar x -ad ../$1 ;;
          *.gz) gunzip ../$1 ;;
          *.tar) tar xvf ../$1 ;;
          *.tbz2) tar xvjf ../$1 ;;
          *.tgz) tar xvzf ../$1 ;;
          *.zip) unzip ../$1 ;;
          *.Z) uncompress ../$1 ;;
          *.7z) p7zip ../$1 ;;
          *.xz) unxz ../$1 ;;
          *) echo "extract: '$1' - unknown archive method" ;;
        esac
else
echo "$1 - file does not exist"
    fi
fi
}


# color by 'wal'
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background
# ( ) #  hide shell job control messages
(cat $HOME/.cache/wal/sequences & )


## man colored in less
#man() {
#    LESS_TERMCAP_md=$'\e[01;31m' \
#    LESS_TERMCAP_me=$'\e[0m' \
#    LESS_TERMCAP_se=$'\e[0m' \
#    LESS_TERMCAP_so=$'\e[01;40;36m' \
#    LESS_TERMCAP_ue=$'\e[0m' \
#    LESS_TERMCAP_us=$'\e[01;32m' \
#    command man "$@"
#}


# fzf - alias: fz
fzf-locate() { xdg-open "$(locate "*" | fzf -e)" ;}
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf defaults
export FZF_DEFAULT_OPTS='--height 50% --margin=1,0,0,4 --reverse --no-info'
export FZF_DEFAULT_COMMAND='fd --no-ignore-vcs -H -E '.git/''
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# fzf and cd in directory - alias: fc
cd_with_fzf() {
    cd $HOME && cdl "$(fd -t d -H | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview")"
}

# fzf file and open with default app - alias: fo
open_with_fzf() {
    fd -t f -H -I "$1" | fzf -m --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 6 '$1' || rg --ignore-case --pretty --context 6 '$1' {}" --preview-window=right:60% --multi --select-1 --exit-0 | xargs -ro -d "\n" xdg-open 2>&-
}

# find a file or directory  and open it fzf → fd → nvim -- no args, looks in cwd - rg to highlight etc
fzf_open_with_nvim() {
	IFS=$'\n' files=($(fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 6 '$1' || rg --ignore-case --pretty --context 6 '$1' {}" --preview-window=right:60%  --query="$1" --multi --select-1 --exit-0))
	[[ -n "$files" ]] && ${EDITOR:-nvim} "${files[@]}"
}

# find all git repos, select one and cd to its parent dir
fcg() {
  local file
  local dir
  file=$(fd -H -g .git | fzf) && dir=$(dirname "$file") && cdl "$dir"
}

# find local nvim help
fin() {
  rg "$1" --ignore-case --files-with-matches --no-messages ~/Notes/ ~/.dotfiles/ ~/.config/nvim/ | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 6 '$1' || rg --ignore-case --pretty --context 6 '$1' {}" --preview-window=right:60% --multi --select-1 --exit-0
}

# for `fifo` grep- find-in-file(s)
fif() {
	if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
	rg --ignore-case --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 6 '$1' || rg --ignore-case --pretty --context 6 '$1' {}" --preview-window=right:60% --multi --select-1 --exit-0
}

# find in local nvim help using `fin`
fino() {
	local file
	file=$(fin $1)
	if [[ -n $file ]]
	then
		nvim $file -c /$1 -c 'norm! n zz'
	fi
}

# find in files - open in nvim - go to 1st search result
# vim - grep - takes a query to grep
fifo() {
	local file
	file=$(fif $1)
	if [[ -n $file ]]
	then
		nvim $file -c /$1 -c 'norm! n zz'
	fi
}

# fkill - kill processes - list only the ones you can kill.
fkill() {
	local pid
	if [ "$UID" != "0" ]; then
		pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
	else
		pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
	fi
	if [ "x$pid" != "x" ]
	then
		echo $pid | xargs kill -${1:-9}
	fi
}


duckgo () {
    declare url=$*
    lynx "https://duckduckgo.com/lite?q=$*"
}


# Set window title to command just before running it.
preexec() { printf "\x1b]0;%s\x07" "$1"; }

# Set window title to terninal (st) after returning from a command.
precmd() { printf "\x1b]0;%s\x07" "$TERM" }

