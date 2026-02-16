-- Language Server Protocol

return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'b0o/schemastore.nvim',
  },
  config = function()
    -- Setup Mason to automatically install LSP servers
    require('mason').setup({
      ui = {
        height = 0.8,
      },
    })
    require('mason-lspconfig').setup({ automatic_installation = true })

    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- PHP
    vim.lsp.config('intelephense', {
      commands = {
        IntelephenseIndex = {
          function()
            vim.lsp.buf.execute_command({ command = 'intelephense.index.workspace' })
          end,
        },
      },
      capabilities = capabilities
    })

    -- Vue, JavaScript, TypeScript
    vim.lsp.config('volar', {
      capabilities = capabilities,
    })

    vim.lsp.config('ts_ls', {
      capabilities = capabilities,
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
            languages = {"javascript", "typescript", "vue"},
          },
        },
      },
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
      },
    })

    -- Tailwind CSS
    vim.lsp.config('tailwindcss', { capabilities = capabilities })

    -- JSON
    vim.lsp.config('jsonls', {
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
        },
      },
    })

    -- Lua
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          workspace = {
            checkThirdParty = false,
            library = {
              '${3rd}/luv/library',
              unpack(vim.api.nvim_get_runtime_file('', true)),
            },
          }
        }
      }
    })

    -- Enable LSP servers
    vim.lsp.enable({
      'intelephense',
      'volar',
      'ts_ls',
      'tailwindcss',
      'jsonls',
      'lua_ls',
    })

    -- Keymaps
    vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
    vim.keymap.set('n', 'gd', ':Telescope lsp_definitions<CR>')
    vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
    vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
    vim.keymap.set('n', '<Leader>lr', ':LspRestart<CR>', { silent = true })
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

    -- TypeScript-specific keymaps
    vim.keymap.set('n', '<Leader>oi', function()
      vim.lsp.buf.code_action({
        apply = true,
        context = { only = { 'source.organizeImports.ts' } },
      })
    end, { desc = 'Organize imports' })

    vim.keymap.set('n', '<Leader>ai', function()
      vim.lsp.buf.code_action({
        apply = true,
        context = { only = { 'source.addMissingImports.ts' } },
      })
    end, { desc = 'Add missing imports' })

    vim.keymap.set('n', '<Leader>ru', function()
      vim.lsp.buf.code_action({
        apply = true,
        context = { only = { 'source.removeUnused.ts' } },
      })
    end, { desc = 'Remove unused imports' })

    vim.keymap.set('n', 'gD', function()
      vim.lsp.buf.definition({ loclist = true, reuse_win = true })
    end, { desc = 'Go to source definition' })

    -- Diagnostic configuration
    vim.diagnostic.config({
      virtual_text = false,
      float = {
        source = true,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.INFO] = '',
          [vim.diagnostic.severity.HINT] = '',
        },
      },
    })
  end,
}
