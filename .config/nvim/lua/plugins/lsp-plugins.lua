local ensure_installed_lsps = {
    "lua_ls",
    "clangd",
    "texlab",
--    "typst-lsp", -- Install via Mason
--    "jedi-langauge-server" -- Install via Mason (":MasonInstall"), also requires python3-venv
}

local gen_null_ls_sources = function(null_ls)
    return {
        -- Stylua - formatter for Lua
        null_ls.builtins.formatting.styla,

        -- Typstfmt
        null_ls.builtins.formatting.typstfmt,
    }
end

return {
    -- Mason : package manager for LSPs
    {
        "williamboman/mason.nvim",
        config = true,
        opts = {
            ui = { border = "rounded" },
        },
    },

    -- Mason-lspconfig : Bridge between Mason and lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            -- lspconfig : LSP configurator
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = ensure_installed_lsps,
        },
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)
            require("mason-lspconfig").setup_handlers({
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a deticated handler.
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        on_attach = function()
                            vim.diagnostic.config({ severity_sort = true })
                        end,
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    })
                end,

                -- Custom setup for clangd to set worker count to not get kicked
                -- off of data.
                ["clangd"] = function()
                    local clangcmd = { "clangd" }
                    if string.find(vim.fn.hostname(), ".cs.purdue.edu", 1, true) ~= nil then
                        clangcmd = { "clangd", "-j", "8" }
                    end
                    require("lspconfig").clangd.setup({
                        on_attach = function()
                            vim.diagnostic.config({ severity_sort = true })
                        end,
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                        cmd = clangcmd,
                    })
                end,
            })
        end,
    },

    -- None-LS: Wraps non-LSP tools for use in Neovim
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = gen_null_ls_sources(null_ls),
            })
        end,
    },
}
