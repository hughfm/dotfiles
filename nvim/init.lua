-- target: ~/.config/nvim/init.lua

local opt = vim.opt
local cmd = vim.cmd

cmd([[syntax enable]]) -- enables syntax highlighting
cmd([[filetype plugin indent on]]) -- enables filetype detection, and loads filetype plugin and indent files

cmd([[set backupdir=~/.local/share/nvim/backup]])
opt.backupcopy = 'auto' -- let vim decide how to write the backup file
opt.list = true -- show invisibles

opt.number = true
opt.relativenumber = true

opt.mouse = 'a' -- enable mouse support in all modes
opt.incsearch = true -- show pattern matches, as they are typed
opt.cursorline = true -- highlight current line
opt.termguicolors = true -- 24 bit color
opt.hidden = true -- allow buffers to become hidden when they are abandoned
opt.foldcolumn = '1' -- show folds in a single column on the left
opt.splitbelow = true --  new windows go below
opt.splitright = true --  new windows go to the right
opt.expandtab = true --  use spaces for tabs
opt.tabstop = 2 --  number of spaces to fill a tab
opt.shiftwidth = 0 --  use tabstop value for determining indentation spaces
opt.autoread = true --  automatically update buffer when file changes, if possible
opt.signcolumn = 'auto:3'

-- updatetime is set here to reduce the time for gitgutter to update
opt.updatetime = 200 -- ms to wait before writing swap file to disk.
opt.inccommand = 'nosplit' -- show substitution results incrementally

cmd([[match Todo /\s\+$/]]) -- highlight trailing whitespace with Todo group

vim.api.nvim_set_keymap('n', '<leader>d', ':bd<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>c', ':noh<CR>', {})

vim.opt.termguicolors = true
vim.o.background = "dark"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("hughfm.plugins")
vim.cmd([[colorscheme gruvbox]])

vim.g.markdown_fenced_languages = {
  "ts=typescript",
  "tsx=typescriptreact",
}
