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
            local default_lsp_opts = {
                on_attach = function()
                    vim.diagnostic.config({ severity_sort = true })
                end,
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            }

            require("mason-lspconfig").setup(opts)
            require("mason-lspconfig").setup_handlers({
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a deticated handler.
                function(server_name)
                    require("lspconfig")[server_name].setup(default_lsp_opts)
                end,

                -- Custom setup for clangd to set worker count to not get kicked
                ["clangd"] = function()
                    local clangcmd = { "clangd" }
                    if vim.fn.hostname():find(".cs.purdue.edu", 1, true) ~= nil then
                        clangd_cmd = { "clangd", "-j", "8" }
                    end
                    local clangd_opts = vim.tbl_extend('force', default_lsp_opts, {
                        cmd = clangd_cmd,
                    })
                    require("lspconfig").clangd.setup(clangd_opts)
                end,

                -- Configure LuaLS to recognize Neovim globals.
                -- Taken from https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
                ["lua_ls"] = function()
                    local luals_opts = vim.tbl_extend('force', default_lsp_opts, {
                        on_init = function(client)
                            if client.workspace_folders then
                                local path = client.workspace_folders[1].name
                                vim.print(path)
                                if
                                    path ~= vim.fn.stdpath("config")
                                    and (
                                        vim.uv.fs_stat(path .. "/.luarc.json")
                                        or vim.uv.fs_stat(path .. "/.luarc.jsonc")
                                    )
                                then
                                    return
                                end
                            end

                            client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                                runtime = {
                                    -- Tell the language server which version of Lua you're using
                                    -- (most likely LuaJIT in the case of Neovim)
                                    version = "LuaJIT",
                                },
                                -- Make the server aware of Neovim runtime files
                                workspace = {
                                    checkThirdParty = false,
                                    -- Faster but doesn't include plugin configs
                                    -- library = {
                                    --     vim.env.VIMRUNTIME,
                                    --     -- Depending on the usage, you might want to add additional paths here.
                                    --     -- "${3rd}/luv/library"
                                    --     -- "${3rd}/busted/library",
                                    -- },
                                    library = vim.api.nvim_get_runtime_file("", true),
                                },
                            })
                        end,
                        settings = {
                            Lua = {},
                        },
                    })
                    require("lspconfig").lua_ls.setup(luals_opts)
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
