if package.loaded['lsp-zero'] then
    local lsp = require('lsp-zero').preset({})

    lsp.preset("recommended")

    lsp.ensure_installed({
        'tsserver',
        'eslint',
        'rust_analyzer',
        'pyright',
        'lua_ls',
        'gopls'
    })

    lsp.on_attach(function(client, bufnr)
      lsp.default_keymaps({buffer = bufnr})
    end)

    -- (Optional) Configure lua language server for neovim
    require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

    lsp.setup()
end
