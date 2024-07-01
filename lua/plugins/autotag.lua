require('nvim-ts-autotag').setup()
vim.diagnostic.config({
    virtual_text = {
        spacing = 5,
        severity = {
            min = vim.diagnostic.severity.WARN,
        },
    },
    underline = true,
    update_in_insert = true,
})
