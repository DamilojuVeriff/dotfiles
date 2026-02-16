-- Debug Adapter Protocol

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      dependencies = { 'nvim-neotest/nvim-nio' },
    },
    'theHamsta/nvim-dap-virtual-text',
    {
      'mxsdev/nvim-dap-vscode-js',
      opts = {
        debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
        debugger_cmd = { 'js-debug-adapter' },
        adapters = { 'pwa-node', 'pwa-chrome' },
      },
    },
  },
  keys = {
    { '<F5>', function() require('dap').continue() end, desc = 'Debug: Continue' },
    { '<F9>', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    { '<F10>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
    { '<F11>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
    { '<S-F11>', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
    { '<Leader>dc', function() require('dap').continue() end, desc = 'Continue' },
    { '<Leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
    { '<Leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'Conditional Breakpoint' },
    { '<Leader>dr', function() require('dap').repl.open() end, desc = 'Open REPL' },
    { '<Leader>du', function() require('dapui').toggle() end, desc = 'Toggle DAP UI' },
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup()
    require('nvim-dap-virtual-text').setup()

    -- Configurations for JavaScript/TypeScript
    for _, language in ipairs({ 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }) do
      dap.configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach to process',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Debug Jest Tests',
          runtimeExecutable = 'node',
          runtimeArgs = { './node_modules/jest/bin/jest.js', '--runInBand' },
          rootPath = '${workspaceFolder}',
          cwd = '${workspaceFolder}',
          console = 'integratedTerminal',
          internalConsoleOptions = 'neverOpen',
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Debug Vitest Tests',
          runtimeExecutable = 'node',
          runtimeArgs = { './node_modules/vitest/vitest.mjs', '--run' },
          rootPath = '${workspaceFolder}',
          cwd = '${workspaceFolder}',
          console = 'integratedTerminal',
          internalConsoleOptions = 'neverOpen',
        },
      }
    end

    -- Auto open/close DAP UI
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end
  end,
}
