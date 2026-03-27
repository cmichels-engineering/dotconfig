local keymap = vim.keymap

keymap.set('n', '<leader>pv', '<cmd>Oil<CR>', { desc = 'netrw' })
keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = '[W]rite' })
keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = '[Q]uit' })
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Remove highlight' })
keymap.set('v', '<', '<gv', { desc = 'indent left' })
keymap.set('v', '>', '>gv', { desc = 'indent right' })
keymap.set('v', '<leader>y', '"+y', { desc = '[Y]ank to system' })
keymap.set('v', '<leader>p', '"_dP', { desc = 'Replace and [P]aste' })
keymap.set('n', '<leader>bc', '<CMD>:bdelete<CR>', { desc = '[B]uffer [C]lose' })
keymap.set('n', '<C-p>', '<CMD>:bprevious<CR>', { desc = '[B]uffer [P]revious' })
keymap.set('n', '<C-n>', '<CMD>:bnext<CR>', { desc = '[B]uffer [N]ext' })

-- Utils
keymap.set('n', '<leader><leader>s', '<cmd>source %<CR>', { desc = '[S]ource Current File' })
keymap.set('n', '<leader>crp', '<cmd>let @+=@%<CR>', { desc = '[C]opy [R]elative [P]ath' })
keymap.set('n', '<leader>cp', '<cmd>let @+ = expand("%:p")<CR>', { desc = '[C]opy [P]ath' })
keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = '[D]iagnostic [Q]uickfix list' })

-- disable arrow keys in normal
keymap.set('n', '<left>', '<cmd>echo "Use h!"<CR>', { desc = 'good vimming' })
keymap.set('n', '<right>', '<cmd>echo "Use l!"<CR>', { desc = 'good vimming' })
keymap.set('n', '<up>', '<cmd>echo "Use j!"<CR>', { desc = 'good vimming' })
keymap.set('n', '<down>', '<cmd>echo "Use k!"<CR>', { desc = 'good vimming' })

-- window nav handled by vim-tmux-navigator plugin

