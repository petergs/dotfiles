-- Setup Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    'ts_ls',
    'eslint',
    'rust_analyzer',
    --'pyright',
    'lua_ls',
    'gopls',
    'ruff'
  }
})

-- Setup completion
local cmp = require('cmp')
cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

-- Add LSP capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Common on_attach function for keybindings
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>rr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
end

-- Configure LSP servers using the new API
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

vim.lsp.config('rust_analyzer', {
  cmd = { 'rust-analyzer' },
  root_markers = { 'Cargo.toml', 'rust-project.json' },
  capabilities = capabilities,
  on_attach = on_attach,
})

-- vim.lsp.config('pyright', {
--   cmd = { 'pyright-langserver', '--stdio' },
--   root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json' },
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })

vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  root_markers = { 'go.work', 'go.mod', '.git' },
  capabilities = capabilities,
  on_attach = on_attach,
})

vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  capabilities = capabilities,
  on_attach = on_attach,
})

vim.lsp.config('eslint', {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  root_markers = { '.eslintrc', '.eslintrc.js', '.eslintrc.json', 'eslint.config.js', 'package.json' },
  capabilities = capabilities,
  on_attach = on_attach,
})

vim.lsp.config('ruff', {
  init_options = {
    settings = {
      organizeImports = true,
      fixAll = true,
    }
  }
})

-- Enable the LSP servers
vim.lsp.enable('lua_ls')
vim.lsp.enable('rust_analyzer')
-- vim.lsp.enable('pyright')
vim.lsp.enable('gopls')
vim.lsp.enable('ts_ls')
vim.lsp.enable('eslint')
 vim.lsp.enable('ruff')

-- autocmd
-- format on save for Python files
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    vim.lsp.buf.format({
      filter = function(client)
        return client.name == "ruff"
      end,
    })
  end,
})
