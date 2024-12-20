return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require('hughfm.treesitter')
    end,
    dependencies = {
      'nvim-treesitter/playground',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('hughfm.lsp')
    end,
    dependencies = {
      'folke/lsp-colors.nvim',
    },
  },
  {
    'hrsh7th/nvim-cmp',
    config = function()
      require('hughfm.cmp')
    end,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-emoji',
      'hrsh7th/vim-vsnip',
      'onsails/lspkind.nvim',
    },
  },

  -- search
  'junegunn/fzf',
  'junegunn/fzf.vim',

  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, enabled = false },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require('hughfm.catppuccin')
    end
  },

  -- Git
  'airblade/vim-gitgutter', -- shows git status in sidebar
  {
    'tpope/vim-fugitive',
    dependencies = {
      'tpope/vim-rhubarb',
    },
  },

  -- displays color previews for hex values like #c0ffee and rgb(100, 100, 100).
  { 'rrethy/vim-hexokinase', build = 'make hexokinase' },

  -- shows contents of registers when you need it.
  'junegunn/vim-peekaboo',

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('hughfm.lualine')
    end,
  },

  'kyazdani42/nvim-web-devicons',

  {
    'ThePrimeagen/harpoon',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      require('hughfm.notify')
    end
  },
  'github/copilot.vim',
}
