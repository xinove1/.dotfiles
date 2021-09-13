#!/usr/bin/env bash
BR="layout:     br"

if [ "$BR" = "$(setxkbmap -query | grep layout)" ]; then
    setxkbmap dvorak
else
    setxkbmap br
fi
