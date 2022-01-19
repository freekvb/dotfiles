#-----------------------------------------------------------------------------#
# File:     ~/.config/zsh/.zprofile (archlinux @ 'silent'
# Date:     Thu 23 Apr 2020 12:02
# Update:   Sun 16 Jan 2022 15:45
# Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
#-----------------------------------------------------------------------------#


[[ -f ~/.config/zsh/.zshrc ]] && . ~/.config/zsh/.zshrc


# auto start x at login
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

