-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Python provider — dedicated venv managed by os-setup/modules/python.sh
vim.g.python3_host_prog = vim.fn.expand('~/.local/share/nvim/python-venv/bin/python')

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- disable mouse
-- :help mouse
vim.o.mouse = ''

-- don't show the mode. it will be added to statusline
-- :help showmode
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.schedule(function()
--   vim.o.clipboard = 'unnamedplus'
-- end)

-- enable break indent
-- :help breakindent
vim.o.breakindent = true

-- save undo history
-- :help undofile
vim.o.undofile = true

-- case insensitive searching unless one or more capital letters are used
-- :help ignorecase, :help smartcase
vim.o.ignorecase = true
vim.o.smartcase = true

-- keep sign column on
-- prevents screen from shifting when signs are used
-- :help signcolumn
vim.o.signcolumn = 'yes'

-- decrease update time to write to swap file
-- :help updatetime
vim.o.updatetime = 250

-- decrease how long to wait for the next key press
-- applies to keymaps like <leader>w and <leader>wq
-- :help timeoutlen
vim.o.timeoutlen = 500

-- configure how new splits should be opened (ctrl-w v) (ctrl-w s)
-- :help splitright
-- :help splitbelow
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '»»', trail = '·', nbsp = '␣' }

-- preview substitutions as they are typed
-- :help inccommand
vim.o.inccommand = 'split'

-- show cursor line
-- :help cursorline
vim.o.cursorline = true

-- minimum lines to keep above below cursor
-- :help scrolloff
vim.o.scrolloff = 10

-- confirmation dialog for unsaved changes
-- :help confirm
vim.o.confirm = true

-- Tabs vs spaces
-- :help <cmd>
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.tabstop = 2 -- Display tabs as 2 spaces
vim.o.softtabstop = 2 -- Insert 2 spaces when Tab is pressed
vim.o.shiftwidth = 2 -- Use 2 spaces for autoindent
vim.o.smartindent = true -- attempt to indent on a newline when needed
vim.o.wrap = false

-- Window border for a cleaner look
-- :help winborder
vim.o.winborder = 'rounded'

-- force 24 bit colors
-- :help termguicolors
vim.o.termguicolors = true

-- add column at column 80 for coding
-- :help colorcolumn
vim.o.colorcolumn = '80'
