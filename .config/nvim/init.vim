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
Plug 'junegunn/vim-easy-align'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tomtom/tcomment_vim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'sainnhe/gruvbox-material'
Plug 'mattn/emmet-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'AndrewRadev/switch.vim'
Plug 'tpope/vim-surround'
Plug 'mg979/vim-visual-multi'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'SmiteshP/nvim-gps'
Plug 'romgrk/nvim-treesitter-context'
Plug 'sbdchd/neoformat'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'ray-x/cmp-treesitter'

call plug#end()

set completeopt=menu,menuone,noselect

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "css",
    "html",
    "javascript",
    "json",
    "json5",
    "lua",
    "make",
    "nix",
    "python",
    "rust",
    "scss",
    "typescript",
    "vim",
    "yaml"
    },
  highlight = {
    enable = true
    },
  indent = {
    enable = true
    },
  refactor = {
    highlight_definitions = {
      enable = true
      },
    highlight_current_scope = {
      enable = true
      },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr"
        }
      },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>"
        }
      }
    }
  }
require'nvim-gps'.setup()
require'treesitter-context'.setup{
enable = true
}
local cmp = require'cmp'
cmp.setup({
snippet = {
  -- REQUIRED - you must specify a snippet engine
  expand = function(args)
  vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
  end,
  },
mapping = {
  ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
  ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
  ['<C-e>'] = cmp.mapping({
  i = cmp.mapping.abort(),
  c = cmp.mapping.close(),
  }),
['<CR>'] = cmp.mapping.confirm({ select = true }),
},
  sources = cmp.config.sources({
  { name = 'vsnip' }, -- For vsnip users.
  }, {
  { name = 'buffer' },
  { name = 'treesitter' }
  })
})
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
    }
  })
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
  { name = 'path' }
  }, {
  { name = 'cmdline' }
  })
})
EOF
function! NvimGps() abort
  return luaeval("require'nvim-gps'.is_available()") ?
        \ luaeval("require'nvim-gps'.get_location()") : ''
  endf

  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()

  set number
  set relativenumber
  set mouse=a
  set title
  set showtabline=2


  if (has('termguicolors'))
    set termguicolors
  endif
  let g:material_terminal_italics = 1
  let g:material_theme_style = 'default'
  " let g:lightline = { 'colorscheme': 'material_vim' }
  colorscheme material

  " let g:gruvbox_material_background = 'soft'
  " let g:gruvbox_material_enable_italic = 1
  " colorscheme gruvbox-material

  noremap <C-/> Tcomment

  nnoremap <A-down> :m .+1<CR>
  nnoremap <A-up> :m .-2<CR>
  inoremap <A-down> <Esc>:m .+1<CR>gi
  inoremap <A-up> <Esc>:m .-2<CR>gi
  vnoremap <A-down> :m '>+1<CR>gv
  vnoremap <A-up> :m '<-2<CR>gv

  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)

  let g:lightline = {
        \ 'colorscheme': 'material_vim',
        \ 'active': {
          \   'left': [ [ 'mode', 'paste' ],
          \             [ 'readonly', 'filename', 'modified' ],
          \             [ 'gps' ] ]
          \ },
          \ 'component_function': {
            \   'filetype': 'MyFiletype',
            \   'fileformat': 'MyFileformat',
            \   'gps': 'NvimGps',
            \ },
            \ }
  set noshowmode

  function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
  endfunction

  function! MyFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
  endfunction

  "augroup fmt
  "  autocmd!
  "  autocmd BufWritePre * undojoin | Neoformat
  "augroup END

  " Enable alignment globally
  let g:neoformat_basic_format_align = 1

  " Enable tab to spaces conversion globally
  let g:neoformat_basic_format_retab = 1

  " Enable trimmming of trailing whitespace globally
  let g:neoformat_basic_format_trim = 1
