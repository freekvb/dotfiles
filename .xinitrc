#!/bin/sh

#-----------------------------------------------------------------------------#
# File:     ~/.xinitrc (archlinux @ 'silent')
# Date:     Thu 23 Apr 2020 12:05
# Update:   Thu 14 Oct 2021 20:33
# Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
#-----------------------------------------------------------------------------#


[ -f ~/.xprofile ] && . ~/.xprofile


# bspwm ##

#exec bspwm


## dwm ##

dwmblocks &
exec dwm

