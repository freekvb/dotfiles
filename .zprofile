#-----------------------------------------------------------------------------#
# File:     ~/.zprofile (archlinux @ 'silent'
# Date:     Thu 23 Apr 2020 12:02
# Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
#-----------------------------------------------------------------------------#


#
# ~/.zprofile
#

[[ -f ~/.zshrc ]] && . ~/.zshrc

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

