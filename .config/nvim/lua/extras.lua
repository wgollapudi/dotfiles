-- Auto-correct common typos
vim.keymap.set("i", "ture", "true")
vim.keymap.set("i", "treu", "true")
-- ...

-- Easy C-style comments
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "java", "yacc" },
    callback = function()
        vim.keymap.set("ia", "com", "/* */<left><left><left>", {
            buffer = 0,
        })
    end,
})
