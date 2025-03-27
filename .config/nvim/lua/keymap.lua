-- NOTE: Completion keybindings are in plugins/completions.lua
-- NOTE: Git hunk-editing keymaps are defined in plugins/git.lua

local function snackmap(lhs, func, desc, pickeropts)
    vim.keymap.set("n", lhs, function() Snacks.picker[func](pickeropts or {}) end, { desc = desc })
end

-- Search files
snackmap("<leader>ff",  "files",                 "Search files")
snackmap("<leader>fr",  "recent",                "Search recent files")
snackmap("<leader>fb",  "buffers",               "Search open buffers")
snackmap("<leader>ft",  "grep",                  "Search for text (live grep)")
snackmap("<leader>f:",  "command_history",       "Search command history")
snackmap("<leader>fn",  "notifications",         "Search notification history")
snackmap("<leader>fp",  "projects",              "Search projects")
snackmap("<leader>fc",  "files",                 "Search Neovim configuration files", { cwd = vim.fn.stdpath("config") })
snackmap("<leader>fh",  "help",                  "Search Neovim help pages")

-- Search Git
snackmap("<leader>fgf", "git_files",             "Search Git-tracked files")
snackmap("<leader>fgb", "git_branches",          "Search Git branches")
snackmap("<leader>fgl", "git_log",               "Search Git log")
snackmap("<leader>fgF", "git_log_file",          "Search Git log file")
snackmap("<leader>fgL", "git_log_line",          "Search Git log line")
snackmap("<leader>fgs", "git_status",            "Search Git status")
snackmap("<leader>fgS", "git_stash",             "Search Git stash")
snackmap("<leader>fgd", "git_diff",              "Search Git diff (hunks)")

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

-- Clear search highlighting
vim.keymap.set("n", "<leader>nh", "<cmd>nohlsearch<cr>", { desc = "Clear search highlighting" })
vim.keymap.set("n", "<leader>uh", "<cmd>set hlsearch!<cr>", { desc = "Toggle search highlighting" })

-- Surround character with spaces
vim.keymap.set("n", "<leader><space>", "i<esc>la <esc>h", { desc = "Surround character with spaces" })

-- Shortcuts to save or quit
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

-- Tab navigation
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "Create new tab" })
vim.keymap.set("n", "]t", "gt", { desc = "Move to next tab" })
vim.keymap.set("n", "[t", "gT", { desc = "Move to previous tab" })

-- Shorter command to launch Typst preview
vim.api.nvim_create_user_command("TP", "TypstPreview", { desc = "Same as :TypstPreview" })

-- Yank/paste to/from system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Reverse selected text
vim.keymap.set("v", "<leader>rv", 'c<c-r>=reverse(@")<cr><esc>')

-- Telescope shortcuts
-- local telescope_builtin = require("telescope.builtin")
-- vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = "(Find File) Search for file" })
-- vim.keymap.set('n', '<C-p>', telescope_builtin.find_files, { desc = "Search for file" })
-- vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = "(Find Buffer) Search in buffers" })
-- vim.keymap.set('n', '<leader>fg', telescope_builtin.git_files, { desc = "(Find Git) Search in Git-tracked files" })
-- vim.keymap.set('n', "<leader>ft", telescope_builtin.live_grep, { desc = "(Find Text) Search for text (live grep)" })

-- Neo-tree (file browser)
vim.keymap.set("n", "<leader>e", function() Snacks.explorer.reveal() end, { desc = "Open file browser" })
vim.keymap.set("n", "<C-e>", function() Snacks.explorer() end, { desc = "Toggle file browser" })
vim.keymap.set("n", "\\", function() Snacks.explorer() end, { desc = "Toggle file browser" })

-- LSP keybindings
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspKeybindings", { clear = true }),
    callback = function(env)
        -- Set omnifunc
        vim.bo[env.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Keybindings
        local map = function(lhs, rhs, desc)
            vim.keymap.set({ "n", "v" }, lhs, rhs, { buffer = env.buf, desc = desc })
        end
        -- Don't set this one for visual mode because it conflicts with the shift up keybind
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = env.buf, desc = "View hover documentation" })
        map("gd", function() Snacks.picker.lsp_definitions()      end, "Find definition")
        map("gD", function() Snacks.picker.lsp_declarations()     end, "Find declaration")
        map("gy", function() Snacks.picker.lsp_type_definitions() end, "Find type definition")
        map("gr", function() Snacks.picker.lsp_references()       end, "Find references")
        map("<leader>fs", function() Snacks.picker.lsp_symbols() end, "Search LSP symbols")
        map("<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end, "Search LSP workspace symbols")
        map("<leader>fe", function() Snacks.picker.diagnostics_buffer() end, "Search buffer diagnostics")
        map("<leader>fE", function() Snacks.picker.diagnostics() end, "Search diagnostics")
        map("<leader>ra", vim.lsp.buf.code_action, "Perform code action")
        map("<leader>rf", vim.lsp.buf.format, "Format code")
        map("<leader>rr", vim.lsp.buf.rename, "Rename symbol")

        -- Jump to diagnostics
        local genGotoDiag = function(direction, level)
            local func
            if direction == "next" then
                func = vim.diagnostic.goto_next
            else
                func = vim.diagnostic.goto_prev
            end
            return function()
                func({ severity = vim.diagnostic.severity[level] })
            end
        end
        map("]d", vim.diagnostic.goto_next, "Go to next diagnostic")
        map("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
        map("]e", genGotoDiag("next", "ERROR"), "Go to next error")
        map("[e", genGotoDiag("prev", "ERROR"), "Go to previous error")
        map("]w", genGotoDiag("next", "WARN"), "Go to next warning")
        map("[w", genGotoDiag("prev", "WARN"), "Go to previous warning")
        map("]h", genGotoDiag("next", "HINT"), "Go to next hint")
        map("[h", genGotoDiag("prev", "HINT"), "Go to previous hint")
    end,
})
