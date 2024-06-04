#!/usr/bin/env bash
BR="layout:     br"

if [ "$BR" = "$(setxkbmap -query | grep layout)" ]; then
   # setxkbmap us -variant colemak_dh
   #setxkbmap -layout us,us -variant engrammer,basic 
    setxkbmap us -variant dvorak
else
    setxkbmap br
fi
setxkbmap -option caps:swapescape
setxkbmap -option escape:swapcaps
