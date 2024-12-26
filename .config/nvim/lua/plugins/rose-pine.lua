return {
    "rose-pine/neovim",
    name = "rose-pine",

    config = function()
        -- Enable background transparency
        require("rose-pine").setup({
            styles = {
                transparency = true,
            },
        })

        vim.cmd("colorscheme rose-pine")
    end
}
