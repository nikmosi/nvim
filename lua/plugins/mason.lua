require("mason").setup()
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'pyright', 'ruff_lsp', 'ansiblels' }, -- Example servers
})
