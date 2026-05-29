return {
  'folke/snacks.nvim',
  -- Loaded early so it can install the vim.ui.select / vim.ui.input overrides
  -- at setup. Only lightweight proxies install at startup; the picker UI
  -- itself lazy-loads on first use.
  lazy = false,
  priority = 1000,
  opts = {
    -- Replaces vim.ui.input (formerly handled by dressing.nvim)
    input = { enabled = true },
    gh = {},
    picker = {
      enabled = true,
      ui_select = true, -- replaces vim.ui.select (formerly dressing/telescope-ui-select)
      sources = {
        gh_issue = {},
        gh_pr = {},
      },
    },
  },
  keys = {
    -- {
    --   '<leader>gi',
    --   function()
    --     Snacks.picker.gh_issue()
    --   end,
    --   desc = 'GitHub Issues (open)',
    -- },
    -- {
    --   '<leader>gI',
    --   function()
    --     Snacks.picker.gh_issue { state = 'all' }
    --   end,
    --   desc = 'GitHub Issues (all)',
    -- },
    {
      '<leader>gp',
      function()
        Snacks.picker.gh_pr()
      end,
      desc = 'GitHub Pull Requests (open)',
    },
    -- {
    --   '<leader>gP',
    --   function()
    --     Snacks.picker.gh_pr { state = 'all' }
    --   end,
    --   desc = 'GitHub Pull Requests (all)',
    -- },
  },
}
