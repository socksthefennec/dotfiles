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
  programs.neovim = {
    enable = true;
    extraConfig = ''
      set number
      set relativenumber
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
}
