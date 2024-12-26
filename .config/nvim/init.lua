-- Load Vim settings/options
pcall(function()
    require("settings")
end)

-- Load plugins (using lazy.nvim)
pcall(function()
    require("config.lazy")
end)

-- Load keybindings
pcall (function()
    require("keymap")
end)
