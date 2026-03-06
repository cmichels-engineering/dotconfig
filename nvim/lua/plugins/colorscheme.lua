return {
  -- "ellisonleao/gruvbox.nvim",
  -- 'folke/tokyonight.nvim',
  -- "Mofiqul/dracula.nvim",
  -- "sainnhe/gruvbox-material",
  -- "savq/melange-nvim",
  -- "doums/darcula",
  'xiantang/darcula-dark.nvim',
  priority = 1000,
  opts = ...,
  config = function()
    -- vim.cmd.colorscheme('tokyonight')
    -- vim.cmd.colorscheme("dracula")
    -- vim.cmd.colorscheme("melange")
    -- vim.cmd.colorscheme("gruvbox-material")
    vim.cmd.colorscheme('darcula-dark')
  end,
}
