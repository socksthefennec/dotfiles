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

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use {'socksthefennec/material.vim', branch = 'lualine' }
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'} -- We recommend updating the parsers on update
  use 'SmiteshP/nvim-gps'
  use 'tomtom/tcomment_vim'
  use 'jlanzarotta/bufexplorer'
  -- use 'junegunn/fzf'
  -- use 'junegunn/vim-easy-align'
  -- use 'airblade/vim-gitgutter'
  -- use 'sheerun/vim-polyglot'
  -- use 'mattn/emmet-vim'
  -- use 'AndrewRadev/switch.vim'
  -- use 'tpope/vim-surround'
  -- use 'mg979/vim-visual-multi'
  -- use 'romgrk/nvim-treesitter-context'
  -- use 'sbdchd/neoformat'
  -- use 'nvim-treesitter/nvim-treesitter-refactor'
  -- use 'neovim/nvim-lspconfig'
  -- use 'hrsh7th/cmp-buffer'
  -- use 'hrsh7th/cmp-path'
  -- use 'hrsh7th/cmp-cmdline'
  -- use 'hrsh7th/nvim-cmp'
  -- use 'hrsh7th/cmp-vsnip'
  -- use 'hrsh7th/vim-vsnip'
  -- use 'ray-x/cmp-treesitter'
  -- use 'rootkiter/vim-hexedit/'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
