  
-- open a floating window
vim.keymap.set('n', '<leader>tf', function()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
      'Test floating window',
      'Border style preview',
      '',
      'Close with :q'
    })

    vim.api.nvim_open_win(buf, true, {
      relative = 'editor',
      width = 50,
      height = 10,
      col = 20,
      row = 5,
      style = 'minimal',
    })
  end, { desc = 'Test floating window' })


-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "highlight on yanking",
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
