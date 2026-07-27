return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  branch = 'main', -- the legacy `master` branch is archived
  lazy = false, -- the main-branch rewrite does not support lazy-loading
  build = ':TSUpdate',
  config = function()
    -- Install the parsers we use. Runs asynchronously; safe to call on startup.
    require('nvim-treesitter').install {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'go',
      'python',
      'typescript',
      'ruby',
      'sql',
      'yaml',
    }

    -- On the main branch, highlighting is a Neovim builtin (`:h treesitter-highlight`).
    -- Start it for any buffer whose filetype has an installed parser. `pcall`
    -- silently skips filetypes without one.
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter-highlight', { clear = true }),
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
