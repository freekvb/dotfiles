#-----------------------------------------------------------------------------#
# File:     ~.config/zsh/.zshrc (archlinux @ 'silent'
# Date:     Thu 23 Apr 2020 12:02
# Update:   Thu 14 Oct 2021 17:09
# Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
#-----------------------------------------------------------------------------#


# load aliases and shortcuts if existent
[ -f "$HOME/.config/zsh/aliasrc" ] && source "$HOME/.config/zsh/aliasrc"

# load exports (default programs and paths) if existent
[ -f "$HOME/.config/zsh/exportrc" ] && source "$HOME/.config/zsh/exportrc"

# load fzf functions if existent
[ -f "$HOME/.config/zsh/fzfrc" ] && source "$HOME/.config/zsh/fzfrc"

# enable colors
autoload -U colors && colors

#{{{ prompt

# prompt
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

## random changing emojis in prompt
#declare -a PROMPTS
#PROMPTS=(
#    "😀"
#    "😎"
#    "😂"
#    "😘"
#    "😜"
#    "🤔"
#    "🙄"
#    "😞"
#)
#RANDOM=$$$(date +%s)
#EMOJI=${PROMPTS[$RANDOM % ${#RANDOM[*]}]}
#put "$EMOJI" in prompt after "{NEWLINE}"

local SUFFIX=$(printf '%%F{white}\u276f%.0s%%f' {1..$LVL})
#PROMPT='${NEWLINE}%B%~  ${SUFFIX}  %b'
PROMPT='${NEWLINE} %B%1~ %b%F{cyan}%B%(1j.*.)%(?..!)%b%f%B ${SUFFIX}  %b'

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

  # Suppress hg branch display if we can display a bookmark instead
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

# define right prompt, regardless of whether the theme defined it
RPS1='$vcs_info_msg_0_''$(nvim_mode_prompt_info)'
RPS2=$RPS1

#}}}

#{{{ history

# history in cache directory
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=$HOME/.cache/zsh/history

# command execution time stamp shown in the history command output
HIST_STAMPS="dd.mm.yyyy"

#}}}

#{{{ auto

# basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  '+l:|?=** r:|?=**'
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache
zmodload zsh/complist
compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION
_comp_options+=(globdots)                                   # Include hidden files

# enable autosuggestions
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# autocd
setopt autocd

# autocorrection
setopt correctall

# ignore dot file names as spelling corrections
export CORRECT_IGNORE_FILE='.*'

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

# edit line in nvim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

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

#}}}

##{{{ archives

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

##}}}

#{{{ color

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

#}}}

#{{{ misc

# exit shell with Ctrl+d
exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh

# cd & lsa
cdl() {
        cd "$@" && lsa;
}

# ddg search and open in lynx - alias: dg
duckgo () {
    declare url=$*
    lynx "https://duckduckgo.com/lite?q=$*"
}

# set window title to command just before running it
preexec() { printf "\x1b]0;%s\x07" "$1"; }

# set window title to terminal (st) after returning from a command
precmd() { printf "\x1b]0;%s\x07" "$TERM" }

#}}}

