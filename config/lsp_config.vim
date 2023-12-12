lua <<EOF
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').elixirls.setup {
    -- Path for elixir-ls installed via HomeBrew
    cmd = {'/usr/local/Cellar/elixir-ls/0.17.10/bin/elixir-ls'},
--    root_dir = vim.fs.dirname(vim.fs.find({'.git', '.gitignore'}, { upward = true })[1]),
    capabilities = capabilities,
  }
EOF
