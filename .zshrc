if [[ ! -a "$HOME/antigen" ]];then
	git clone "https://github.com/zsh-users/antigen.git" "$HOME/antigen"
fi

source $HOME/antigen/antigen.zsh

# Load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
    # oh-my-zsh plugins (TODO: migrate away from oh-my-zsh)
    git
    fzf

    # Syntax highlighting bundle.
    zdharma/fast-syntax-highlighting

    # Fish-like auto suggestions
    zsh-users/zsh-autosuggestions

    # Extra zsh completions
    zsh-users/zsh-completions
EOBUNDLES

# Load the theme
antigen theme "$HOME" sonks.zsh-theme --no-local-clone

ZSH_AUTOSUGGEST_STRATEGY=completion
ZSH_AUTOSUGGEST_MAX_BUFFER_SIZE=100
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Tell antigen that you're done
antigen apply

[[ $commands[thefuck] ]] && eval $(thefuck --alias)

alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

unsetopt nomatch

