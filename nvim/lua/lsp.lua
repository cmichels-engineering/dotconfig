-- https://github.com/neovim/nvim-lspconfig/tree/master/lsp for a list of lsp names
local keymap = vim.keymap

keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = '[F]ormat file' })
