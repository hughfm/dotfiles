-- target: ~/.config/nvim/lua/lsp.lua

local nvim_lsp = require('lspconfig')

-- Uncomment to enable logging
-- vim.lsp.set_log_level("debug")

-- Configure signs for diagnostic messages
for type, icon in pairs({ Error = "🙅", Warning = "😟", Hint = "🤫", Information = "💁" }) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Get capabilities from cmp, since it adds additional client capabilities
-- beyond the Neovim defaults.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local float_opts = { border = "double" }
vim.keymap.set('n', '<space>e', function() vim.diagnostic.open_float(float_opts) end)
vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev({ float = float_opts }) end)
vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next({ float = float_opts }) end)
vim.keymap.set('n', '[e', function() vim.diagnostic.goto_prev({ float = float_opts, severity = "ERROR" }) end)
vim.keymap.set('n', ']e', function() vim.diagnostic.goto_next({ float = float_opts, severity = "ERROR" }) end)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ border = "double" }) end, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format({
        async = false,
        timeout_ms = 5000,
        name = "null-ls",
      })
    end, opts)
  end,
})

-- Override floating window opts globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "double"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local servers = {
  "bashls",
  "cssls",
  "cssmodules_ls",
  "graphql",
  "html",
  "jsonls",
  "vimls",
  "jdtls",
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
  }
end

nvim_lsp.tsserver.setup {
  root_dir = nvim_lsp.util.root_pattern("tsconfig.json"),
  capabilities = capabilities,
  single_file_support = false,
}

nvim_lsp.eslint.setup {
  root_dir = nvim_lsp.util.root_pattern("tsconfig.json"),
  capabilities = capabilities,
}

nvim_lsp.denols.setup {
  init_options = {
    lint = true,
  },
  root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
  capabilities = capabilities,
  single_file_support = false,
}

nvim_lsp.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      telemetry = { enable = false },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = { '?.lua' },
      },
    },
  },
}

require('null-ls').setup({
  root_dir = require("null-ls.utils").root_pattern("package.json"),
  debug = true,
})
