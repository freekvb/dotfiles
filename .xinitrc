#-----------------------------------------------------------------------------#
# File:     ~/.xinitrc (archlinux @ 'silent')
# Date:     Thu 23 Apr 2020 12:05
# Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
#-----------------------------------------------------------------------------#


xrandr --output HDMI-1 --mode 1920x1080
xsetroot -cursor_name left_ptr
setxkbmap -option caps:escape
xset dpms 600 600 600
xset r rate 600 50

udiskie &
dunst &
picom &
clipmenud &
mega-cmd-server &
unclutter --timeout 2 &


sxhkd &

exec bspwm

#slstatus &
##xsetroot -name "$( date +"%a %d %b %Y %H:%M" )"
#exec dwm
