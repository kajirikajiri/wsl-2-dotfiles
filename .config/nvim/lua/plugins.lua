-- This file can be loaded by calling `lua require('plugins')` from your init.vim

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
  use 'wbthomason/packer.nvim' -- package manager

  -- LSP: 言語サーバー
  use 'williamboman/mason.nvim' -- manage LSP, DAP, linter, formatter
  use 'williamboman/mason-lspconfig.nvim' -- config mason
  use 'neovim/nvim-lspconfig' -- enable LSP
  use 'jose-elias-alvarez/null-ls.nvim' -- manage linter, formatter

  -- Theme
  use 'folke/tokyonight.nvim'

  -- Icons
  use 'kyazdani42/nvim-web-devicons'

  -- Popup
  use 'nvim-lua/popup.nvim'

  -- Treesitter: 構文解析
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
	local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
	ts_update()
    end,
  }

  -- Telescope: ファイル検索、全文検索、開いてるファイル検索
  use 'nvim-lua/plenary.nvim' -- dependent on telescope
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- nvim-cmp: 入力補完
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'folke/neodev.nvim' -- Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.

  -- gitsigns: gitを表示する
  use {
	  'lewis6991/gitsigns.nvim', tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
  }

  -- nvim-tree: File explorer
  use {
	  'nvim-tree/nvim-tree.lua',
	  requires = {
		  'nvim-tree/nvim-web-devicons', -- optional, for file icons
	  },
	  tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- toggleterm: Terminal
  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
	  require("toggleterm").setup()
  end}

  -- project: project manager
  use {
	  "ahmedkhalf/project.nvim",
	  config = function()
		  require("project_nvim").setup {
			  -- your configuration comes here
			  -- or leave it empty to use the default settings
			  -- refer to the configuration section below
		  }
	  end
  }

  -- copilot
  use 'github/copilot.vim'

  -- which-key: キーバインドを表示する
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
    require("mason").setup()
    require("mason-lspconfig").setup()
  end
end)

