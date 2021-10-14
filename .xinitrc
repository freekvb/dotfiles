#!/bin/sh

#-----------------------------------------------------------------------------#
# File:     ~/.xinitrc (archlinux @ 'silent')
# Date:     Thu 23 Apr 2020 12:05
# Update:   Sat 09 Oct 2021 02:51
# Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
#-----------------------------------------------------------------------------#


[ -f ~/.xprofile ] && . ~/.xprofile


## bspwm ##

#exec bspwm


## dwm ##

dwmblocks &
exec dwm

