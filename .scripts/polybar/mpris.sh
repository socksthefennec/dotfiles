#!/bin/sh
_PLAYER=$(playerctl status -f {{playerName}})
ARTIST=$(playerctl metadata -f {{artist}})
TITLE=$(playerctl metadata -f {{title}})
case $_PLAYER in
spotify)
	PLAYER=阮
	;;
vlc)
	PLAYER=嗢
	;;
*)
	PLAYER=
	;;
esac

# printf "$PLAYER $ARTIST - $TITLE"
playerctl metadata -f ' {{playerName}}: {{artist}} - {{title}} [{{duration(position)}}/{{duration(mpris:length)}}]'
