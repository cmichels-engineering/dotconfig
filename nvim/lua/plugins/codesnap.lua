return {
  'mistricky/codesnap.nvim',
  build = 'make',
  event = 'VeryLazy',
  config = function()
    local codesnap = require('codesnap')
    codesnap.setup({
      mac_window_bar = true,
      title = 'my-code',
      code_font_family = 'CaskaydiaCove Nerd Font',
      watermark_font_family = 'Pacifico',
      watermark = '',
      bg_theme = 'dusk',
      breadcrumbs_separator = '/',
      has_breadcrumbs = true,
      save_path = '~/snaps/snap.png',
      has_line_number = true,
      bg_padding = 0,
    })
  end,
}
