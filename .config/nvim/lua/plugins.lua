local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'eandrju/cellular-automaton.nvim'
  use 'ntpeters/vim-better-whitespace'
  -- use { "beauwilliams/focus.nvim", config = function() require("focus").setup() end }
  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use {'kaicataldo/material.vim', branch = 'main' }
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'} -- We recommend updating the parsers on update
  -- use 'SmiteshP/nvim-gps'
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  }
  use {
    "SmiteshP/nvim-navbuddy",
    requires = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      -- "numToStr/Comment.nvim",        -- Optional
      "nvim-telescope/telescope.nvim" -- Optional
    }
  }
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'tomtom/tcomment_vim'
  use 'jlanzarotta/bufexplorer'
  use 'Lokaltog/neoranger'
  use 'sbdchd/neoformat'
  use 'windwp/nvim-autopairs'
  use 'xuhdev/vim-latex-live-preview'
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    }
  }
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-surround'
  use 'mg979/vim-visual-multi'
  use 'rootkiter/vim-hexedit'

  -- use 'junegunn/fzf'
  -- use 'junegunn/vim-easy-align'
  -- use 'sheerun/vim-polyglot'
  -- use 'mattn/emmet-vim'
  -- use 'AndrewRadev/switch.vim'
  -- use 'romgrk/nvim-treesitter-context'
  -- use 'nvim-treesitter/nvim-treesitter-refactor'
  -- use 'hrsh7th/cmp-buffer'
  -- use 'hrsh7th/cmp-path'
  -- use 'hrsh7th/cmp-cmdline'
  -- use 'hrsh7th/nvim-cmp'
  -- use 'hrsh7th/cmp-vsnip'
  -- use 'hrsh7th/vim-vsnip'
  -- use 'ray-x/cmp-treesitter'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
