{ pkgs, ... }:
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
  vim-hexedit = pkgs.vimUtils.buildVimPlugin {
    name = "vim-hexedit";
    src = pkgs.fetchFromGitHub {
      owner = "rootkiter";
      repo = "vim-hexedit";
      rev = "174dd836d49b0bd785647f0730ad4f98ad101377";
      sha256 = "0c7xwgdsyasksj0ga7jwq106gjsnvgrp1j2l3k3xr8bx7dwr8y5n";
    };
  };
in {
  home.packages = with pkgs; [ neovide ];
  programs.neovim = {
    enable = true;
    extraLuaConfig = ''
      vim.o.termguicolors = true
      vim.o.number = true
      vim.o.relativenumber = true
      vim.o.mouse = 'a'
      vim.o.title = true
      vim.o.showtabline = 2

      vim.o.tabstop = 2
      vim.o.shiftwidth = 2
      vim.o.expandtab = true
      vim.o.softtabspot = true
      vim.o.wrap = true
      vim.o.linebreak = true
      vim.o.breakindent = true

      if vim.g.neovide then
        vim.o.guifont = "Fira Code,Twemoji,Symbols Nerd Font:h12"
        vim.o.winblend = 20
        vim.o.pumblend = 20
      end

      vim.g.terminal_color_0  = '#263238'
      vim.g.terminal_color_1  = '#ff9800'
      vim.g.terminal_color_2  = '#8bc34a'
      vim.g.terminal_color_3  = '#ffc107'
      vim.g.terminal_color_4  = '#03a9f4'
      vim.g.terminal_color_5  = '#e91e63'
      vim.g.terminal_color_6  = '#009688'
      vim.g.terminal_color_7  = '#cfd8dc'
      vim.g.terminal_color_8  = '#37474f'
      vim.g.terminal_color_9  = '#ffa74d'
      vim.g.terminal_color_10 = '#9ccc65'
      vim.g.terminal_color_11 = '#ffa000'
      vim.g.terminal_color_12 = '#81d4fa'
      vim.g.terminal_color_13 = '#ad1457'
      vim.g.terminal_color_14 = '#26a69a'
      vim.g.terminal_color_15 = '#eceff1'

      vim.cmd([[
        " Shift selection
        nnoremap <silent> <A-down> :m .+1<CR>
        nnoremap <silent> <A-up> :m .-2<CR>
        inoremap <silent> <A-down> <Esc>:m .+1<CR>gi
        inoremap <silent> <A-up> <Esc>:m .-2<CR>gi
        vnoremap <silent> <A-down> :m '>+1<CR>gv
        vnoremap <silent> <A-up> :m '<-2<CR>gv
      ]])
    '';
    extraPackages = with pkgs; [ nixd fzf ];
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          local lsp_attach = function(client, bufnr)
            if client.server_capabilities.documentSymbolProvider then
              require'nvim-navic'.attach(client, bufnr)
            end
          end
          local lspconfig = require'lspconfig'
          lspconfig.nixd.setup {
            on_attach = lsp_attach
          }
        '';
      }
      nvim-navic
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          require'nvim-autopairs'.setup {
            map_cr = true
          }
        '';
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          require'telescope'.setup {
            defaults = {
              winblend = 20
            },
            extensions = {
              fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case"
              }
            }
          }
          require'telescope'.load_extension('fzf')

          vim.cmd([[
            nnoremap <silent> ff :Telescope find_files hidden=true<CR>
            nnoremap <silent> fb :Telescope buffers<CR>
          ]])
        '';
      }
      neoformat
      gitgutter
      vim-visual-multi
      vim-hexedit
      {
        plugin = tcomment_vim;
        config = ''
          noremap  <silent> <c-/> :TComment<cr>
          vnoremap <silent> <c-/> :TCommentMaybeInline<cr>
          inoremap <silent> <c-/> <c-o>:TComment<cr>
          '';
      }
      {
        plugin = material-vim;
        config = "colorscheme material";
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require'lualine'.setup {
            options = {
              theme = require'material.lualine',
              component_separators = {left = "|", right = "|"},
              section_separators = {left = "", right = ""},
            },
            sections = {
              lualine_a = {'mode'},
              lualine_b = {
                {'%R', cond = function() return vim.o.readonly end},
                {'filename', file_status = false, newfile_status = true},
                {'%M', cond = function() return vim.o.modified end},
                'branch', 'diff', 'diagnostics'
              },
              lualine_c = {},
              lualine_x = {'encoding', 'fileformat', 'filetype'},
              lualine_y = {'progress'},
              lualine_z = {'location'}
            },
            inactive_sections = {
              lualine_c = {
                {'%R', cond = function() return vim.o.readonly end},
                {'filename', file_status = false, newfile_status = true},
                {'%M', cond = function() return vim.o.modified end}
              },
              lualine_x = {'location'}
            },
            tabline = {
              lualine_c = {'navic'},
              lualine_z = {{'tabs', max_length = vim.o.columns, mode = 1}}
            }
          }
        '';
      }
    ];
  };
}
