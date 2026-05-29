return {
  'vimwiki/vimwiki',
  init = function()
    -- Must be set before vimwiki loads.
    -- Don't treat every markdown file as a wiki, and move the global mapping
    -- prefix off <Leader>w so it stops colliding with <leader>w (write).
    vim.g.vimwiki_global_ext = 0
    vim.g.vimwiki_map_prefix = '<Leader>W'
  end,
  cmd = { 'VimwikiIndex', 'VimwikiTabIndex', 'VimwikiUISelect', 'VimwikiDiaryIndex' },
  keys = {
    { '<leader>Ww', '<cmd>VimwikiIndex<cr>', desc = 'Vimwiki Index' },
  },
}
