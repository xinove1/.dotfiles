#!/usr/bin/env sh
# xrandr --output HDMI-1 --mode 1920x1080 --left-of eDP-1
#xrandr --output HDMI-1 --off
setxkbmap -option caps:swapescape
setxkbmap -option escape:swapcaps
setxkbmap br
# slstatus &
emacs --daemon &
zellij a -b h
# nitrogen --restore &
# picom &
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"
#. "$HOME/.cargo/env"
