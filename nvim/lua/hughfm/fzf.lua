vim.keymap.set('n', '<leader>f', ':Files<CR>', { noremap = true, silent = true });
vim.keymap.set('n', '<leader>b', ':Buffers<CR> ', { noremap = true, silent = true });

-- vim.g.fzf_layout = { window = { width = 0.8, height = 0.5, highlight = "Comment" } };
--
-- vim.g.fzf_colors = {
--   fg = { "fg", "Normal" },
--   bg = { "bg", "Normal" },
--   hl = { "fg", "Comment" },
--   "fg+" = { "fg", "CursorLine", "CursorColumn", "Normal" },
--   "bg+" = { "bg", "CursorLine", "CursorColumn" },
--   "hl+" = { "fg", "Statement" },
--   info = { "fg", "PreProc" },
--   border = { "fg", "Ignore" },
--   prompt = { "fg", "Conditional" },
--   pointer = { "fg", "Exception" },
--   marker = { "fg", "Keyword" },
--   spinner = { "fg", "Label" },
--   header = { "fg", "Comment" },
-- };

vim.api.nvim_create_user_command('Files', "call fzf#vim#files(<q-args>, fzf#vim#with_preview('up:50%'), <bang>0)", { nargs = '?', bang = true, complete = 'dir' });
-- vim.api.nvim_create_user_command('Ag', "call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:50%'), <bang>0)", { nargs = '*', bang = true });
-- vim.api.nvim_create_user_command('Rg', "call fzf#vim#grep('rg --sort --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1, fzf#vim#with_preview('up:50%'), <bang>0)", { nargs = '*', bang = true });
