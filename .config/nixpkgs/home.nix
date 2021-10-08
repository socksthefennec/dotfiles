{ config, pkgs, ... }:
let
  material-vim = pkgs.vimUtils.buildVimPlugin {
    name = "material.vim";
    src = pkgs.fetchFromGitHub {
      owner = "kaicataldo";
      repo = "material.vim";
      rev = "3b8e2c32e628f0ef28771900c6d83eb003053b91";
      sha256 = "1wi1brm1yml4xw0zpc6q5y0ql145v1hw5rbbcsgafagsipiz4av3";
    };
  };
in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "socks";
    homeDirectory = "/home/socks";
    packages = with pkgs; [ git nixfmt ];
    sessionVariables = { EDITOR = "nvim"; };
    # language.base = "en_AU.UTF-8";
  };
  programs = {
    zsh = {
      enable = false;
      # enable = true;
      # initExtra = ''
      #   if [[ ! -a "''$HOME/antigen" ]];then
      #     git clone "https://github.com/zsh-users/antigen.git" "''$HOME/antigen"
      #   fi
      #   
      #   source ''$HOME/antigen/antigen.zsh
      #   source ''$HOME/.aliases
      #   
      #   expand-aliases() {
      #     unset 'functions[_expand-aliases]'
      #     functions[_expand-aliases]=''$BUFFER
      #     ((''$+functions[_expand-aliases])) &&
      #       BUFFER=''${functions[_expand-aliases]#''$'\t'} &&
      #       CURSOR=''$#BUFFER
      #   }
      #   # transparently use kitty's ssh kitten when available
      #   ssh() {
      #     if command -v kitty &> /dev/null
      #     then
      #   	  kitty +kitten ssh "''$@"
      #     else
      #   	  command ssh "''$@"
      #     fi
      #   }
      #   
      #   # countdown timer
      #   function countdown(){
      #      date1=''$((`date +%s` + ''$1)); 
      #      while [ "''$date1" -ge `date +%s` ]; do 
      #        echo -ne "''$(date -u --date @''$((''$date1 - `date +%s`)) +%H:%M:%S)\r";
      #        sleep 0.1
      #      done
      #   }
      #   
      #   zle -N expand-aliases
      #   bindkey '\e^E' expand-aliases
      #   
      #   # Load the oh-my-zsh's library
      #   antigen use oh-my-zsh
      #   
      #   antigen bundles <<EOBUNDLES
      #       # oh-my-zsh plugins (TODO: migrate away from oh-my-zsh)
      #       git
      #   
      #       # Syntax highlighting bundle.
      #       zdharma/fast-syntax-highlighting
      #   
      #       # Fish-like auto suggestions
      #       zsh-users/zsh-autosuggestions
      #   
      #       # Extra zsh completions
      #       zsh-users/zsh-completions
      #   EOBUNDLES
      #   
      #   if [ -f "''$HOME/../usr/share/fzf/key-bindings.zsh" ];then
      #   	antigen bundle "''$HOME/../usr/share/fzf" "key-bindings.zsh"
      #   elif [ -f "/usr/share/fzf/key-bindings.zsh" ];then
      #   		antigen bundle "/usr/share/fzf" "key-bindings.zsh"
      #   elif [ -f "/usr/share/doc/fzf/key-bindings.zsh" ];then
      #   	antigen bundle "/usr/share/doc/fzf" "key-bindings.zsh"
      #   fi
      #   
      #   # Load the theme
      #   antigen theme "''$HOME" sonks.zsh-theme --no-local-clone
      #   
      #   ZSH_AUTOSUGGEST_STRATEGY=completion
      #   ZSH_AUTOSUGGEST_MAX_BUFFER_SIZE=100
      #   ZSH_AUTOSUGGEST_USE_ASYNC=1
      #   
      #   # Tell antigen that you're done
      #   antigen apply
      #   
      #   [[ ''$commands[thefuck] ]] && eval ''$(thefuck --alias)
      #   
      #   alias dotfiles='git --git-dir=''$HOME/.dotfiles/ --work-tree=''$HOME'
      #   
      #   unsetopt nomatch
      #   
      #   
      #   yayfzf () {
      #   	yay -Slq | fzf --multi --preview 'yay -Sii {1}' --query "''$*" | xargs -ro yay -S
      #   }
      #   
      #   yayrm () {
      #   	yay -Qeq | fzf --multi --preview 'yay -Sii {1}' --query "''$*" | xargs -ro yay -D --asdeps ; yay -Qddtq | yay -Rs -
      #   }
      # '';
      # enableAutosuggestions = true;
      # enableCompletion = true;
      ## not available in 21.05
      # enableSyntaxHighlighting = true;
    };
    fzf = {
      enable = false;
      # enable = true;
      # enableZshIntegration = true;
    };
    neovim = {
      enable = true;
      extraConfig = ''
        set number
        set mouse=a
        set title
        set showtabline=2
        if (has('termguicolors'))
          set termguicolors
        endif
        colorscheme material
        let g:material_terminal_italics = 1
        let g:material_theme_style = 'default'
        let g:lightline = { 'colorscheme': 'material_vim' }
      '';
      plugins = with pkgs.vimPlugins; [
        vim-nix
        lightline-vim
        fzf-vim
        vim-gitgutter
        vim-polyglot
        tcomment_vim
        emmet-vim
        vim-surround
        vim-visual-multi
        material-vim
      ];
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
