#!/bin/bash
mouse_location=$(xdotool getmouselocation)
mouse_x=$(echo $mouse_location | cut -d ' ' -f 1 | cut -d ':' -f 2)


if [[ $mouse_x -lt 1920 ]]; then
    xdotool mousemove 2840 600
else
    xdotool mousemove 960 600
fi

