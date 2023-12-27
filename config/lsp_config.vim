lua <<EOF
  -- Setup our autocompletion. These configuration options are the default ones
  -- copied out of the documentation.
  local cmp = require("cmp")

  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "vsnip" },
    },
    formatting = {
      format = require("lspkind").cmp_format({
        with_text = true,
        menu = {
          nvim_lsp = "[LSP]",
        },
      }),
    },
  })

  -- lsp mappings
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)



--  -- setup lexical LS
--  local lspconfig = require("lspconfig")
--  local configs = require("lspconfig.configs")
--
--  local lexical_config = {
--    filetypes = { "elixir", "eelixir", "heex" },
--    cmd = { "/Users/jacek.szarski/workspace/lib/lexical/_build/dev/package/lexical/bin/start_lexical.sh" },
--    settings = {},
--  }
--
--  if not configs.lexical then
--    configs.lexical = {
--      default_config = {
--        filetypes = lexical_config.filetypes,
--        cmd = lexical_config.cmd,
--        root_dir = function(fname)
--          return lspconfig.util.root_pattern(".git")(fname)
--        end,
--        -- optional settings
--        settings = lexical_config.settings,
--      },
--    }
--  end
--
--  lspconfig.lexical.setup({})

      
  -- setup elixir-ls LS
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  require('lspconfig').elixirls.setup {
    root_dir = vim.fs.dirname(vim.fs.find({'.git'}, { upward = true })[1]),
    cmd_env = { ASDF_DIR = "/usr/local/opt/asdf/libexec/" },
    cmd = { "/Users/jacek.szarski/workspace/lib/elixir-ls/rel/language_server.sh" };
    capabilities = capabilities
  }
      
EOF
