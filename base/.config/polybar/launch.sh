#!/usr/bin/env sh
# Author: ibrahimbutt (https://www.ibrahimbutt.xyz)

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar > /dev/null; do sleep 1; done

# Launch bar
# Bar is the name set in the polybar config, so if you change it,1 you have to change it here too.
polybar bar