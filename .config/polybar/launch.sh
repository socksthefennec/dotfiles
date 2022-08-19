#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep .1; done

export DEFAULT_TITLE=$(whoami)@$(hostnamectl --static)

# Launch Polybar, using default config location ~/.config/polybar/config
export MONITOR=eDP
polybar primary-top &
polybar primary-bottom &
# export MONITOR=DisplayPort-0
# polybar secondary-top &
# polybar secondary-bottom &

echo "Polybar launched..."
