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

  -- Global mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  vim.keymap.set('n', '<space>o', vim.diagnostic.open_float)
  vim.keymap.set('n', '<space>k', vim.diagnostic.goto_prev)
  vim.keymap.set('n', '<space>j', vim.diagnostic.goto_next)
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
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', 'gK', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gk', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
      end, opts)
      vim.print("LSP attached.")
    end,
  })

  -- Finally, let's initialize the Elixir language server
  -- I'm proxying via a script that sets up asdf
  --local path_to_elixirls = vim.fn.expand("/Users/jacek.szarski/workspace/lib/elixir-ls/runners/0.18.0.sh")
  --local path_to_elixirls = vim.fn.expand("/Users/jacek.szarski/workspace/lib/elixir-ls/runners/1.13-25.1.sh")
  local path_to_elixirls = vim.fn.expand("/Users/jacek.szarski/workspace/lib/elixir-ls/runners/1.13-24.3.sh")

  -- Neovim doesn't support snippets out of the box, so we need to mutate the
  -- capabilities we send to the language server to let them know we want snippets.
  local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
  lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true
  -- tell nvim-cmp about our desired capabilities
  local capabilities = require("cmp_nvim_lsp").default_capabilities(lsp_capabilities)

  local lspconfig = require("lspconfig")
  lspconfig.elixirls.setup({
    cmd = { path_to_elixirls },
    capabilities = capabilities,
    root_dir = vim.fs.dirname(vim.fs.find({'.git'}, { upward = true })[1]),
    settings = {
      elixirLS = {
        -- I choose to disable dialyzer for personal reasons, but
        -- I would suggest you also disable it unless you are well
        -- acquainted with dialzyer and know how to use it.
        dialyzerEnabled = true,
        -- I also choose to turn off the auto dep fetching feature.
        -- It often get's into a weird state that requires deleting
        -- the .elixir_ls directory and restarting your editor.
        fetchDeps = false,
        suggestSpecs = true,
        autoBuild = true
      }
    }
  })
  vim.lsp.set_log_level('info')
  if vim.fn.has 'nvim-0.5.1' == 1 then
    require('vim.lsp.log').set_format_func(vim.inspect)
  end
EOF
