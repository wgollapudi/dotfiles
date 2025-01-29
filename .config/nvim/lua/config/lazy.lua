-- Bootstrap lazy.nvim
pcall(function()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
                { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                { out, "WarningMsg" },
                { "\nPress any key to exit..." },
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
        end
    end
    vim.opt.rtp:prepend(lazypath)

    -- Make sure to setup `mapleader` and `maplocalleader` before
    -- loading lazy.nvim so that mappings are correct.
    -- This is also a good place to setup other settings (vim.opt)
    vim.g.mapleader = " "
    vim.g.maplocalleader = "\\"

    -- Setup lazy.nvim
    require("lazy").setup({
        spec = {
            -- import your plugins
            { import = "plugins" },
            { "nvim-treesitter/nvim-treesitter", enabled = true },
            { "lewis6991/gitsigns.nvim", enabled = true },
            { "rose-pine/neovim", enabled = true },
            { 'nvim-telescope/telescope.nvim', enabled = true },
            { "nvim-telescope/telescope-ui-select.nvim", enabled = true },
            { "folke/which-key.nvim", enabled = true },
            { "echasnovski/mini.icons", enabled = true },
            { "chomosuke/typst-preview.nvim", enabled = true },
            { "williamboman/mason.nvim", enabled = true },
            { "folke/todo-comments.nvim" enabled = true },
        },
        -- Configure any other settings here. See the documentation for more details.
        -- colorscheme that will be used when installing plugins.
        install = { colorscheme = { "habamax" } },
        -- automatically check for plugin updates
        checker = { enabled = true },
        ui = { border = "rounded", },
    })
end)
