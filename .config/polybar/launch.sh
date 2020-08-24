#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep .1; done

export DEFAULT_TITLE=$(whoami)@$(hostnamectl --static)

# Launch Polybar, using default config location ~/.config/polybar/config
case $(hostname) in
	socks-laptop)
		export MONITOR=eDP-1
		polybar primary-top &
		polybar primary-bottom &
		;;
	socks-desktop)
		export MONITOR=HDMI-0
		polybar primary-top &
		polybar primary-bottom &
		export MONITOR=DP-0
		polybar secondary-top &
		polybar secondary-bottom &
		;;
	*)
		polybar primary-top &
		polybar primary-bottom &
		;;
esac

echo "Polybar launched..."
