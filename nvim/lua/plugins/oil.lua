return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  default_file_explorer = true,
  config = function()
    require('oil').setup({
      columns = {
        'icon',
        'size',
      },
      keymaps = {
        ['<C-h>'] = false,
        ['yp'] = {
          desc = 'Copy filepath to system clipboard',
          callback = function()
            require('oil.actions').copy_entry_filename.callback()
            vim.fn.setreg('+', vim.fn.getreg(vim.v.register))
          end,
        },
      },
    })
  end,
}
