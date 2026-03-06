return {
  -- Auto close/rename HTML tags
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    opts = {},
  },

  -- Show package versions in package.json
  {
    'vuki656/package-info.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    ft = 'json',
    opts = {},
    keys = {
      { '<leader>ns', "<cmd>lua require('package-info').show()<cr>", desc = 'Show package info' },
      { '<leader>nc', "<cmd>lua require('package-info').hide()<cr>", desc = 'Hide package info' },
      { '<leader>nu', "<cmd>lua require('package-info').update()<cr>", desc = 'Update package' },
      { '<leader>nd', "<cmd>lua require('package-info').delete()<cr>", desc = 'Delete package' },
      { '<leader>ni', "<cmd>lua require('package-info').install()<cr>", desc = 'Install package' },
    },
  },
}
