export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
export EDITOR=nvim

if [[ ! -a "$HOME/antigen" ]];then
	git clone "https://github.com/zsh-users/antigen.git" "$HOME/antigen"
fi

source $HOME/antigen/antigen.zsh
source $HOME/.aliases

expand-aliases() {
  unset 'functions[_expand-aliases]'
  functions[_expand-aliases]=$BUFFER
  (($+functions[_expand-aliases])) &&
    BUFFER=${functions[_expand-aliases]#$'\t'} &&
    CURSOR=$#BUFFER
  zle && zle redisplay
}
# transparently use kitty's ssh kitten when available
ssh() {
  if command -v kitty &> /dev/null
  then
	  kitty +kitten ssh "$@"
  else
	  command ssh "$@"
  fi
}

# countdown timer
function countdown(){
   date1=$((`date +%s` + $1)); 
   while [ "$date1" -ge `date +%s` ]; do 
     echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     sleep 0.1
   done
}


# Load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
    # oh-my-zsh plugins (TODO: migrate away from oh-my-zsh)
    git

    # Syntax highlighting bundle.
    zdharma/fast-syntax-highlighting --branch=main

    # Fish-like auto suggestions
    zsh-users/zsh-autosuggestions

    # Extra zsh completions
    zsh-users/zsh-completions
EOBUNDLES

if [ -f "$HOME/../usr/share/fzf/key-bindings.zsh" ];then
	antigen bundle "$HOME/../usr/share/fzf" "key-bindings.zsh"
elif [ -f "/usr/share/fzf/key-bindings.zsh" ];then
		antigen bundle "/usr/share/fzf" "key-bindings.zsh"
elif [ -f "/usr/share/doc/fzf/key-bindings.zsh" ];then
	antigen bundle "/usr/share/doc/fzf" "key-bindings.zsh"
fi

# Load the theme
antigen theme "$HOME" sonks.zsh-theme --no-local-clone

ZSH_AUTOSUGGEST_STRATEGY=completion
ZSH_AUTOSUGGEST_MAX_BUFFER_SIZE=100
ZSH_AUTOSUGGEST_USE_ASYNC=1
REPORTTIME=10

# Tell antigen that you're done
antigen apply

[[ $commands[thefuck] ]] && eval $(thefuck --alias)

alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

unsetopt nomatch


yayfzf () {
	yay -Slq | fzf --multi --preview 'yay -Sii {1}' --query "$*" | xargs -ro yay -S
}

yayrm () {
	yay -Qeq | fzf --multi --preview 'yay -Sii {1}' --query "$*" | xargs -ro yay -D --asdeps ; yay -Qddtq | yay -Rs -
}

zle -N expand-aliases
bindkey '^E' expand-aliases
bindkey '^H' backward-kill-word
