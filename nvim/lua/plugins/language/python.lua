return {
  -- Virtual environment selector
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim' },
    ft = 'python',
    opts = {
      name = { 'venv', '.venv', 'env', '.env' },
    },
    keys = {
      { '<leader>vs', '<cmd>VenvSelect<cr>', desc = 'Select VirtualEnv' },
    },
  },

  -- Python debugging
  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require('dap-python').setup('python')
    end,
  },

  -- Python testing
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/neotest-python',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    ft = 'python',
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-python')({
            dap = { justMyCode = false },
            args = { '--log-level', 'DEBUG' },
            runner = 'pytest',
          }),
        },
      })
    end,
    keys = {
      { '<leader>tn', "<cmd>lua require('neotest').run.run()<cr>", desc = 'Test Nearest' },
      { '<leader>tf', "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = 'Test File' },
      { '<leader>td', "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = 'Debug Test' },
      { '<leader>ts', "<cmd>lua require('neotest').summary.toggle()<cr>", desc = 'Test Summary' },
      { '<leader>to', "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = 'Test Output' },
    },
  },
}
