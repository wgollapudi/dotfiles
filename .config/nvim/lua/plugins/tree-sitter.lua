local ensure_installed_parsers = {
    "lua",
    "javascript",
    "typescript",
    "python",
    "c",
    "vim",
    "vimdoc",
    "html",
    "css",
    "make",
    "bash",
    "json",
}

-- Tree-sitter (for syntax highlighting & indenting)
return {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = "VimEnter",
    build = ":TSUpdate",
    config = function()
        -- Set up parsers
        local tsconfig = require("nvim-treesitter.configs")
        tsconfig.setup({
            ensure_installed = ensure_installed_parsers,
            auto_install = true,
            highlight = { enable = true },
            indent = {
                enable = true,
                disable = { "typst" },
            },
        })
    end,
}
