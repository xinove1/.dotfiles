#!/usr/bin/env bash
BR="layout:     br"

if [ "$BR" = "$(setxkbmap -query | grep layout)" ]; then
    setxkbmap us -variant colemak_dh
   # setxkbmap dvorak
else
    setxkbmap br
fi
