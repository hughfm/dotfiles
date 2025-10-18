require('null-ls').setup({
  root_dir = require("null-ls.utils").root_pattern("package.json"),
  debug = true,
  default_timeout = 10000,
})
