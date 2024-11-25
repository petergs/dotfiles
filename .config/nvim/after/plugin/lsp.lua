local lsp = require('lsp-zero').preset({})

lsp.preset("recommended")

if package.loaded['lsp-zero'] then
    lsp.ensure_installed({
        'eslint',
        'rust_analyzer',
        'pyright',
        'lua_ls',
        'gopls'
    })

    -- (Optional) Configure lua language server for neovim
    require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
end

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup()
