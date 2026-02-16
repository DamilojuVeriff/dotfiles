-- Testing

return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'marilari88/neotest-vitest',
    'nvim-neotest/neotest-jest',
  },
  keys = {
    { '<Leader>tt', function() require('neotest').run.run() end, desc = 'Run nearest test' },
    { '<Leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run current file' },
    { '<Leader>ts', function() require('neotest').run.run({ suite = true }) end, desc = 'Run test suite' },
    { '<Leader>to', function() require('neotest').output_panel.toggle() end, desc = 'Toggle output panel' },
    { '<Leader>tS', function() require('neotest').summary.toggle() end, desc = 'Toggle summary' },
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-vitest'),
        require('neotest-jest')({
          jestCommand = 'npx jest',
        }),
      },
    })
  end,
}
