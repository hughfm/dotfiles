-- Automatically run :PackerCompile when this file changes
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup {
  function(use)
    use 'wbthomason/packer.nvim'
    use 'folke/lsp-colors.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use {
      'nvim-telescope/telescope.nvim',
      config = function()
        require('hughfm.telescope')
      end
    }
    use 'nvim-telescope/telescope-fzy-native.nvim'

    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require('hughfm.treesitter')
      end
    }
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    use {
      'neovim/nvim-lspconfig',
      config = function()
        require('hughfm.eslint')
        require('hughfm.lsp')
      end
    }
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-emoji'
    use {
      'hrsh7th/nvim-cmp',
      config = function()
        require('hughfm.cmp')
      end
    }

    -- search
    use '/usr/local/opt/fzf'
    use 'junegunn/fzf.vim'

    -- status/tabline
    use 'vim-airline/vim-airline'

    -- Git
    use 'airblade/vim-gitgutter' -- shows git status in sidebar
    use 'tpope/vim-fugitive' -- wrapper for git commands
    use 'tpope/vim-rhubarb'

    -- displays color previews for hex values like #c0ffee and rgb(100, 100, 100).
    use { 'rrethy/vim-hexokinase', run = 'make hexokinase' }

    -- shows contents of registers when you need it.
    use 'junegunn/vim-peekaboo'

    -- colors
    use 'morhetz/gruvbox'

    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'

    -- Load this last
    use 'ryanoasis/vim-devicons'
  end
}
