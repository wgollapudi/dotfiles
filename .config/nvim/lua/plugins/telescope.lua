-- Telescope (nvim fuzzy finder)
return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = false,
    },

    -- Use Telescope for selection menus
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            telescope.load_extension("ui-select")
        end,
    },
}
