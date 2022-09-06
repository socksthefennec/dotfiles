require('plugins')

-- gps
require'nvim-gps'.setup()

-- treesitter
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
}

-- theme
vim.o.termguicolors = true
vim.g.material_terminal_italics = false
vim.g.material_theme_style = 'default'
vim.cmd('colorscheme material')

-- lualine
local gps = require'nvim-gps'
require'lualine'.setup {
  options = {
    theme = require'material.lualine',
    component_separators = { left = "|", right = "|"},
    section_separators = {left = "", right = "" },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      {'%R', cond = function() return vim.o.readonly end},
      {'filename', file_status = false, newfile_status = true},
      {'%M', cond = function() return vim.o.modified end}, 
      'branch', 'diff', 'diagnostics'
    },
    lualine_c = {{gps.get_location, cond = gps.is_available}}, 
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_c = {
      {'%R', cond = function() return vim.o.readonly end},
      {'filename', file_status = false, newfile_status = true},
      {'%M', cond = function() return vim.o.modified end}, 
    },
    lualine_x = {'location'},
  },
  tabline = {
    lualine_a = { {'tabs', mode = 2} },
    lualine_z = {'hostname'}
  }
}

-- misc settings
-- vim.o.foldmethod=expr
-- vim.o.foldexpr=nvim_treesitter#foldexpr()
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.title = true
vim.o.showtabline = 2
vim.o.showmode = false

-- keybinding
vim.cmd([[
  " Tcomment
  noremap  <silent> <c-/> :TComment<cr>
  vnoremap <silent> <c-/> :TCommentMaybeInline<cr>
  inoremap <silent> <c-/> <c-o>:TComment<cr>
  
  " Shift selection
  nnoremap <silent> <A-down> :m .+1<CR>
  nnoremap <silent> <A-up> :m .-2<CR>
  inoremap <silent> <A-down> <Esc>:m .+1<CR>gi
  inoremap <silent> <A-up> <Esc>:m .-2<CR>gi
  vnoremap <silent> <A-down> :m '>+1<CR>gv
  vnoremap <silent> <A-up> :m '<-2<CR>gv
  
  " BufExplorer
  nnoremap <silent> <F12> :BufExplorer<CR>
  " nnoremap <silent> <M-F12> :BufExplorer<CR>
  " nnoremap <silent> <F12> :bn<CR>
  " nnoremap <silent> <S-F12> :bp<CR>
]])
