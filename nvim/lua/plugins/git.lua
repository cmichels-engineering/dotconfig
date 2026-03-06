return {
  -- {
  --   'FabijanZulj/blame.nvim',
  --   lazy = false,
  --   config = function()
  --     require('blame').setup({})
  --   end,
  --   opts = {
  --     blame_options = { '-w' },
  --   },
  -- },
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    keys = {
      { '<leader>gsd', '<cmd>Gitsigns diffthis main<cr>', { desc = '[G]it[signs] [Diff]' } },
    },
    opts = {
      current_line_blame = true,
    },
  },
  -- {
  --   'tpope/vim-fugitive',
  --   keys = {
  --     { '<leader>gid', '<cmd>Git difftool<cr>', { desc = '[Gi]t diff' } },
  --   },
  -- },
}
