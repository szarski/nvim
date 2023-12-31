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

  -- A callback that will get called when a buffer connects to the language server.
  -- Here we create any key maps that we want to have on that buffer.
  local on_attach = function(_, bufnr)
    local function map(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local map_opts = {noremap = true, silent = true}

    map("n", "df", "<cmd>lua vim.lsp.buf.formatting()<cr>", map_opts)
    map("n", "gd", "<cmd>lua vim.diagnostic.open_float()<cr>", map_opts)
    map("n", "dt", "<cmd>lua vim.lsp.buf.definition()<cr>", map_opts)
    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", map_opts)
    map("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<cr>", map_opts)
    map("n", "gK", "<cmd>lua vim.lsp.buf.signature_help()<cr>", map_opts)
    map("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>", map_opts)

    -- These have a different style than above because I was fiddling
    -- around and never converted them. Instead of converting them
    -- now, I'm leaving them as they are for this article because this is
    -- what I actually use, and hey, it works �\_(?)_/�.
      --  vim.cmd [[imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']]
      --  vim.cmd [[smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']]

      --  vim.cmd [[imap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']]
      --  vim.cmd [[smap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']]
      --  vim.cmd [[imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']]
      --  vim.cmd [[smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']]

      --  vim.cmd [[inoremap <silent><expr> <C-Space> compe#complete()]]
      --  vim.cmd [[inoremap <silent><expr> <CR> compe#confirm('<CR>')]]
      --  vim.cmd [[inoremap <silent><expr> <C-e> compe#close('<C-e>')]]
      --  vim.cmd [[inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })]]
      --  vim.cmd [[inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })]]
  end

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
    on_attach = on_attach,
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
