-- File type detection & syntax highlighting
vim.cmd( [[syntax on]] )
vim.cmd( [[filetype plugin indent on]] )

-- Enable true color support
vim.o.exrc = true
vim.o.secure = true

-- No need to be compatible with vi
vim.o.compatible = false

-- Use 4 spaces for indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Enable Nerd Font
vim.g.have_nerd_font = true;

vim.o.updatetime=4000

-- Don't highlight search results
vim.o.hlsearch = false

-- Keep the cursor away from the top/bottom edges
vim.o.scrolloff = 5

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Show substitutions live
vim.o.inccommand = "nosplit"

-- SEARCH SETTINGS --
-- {{{

-- Show search matches live
vim.o.incsearch = true

-- Ignore case (sometimes; see smartcase)
vim.o.ignorecase = true
vim.o.smartcase = true

-- Enable RegExp characters
vim.o.magic = true

-- }}}

-- Show matching braces while typing
vim.cmd( [[set showmatch mat=3]] )
vim.o.showmatch = true
vim.o.mat = 3

-- Detect external changes to open files
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
    command = "checktime",
})

-- Automatically save before certain commands
vim.o.autowrite = true

-- Enable mouse integration
vim.o.mouse = "a"
vim.o.mousemodel=extend

-- Search recursiely (up to 3 levels deep) for files
vim.opt.path:append({ "***3" })

-- Show current position within file
vim.o.ruler = true

-- Sync clipboard between OS and Neovim
-- Schedule the setting after 'UiEnter' because it can ncrease startup-time
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true;

-- Expand wildcards in command line
vim.o.wildmenu = true

-- No bells on error
vim.o.errorbells = false
vim.o.visualbell = true

-- Allow formatting numbered lists
vim.opt.formatoptions:append({ "n" })

-- Don't use two spaces when joining sentances
vim.o.joinspaces = false

-- Show leading/trailing whitespace
vim.o.list = true
vim.o.listchars = "tab:> ,trail:.,extends:>,precedes:<,nbsp:~"

-- Highlight trailing whitespace
vim.cmd( [[
    highlight TrailingWhitespace ctermfg=White ctermbg=LightRed guifg=#2d2a2e guibg=#ff6188
    match TrailingWhitespace /\s\+$/
]] )

-- Open new panes to the bottom/right
vim.o.splitbelow = true
vim.o.splitright = true

-- Treat *.h files as C, not C++
vim.g.c_syntax_for_h = 1

-- Use English dictionary for spell-check
vim.opt.spelllang = { "en" }

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
