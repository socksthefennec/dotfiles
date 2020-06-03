if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
[ -n "$XDG_CONFIG_HOME" ] || export XDG_CONFIG_HOME="$HOME/.config"
[ -n "$XDG_CACHE_HOME" ] || export XDG_CACHE_HOME="$HOME/.cache"
[ -n "$XDG_DATA_HOME" ] || export XDG_DATA_HOME="$HOME/.local/share"
export EDITOR=nano
