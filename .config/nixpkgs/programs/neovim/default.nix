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
  programs.neovim.enable = false;
  # programs.neovim = {
  #   enable = true;
  #   extraConfig = ''
  #     set number
  #     set relativenumber
  #     set mouse=a
  #     set title
  #     set showtabline=2
  #     if (has('termguicolors'))
  #       set termguicolors
  #     endif
  #     colorscheme material
  #     " let g:material_terminal_italics = 1
  #     let g:material_theme_style = 'default'
  #     let g:lightline = { 'colorscheme': 'material_vim' }
  #     set noshowmode
  #
  #     lua <<EOF
  #       require'nvim-tree'.setup()
  #
  #       require'nvim-treesitter.configs'.setup {
  #         ensure_installed = "maintained",
  #         sync_install = false,
  #         ignore_install = {},
  #         highlight = {
  #           enable = true,
  #           disable = {},
  #         },
  #         indent = {
  #           enable = true
  #         },
  #       }
  #     EOF
  #     set foldmethod=expr
  #     set foldexpr=nvim_treesitter#foldexpr()
  #
  #     nnoremap <A-Up>   :<C-u>silent! move-2<CR>==
  #     nnoremap <A-Down> :<C-u>silent! move+<CR>==
  #     xnoremap <A-Up>   :<C-u>silent! '<,'>move-2<CR>gv=gv
  #     xnoremap <A-Down> :<C-u>silent! '<,'>move'>+<CR>gv=gv
  #   '';
  #   plugins = with pkgs.vimPlugins; [
  #     vim-nix
  #     lightline-vim
  #     fzf-vim
  #     vim-gitgutter
  #     vim-polyglot
  #     tcomment_vim
  #     emmet-vim
  #     vim-surround
  #     vim-visual-multi
  #     material-vim
  #     neoformat
  #     nvim-tree-lua
  #     # treesitter
  #     nvim-treesitter
  #     # nvim-cmp
  #     # cmp-treesitter
  #     # nvim-treesitter-textobjects
  #     # nvim-treesitter-refactor
  #     # nvim-treesitter-context
  #   ];
  # };
}
