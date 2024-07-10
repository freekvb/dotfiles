#-----------------------------------------------------------------------------#
# File:     ~/.config/zsh/.zprofile (archlinux @ 'silent')
# Date:     Thu 23 Apr 2020 12:02
# Update:   Mon 08 Jul 2024 21:51
# Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
#-----------------------------------------------------------------------------#


[[ -f "$HOME/.config/zsh/.zshrc" ]] && . "$HOME/.config/zsh/.zshrc"


# auto start x at login
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

