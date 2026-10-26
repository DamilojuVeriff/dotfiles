-- Syntax highlighting

local parsers = {
  'arduino',
  'bash',
  'blade',
  'comment',
  'css',
  'diff',
  'dockerfile',
  'git_config',
  'git_rebase',
  'gitattributes',
  'gitcommit',
  'gitignore',
  'go',
  'html',
  'http',
  'ini',
  'javascript',
  'json',
  'lua',
  'make',
  'markdown',
  'markdown_inline',
  'passwd',
  'php',
  'php_only',
  'phpdoc',
  'python',
  'regex',
  'ruby',
  'rust',
  'sql',
  'svelte',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'vue',
  'xml',
  'yaml',
}

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  dependencies = {
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      opts = {
        enable_autocmd = false,
        languages = {
          php_only = '// %s',
          php = '// %s',
        },
        custom_calculation = function (node, language_tree)
          if vim.bo.filetype == 'blade' then
            if language_tree._lang == 'html' then
              return '{{-- %s --}}'
            else
              return '// %s'
            end
          end
        end,
      },
      config = function(_, opts)
        require('ts_context_commentstring').setup(opts)

        -- Integrate with Neovim's built-in commenting
        local get_option = vim.filetype.get_option
        vim.filetype.get_option = function(filetype, option)
          return option == "commentstring"
            and require("ts_context_commentstring.internal").calculate_commentstring()
            or get_option(filetype, option)
        end
      end,
    },
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      branch = 'main',
      config = function()
        require('nvim-treesitter-textobjects').setup({
          select = { lookahead = true },
        })

        local select = function(query)
          return function()
            require('nvim-treesitter-textobjects.select').select_textobject(query, 'textobjects')
          end
        end
        vim.keymap.set({ 'x', 'o' }, 'if', select('@function.inner'))
        vim.keymap.set({ 'x', 'o' }, 'af', select('@function.outer'))
        vim.keymap.set({ 'x', 'o' }, 'ia', select('@parameter.inner'))
        vim.keymap.set({ 'x', 'o' }, 'aa', select('@parameter.outer'))
      end,
    },
  },
  config = function ()
    local ts = require('nvim-treesitter')
    ts.install(parsers)

    -- Highlighting and indentation are opt-in per buffer on the main branch
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
          return
        end

        local function attach()
          if not vim.api.nvim_buf_is_valid(args.buf) or not pcall(vim.treesitter.start, args.buf, lang) then
            return
          end
          if args.match ~= 'yaml' then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end

        -- Auto-install parsers for languages not in the list above
        if vim.list_contains(ts.get_available(), lang) and not vim.list_contains(ts.get_installed(), lang) then
          ts.install(lang):await(attach)
        else
          attach()
        end
      end,
    })
  end,
}
