return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.o.timeoutlen
    delay = 500,
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font,
      -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
      -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
      keys = vim.g.have_nerd_font and {} or {
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        C = '<C-…> ',
        M = '<M-…> ',
        D = '<D-…> ',
        S = '<S-…> ',
        CR = '<CR> ',
        Esc = '<Esc> ',
        ScrollWheelDown = '<ScrollWheelDown> ',
        ScrollWheelUp = '<ScrollWheelUp> ',
        NL = '<NL> ',
        BS = '<BS> ',
        Space = '<Space> ',
        Tab = '<Tab> ',
        F1 = '<F1>',
        F2 = '<F2>',
        F3 = '<F3>',
        F4 = '<F4>',
        F5 = '<F5>',
        F6 = '<F6>',
        F7 = '<F7>',
        F8 = '<F8>',
        F9 = '<F9>',
        F10 = '<F10>',
        F11 = '<F11>',
        F12 = '<F12>',
      },
    },

    -- Document existing key chains
    spec = {
      { '<leader>s', group = '[S]earch' },
      { '<leader>t', group = '[T]oggle / [T]est' },
      { '<leader>b', group = '[B]uffer' },
      { '<leader>c', group = '[C]opy / [C]ode' },
      { '<leader>g', group = '[G]it / GitHub' },
      { '<leader>d', group = '[D]ebug' },
      -- { "<leader>T",   desc = "[T]est" },
      -- { "<leader>c",   desc = "[C]ode" },
      -- { "<leader>d",   desc = "[D]ap" },
      -- { "<leader>g",   desc = "[G]o" },
      -- { "<leader>ga",  desc = "[A]dd" },
      -- { "<leader>h",   desc = "Git [H]unk" },
      -- { "<leader>r",   desc = "[R]ename" },
      -- { "<leader>t",   desc = "[T]oggle" },
      -- { "<leader>w",   desc = "[W]orkspace" },
    },
  },
}
