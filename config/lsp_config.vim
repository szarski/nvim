lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    })
  })

  -- lsp mappings
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)


  -- setup lexical LS
  local lspconfig = require("lspconfig")
  local configs = require("lspconfig.configs")

  local lexical_config = {
    filetypes = { "elixir", "eelixir", "heex" },
    cmd = { "/Users/jacek.szarski/workspace/lib/lexical/_build/dev/package/lexical/bin/start_lexical.sh" },
    settings = {},
  }

  if not configs.lexical then
    configs.lexical = {
      default_config = {
        filetypes = lexical_config.filetypes,
        cmd = lexical_config.cmd,
        root_dir = function(fname)
          return lspconfig.util.root_pattern(".git")(fname)
        end,
        -- optional settings
        settings = lexical_config.settings,
      },
    }
  end

  lspconfig.lexical.setup({})

      
  -- setup elixir-ls LS
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  require('lspconfig').elixirls.setup {
    root_dir = vim.fs.dirname(vim.fs.find({'.git'}, { upward = true })[1]),
    cmd = { "/Users/jacek.szarski/workspace/lib/elixir-ls/rel/language_server.sh" };
    capabilities = capabilities
  }
      
EOF
