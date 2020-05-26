#!/bin/sh
xinput set-prop "Apple Inc. Magic Trackpad 2" "libinput Natural Scrolling Enabled" 1
xrdb -merge ~/.Xresources
xrandr -s 3840x2160
exec i3
