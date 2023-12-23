-- target: ~/.config/nvim/lua/lsp.lua

local nvim_lsp = require('lspconfig')
local util = require('vim.lsp.util')

vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]
vim.lsp.set_log_level("debug")

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = "了 ",
  EnumMember = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = "ﰮ ",
  Keyword = " ",
  Method = "ƒ ",
  Module = " ",
  Property = " ",
  Snippet = "﬌ ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

local kinds = vim.lsp.protocol.CompletionItemKind

for i, kind in ipairs(kinds) do
  kinds[i] = icons[kind] or kind
end

local common_on_attach = function(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap = true, silent = true }

  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float({ border = "double" })<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ popup_opts = { border = "double" } })<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ popup_opts = { border = "double" } })<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
end

local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

cmp_capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

local servers = {
  "bashls",
  "cssls",
  "cssmodules_ls",
  "graphql",
  "html",
  "jsonls",
  "vimls",
}

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = common_on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = cmp_capabilities,
    handlers = {
      ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, { border = "double" }),
      ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.hover, { border = "double" }),
      ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = {
          prefix = "■ ",
          spacing = 4,
        },
      }),
    },
  }
end

nvim_lsp.tsserver.setup {
  on_attach = common_on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  root_dir = nvim_lsp.util.root_pattern("tsconfig.json"),
  capabilities = cmp_capabilities,
  single_file_support = false,
  handlers = {
    ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, { border = "double" }),
    ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.hover, { border = "double" }),
    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = {
        prefix = "■ ",
        spacing = 4,
      },
    }),
  },
}

nvim_lsp.eslint.setup {
  on_attach = common_on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  root_dir = nvim_lsp.util.root_pattern("tsconfig.json"),
  capabilities = cmp_capabilities,
  settings = {
    format = false,
  },
  handlers = {
    ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, { border = "double" }),
    ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.hover, { border = "double" }),
    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = {
        prefix = "■ ",
        spacing = 4,
      },
    }),
  },
}

nvim_lsp.denols.setup {
  on_attach = common_on_attach,
  init_options = {
    lint = true,
  },
  root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = cmp_capabilities,
  handlers = {
    ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, { border = "double" }),
    ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.hover, { border = "double" }),
    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = {
        prefix = "■ ",
        spacing = 4,
      },
    }),
  },
}

nvim_lsp.lua_ls.setup {
  on_attach = common_on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = cmp_capabilities,
  handlers = {
    ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, { border = "double" }),
    ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.hover, { border = "double" }),
    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = {
        prefix = "■ ",
        spacing = 4,
      },
    }),
  },
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

local fmtCmd = os.getenv('EFM_FORMAT_COMMAND')

local efmConfig = {
  formatCommand = fmtCmd,
  formatStdin = true,
  rootMarkers = {
    "tsconfig.json",
    "package.json"
  },
}

local efm_languages = {
  typescript = { efmConfig },
  typescriptreact = { efmConfig }
}

nvim_lsp.efm.setup {
  root_dir = nvim_lsp.util.root_pattern(
    "tsconfig.json",
    "package.json"
  ),
  settings = {
    languages = efm_languages,
    log_level = 1,
    log_file = "~/efm.log",
  },
  filetypes = vim.tbl_keys(efm_languages),
  capabilities = cmp_capabilities,
  on_attach = function(client, bufnr)
    vim.keymap.set('n', '<space>f', function()
      local params = util.make_formatting_params({})
      client.request('textDocument/formatting', params, nil, bufnr)
    end, { buffer = bufnr })

    common_on_attach(client, bufnr)
  end,
}
