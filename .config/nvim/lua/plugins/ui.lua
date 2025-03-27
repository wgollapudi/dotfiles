return {
    {
        "j-hui/fidget.nvim",
        enabled = false,
        opts = {},
    },

    -- Smear cursor
    {
        "sphamba/smear-cursor.nvim",
        enabled = false,
        opts = {
            smear_insert_mode = false,
            vertical_bar_cursor_insert_mode = true,
            horizontal_bar_cursor_replace_mode = true,
            smear_to_cmd = false,
        },
    },

    -- Breadcrumbs bar
    {
        "Bekaboo/dropbar.nvim",
        config = function()
            local ok, dropbar_api = pcall(require, "dropbar.api")
            if not ok then
                vim.notify("dropbar.api failed to load", vim.log.levels.ERROR)
                return
            end

            if dropbar_api.pick then
                vim.keymap.set("n", "<leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
            end
            if dropbar_api.goto_content_start then
                vim.keymap.set("n", "[;", dropbar_api.goto_content_start, { desc = "Go to start of current context" })
            end
            if dropbar_api.select_next_context then
                vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
            end
        end,
    },

    -- folke's snacks
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            -- Pretty input UI
            input = { enabled = true },
            -- Smooth scrolling
            scroll = { enabled = true, animate = { easing = "outCubic" } },
            -- Indentation guides
            indent = { enabled = true },
            -- Pretty notifications
            notifier = { enabled = true },
            -- Pickers
            picker = {
                enabled = true,
                sources = {
                    explorer = {
                        jump = { close = true },
                        win = {
                            list = {
                                keys = {
                                    -- Opens explorer in new tab
                                    ["<c-t>"] = { "tab", mode = { "n", "i" } },
                                },
                            },
                        },
                    },
                    lsp_symbols = {
                        filter = {
                            default = true,
                        },
                    },
                    lsp_references = {
                        include_current = true,
                        include_declaration = true,
                    },
                },
            },
            -- File explorer
            explorer = { enabled = true, replace_netrw = true },
            -- Open files quickly
            quickfile = { enabled = true },
        },
    },

    -- Improvements for quickfix list
    {
        "stevearc/quicker.nvim",
        ft = { "qf" },
        -- Lazily load plugin on these keybindings
        keys = {
            {
                "<leader>q",
                function()
                    require("quicker").toggle()
                end,
                desc = "Toggle quickfix list",
            },
        },
        opts = {
            keys = {
                {
                    ">",
                    function()
                        require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
                    end,
                    desc = "Expand quickfix context",
                },
                {
                    "<",
                    function()
                        require("quicker").collapse()
                    end,
                    desc = "Collapse quickfix context",
                },
            },
        },
    },
}
