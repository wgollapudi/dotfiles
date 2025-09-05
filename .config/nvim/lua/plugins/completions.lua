---@type LazySpec[]
return {
    {
        "hrsh7th/nvim-cmp",
        lazy = true,
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            { "echasnovski/mini.pairs", optional = true },
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup(
                ---@type cmp.ConfigSchema
                {
                    snippet = {
                        -- REQUIRED - you must specify a snippet engine
                        expand = function(args)
                            vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                        end,
                    },
                    window = {
                        completion = cmp.config.window.bordered(),
                        documentation = cmp.config.window.bordered(),
                    },
                    mapping = cmp.mapping.preset.insert({
                        -- TODO: Put these in keymap.lua
                        ["<C-k>"] = cmp.mapping.scroll_docs(-4),
                        ["<C-j>"] = cmp.mapping.scroll_docs(4),
                        ["<C-Space>"] = cmp.mapping.complete(),
                        ["<C-e>"] = cmp.mapping.abort(),
                        ["<CR>"] = function(fallback)
                            if cmp.visible() and cmp.get_selected_entry() ~= nil then
                                -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                                cmp.confirm({ select = false })
                            else
                                fallback()
                            end
                        end,
                        ["<C-d>"] = function()
                            if cmp.visible_docs() then
                                cmp.close_docs()
                            else
                                cmp.open_docs()
                            end
                        end,
                    }),
                    sources = cmp.config.sources({
                        { name = "nvim_lsp" },
                    }, {
                        { name = "buffer" },
                    }),
                    experimental = {
                        ghost_text = true,
                    },
                }
            )
        end,
    },
    -- LSP completion source
    {
        "hrsh7th/cmp-nvim-lsp",
        lazy = true,
        config = function()
            vim.lsp.config("*", {
                capabilities = {
                    require("cmp_nvim_lsp").default_capabilities(),
                },
            })
        end,
    },
}
