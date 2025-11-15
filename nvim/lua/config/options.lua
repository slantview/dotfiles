-- Neovim options and settings

local opt = vim.opt
local g = vim.g

-- General settings
opt.mouse = "a"                    -- Enable mouse support
opt.clipboard = "unnamedplus"      -- Use system clipboard
opt.swapfile = false               -- Disable swap files
opt.backup = false                 -- Disable backup files
opt.undofile = true                -- Enable persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- UI settings
opt.number = true                  -- Show line numbers
opt.relativenumber = false         -- Disable relative line numbers (use static numbers)
opt.cursorline = true              -- Highlight current line
opt.signcolumn = "yes"             -- Always show sign column
opt.colorcolumn = "80"             -- Show column at 80 characters
opt.scrolloff = 8                  -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8              -- Keep 8 columns left/right of cursor

-- Search settings
opt.ignorecase = true              -- Ignore case in search
opt.smartcase = true               -- Case sensitive if uppercase in search
opt.hlsearch = true                -- Highlight search results
opt.incsearch = true               -- Incremental search

-- Indentation settings
opt.tabstop = 4                    -- Number of spaces a tab counts for
opt.shiftwidth = 4                 -- Number of spaces for auto-indent
opt.expandtab = true               -- Use spaces instead of tabs
opt.smartindent = true             -- Smart auto-indenting
opt.autoindent = true              -- Copy indent from current line

-- Text rendering
opt.wrap = false                   -- Don't wrap lines
opt.linebreak = true               -- Break lines at word boundaries
opt.breakindent = true             -- Indent wrapped lines

-- Performance
opt.updatetime = 250               -- Faster completion
opt.timeoutlen = 300               -- Time to wait for mapped sequence

-- Colorscheme
opt.termguicolors = true           -- Enable 24-bit RGB colors
-- Colorscheme is set by the everforest-nvim plugin (see plugins.lua)

-- File type detection
opt.filetype.on = true
vim.cmd("filetype plugin on")
vim.cmd("filetype indent on")

-- Go specific settings (vim-go compatibility)
g.go_fmt_command = "goimports"
g.go_highlight_functions = 1
g.go_highlight_methods = 1
g.go_highlight_structs = 1
g.go_highlight_interfaces = 1
g.go_highlight_operators = 1
g.go_highlight_build_constraints = 1

