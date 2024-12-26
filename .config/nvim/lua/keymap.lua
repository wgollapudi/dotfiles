-- NOTE: Completion keybindings will be put in plugins/completions.lua
-- NOTE: Git hunk-editing keymaps are defined in plugins/git.lua

-- Allow capital versions of ':w', ':q', ':wq'
vim.api.nvim_create_user_command("W", "w", { desc = "Same as :w" })
vim.api.nvim_create_user_command("Q", "q", { desc = "Same as :q" })
vim.api.nvim_create_user_command("Wa", "wa", { desc = "Same as :wa" })
vim.api.nvim_create_user_command("WA", "wa", { desc = "Same as :wa" })
vim.api.nvim_create_user_command("Wq", "wq", { desc = "Same as :wq" })
vim.api.nvim_create_user_command("WQ", "wq", { desc = "Same as :wq" })
vim.api.nvim_create_user_command("Wqa", "wqa", { desc = "Same as :wqa" })
vim.api.nvim_create_user_command("WQa", "wqa", { desc = "Same as :wqa" })

-- Split pane navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Move to pane on left" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Move to pane right" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Move to pane above" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Move to pane on right" })

-- Toggle cursor line
vim.keymap.set("n", "<leader>cl", ":set cursorline!<CR>")

-- Toggle spell check
vim.keymap.set('n', '<leader>s', "<cmd>set spell!<cr>", { desc = "Toggle spell check" })

-- Make Y yank to the end of the line
vim.keymap.set("n", "Y", "y$")

-- Shortuts to save or quit
vim.keymap.set('n', '<leader>w', ":w<CR>", { desc = "Same as :w" })
vim.keymap.set('n', '<leader>ww', ":w<CR>", { desc = "Same as :w" })
vim.keymap.set('n', '<leader>q', ":q<CR>", { desc = "Same as :q" })

-- vim-easy-align keybindings
vim.keymap.set({ "n", "v"}, "ga", "<Plug>(EasyAlign)", { desc = "Enter EasyAlign" })

-- Shift lines up/down
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")

-- NetRW
vim.keymap.set('n', '<leader>rw', vim.cmd.Explore)

-- Telescope shortcuts
local telescope_builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = "(Find File) Search for file" })
vim.keymap.set('n', '<C-p>', telescope_builtin.find_files, { desc = "Search for file" })
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = "(Find Buffer) Search in buffers" })
vim.keymap.set('n', '<leader>fg', telescope_builtin.git_files, { desc = "(Find Git) Search in Git-tracked files" })
vim.keymap.set('n', "<leader>ft", telescope_builtin.live_grep, { desc = "(Find Text) Search for text (live grep)" })

-- vim: ft=lua sw=4 ts=4 et fdm=marker fmr={{{,}}} foldlevel=2
