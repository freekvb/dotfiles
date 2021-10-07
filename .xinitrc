#!/bin/sh

#-----------------------------------------------------------------------------#
# File:     ~/.xinitrc (archlinux @ 'silent')
# Date:     Thu 23 Apr 2020 12:05
# Update:   Fri 01 Oct 2021 20:06
# Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
#-----------------------------------------------------------------------------#


[ -f ~/.xprofile ] && . ~/.xprofile


### bspwm ##
#
#exec bspwm


## dwm ##

#while true; do
#    # Log stderror to a file
#    # dwm 2>> /tmp/dwm.log
#    # No error logging
#    dwm >/dev/null 2>&1
#done

#while :; do
#	ssh-agent dwm
#done

exec dwm

