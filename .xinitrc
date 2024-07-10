#!/bin/sh

#-----------------------------------------------------------------------------#
# File:     ~/.xinitrc (archlinux @ 'silent')
# Date:     Thu 23 Apr 2020 12:05
# Update:   Mon 08 Jul 2024 22:07
# Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
#-----------------------------------------------------------------------------#


[ -f ~/.xprofile ] && . ~/.xprofile


# after login
# start_dwm

dwmblocks & exec dwm-6.5
