#!/bin/sh

#-----------------------------------------------------------------------------#
# File:     ~/.xinitrc (archlinux @ 'silent')
# Date:     Thu 23 Apr 2020 12:05
# Update:   Fri 01 Oct 2021 01:12
# Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
#-----------------------------------------------------------------------------#


[ -f ~/.xprofile ] && . ~/.xprofile


## dwm ##

# background
feh --no-fehbg --bg-fill '/home/fvb/Pictures/red_girl_mirror.jpg' &
# status bar
slstatus &

exec dwm


### bspwm ##
#
#exec bspwm

