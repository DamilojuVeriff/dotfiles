-- Show pending keybinds

return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  config = function()
    local wk = require('which-key')
    wk.setup()
    wk.add({
      { '<leader>d', group = 'Debug/Diagnostics' },
      { '<leader>t', group = 'Test' },
      { '<leader>o', group = 'Organize' },
      { '<leader>a', group = 'Add' },
      { '<leader>l', group = 'LSP' },
    })
  end,
}
