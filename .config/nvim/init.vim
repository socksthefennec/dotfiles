" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

call plug#begin(stdpath('data') . '/plugged')

Plug 'junegunn/vim-plug'
Plug 'junegunn/fzf'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tomtom/tcomment_vim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'mattn/emmet-vim'

call plug#end()

set number
set mouse=a
set title
set showtabline=2

if (has('termguicolors'))
  set termguicolors
endif
let g:material_terminal_italics = 1
let g:material_theme_style = 'default'
let g:lightline = { 'colorscheme': 'material_vim' }
colorscheme material

noremap <C-/> Tcomment 
