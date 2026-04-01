return {
  'NMAC427/guess-indent.nvim',

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
            return
          end

          gitsigns.nav_hunk 'next'
        end, 'Jump to next git change')

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
            return
          end

          gitsigns.nav_hunk 'prev'
        end, 'Jump to previous git change')

        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, 'Git stage hunk')

        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, 'Git reset hunk')

        map('n', '<leader>hs', gitsigns.stage_hunk, 'Git stage hunk')
        map('n', '<leader>hr', gitsigns.reset_hunk, 'Git reset hunk')
        map('n', '<leader>hS', gitsigns.stage_buffer, 'Git stage buffer')
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, 'Git undo stage hunk')
        map('n', '<leader>hR', gitsigns.reset_buffer, 'Git reset buffer')
        map('n', '<leader>hp', gitsigns.preview_hunk, 'Git preview hunk')
        map('n', '<leader>hb', gitsigns.blame_line, 'Git blame line')
        map('n', '<leader>hd', gitsigns.diffthis, 'Git diff against index')
        map('n', '<leader>hD', function()
          gitsigns.diffthis '@'
        end, 'Git diff against last commit')
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, 'Toggle git blame')
        map('n', '<leader>tD', gitsigns.preview_hunk_inline, 'Preview deleted lines')
      end,
    },
  },

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'go',
        'gomod',
        'gosum',
        'gowork',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'yaml',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = {
        enable = true,
        disable = { 'ruby' },
      },
    },
  },
}
