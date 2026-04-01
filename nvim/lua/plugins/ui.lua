local installed_colorschemes = {
  'desert',
  'tokyonight-night',
  'tokyonight-storm',
  'catppuccin-mocha',
  'catppuccin-latte',
  'kanagawa-wave',
}

local default_colorscheme = 'kanagawa-wave'

local function find_colorscheme_index(name)
  for index, colorscheme in ipairs(installed_colorschemes) do
    if colorscheme == name then
      return index
    end
  end

  return nil
end

local function apply_colorscheme(name)
  local index = find_colorscheme_index(name)
  if not index then
    vim.notify('Unknown colorscheme: ' .. name, vim.log.levels.ERROR)
    return false
  end

  vim.g.colorscheme_index = index
  vim.g.colors_name_preference = name
  local ok, err = pcall(vim.cmd.colorscheme, name)
  if not ok then
    vim.notify('Failed to apply colorscheme ' .. name .. ': ' .. err, vim.log.levels.ERROR)
    return false
  end

  return true
end

local function cycle_colorscheme(step)
  local current_index = vim.g.colorscheme_index or find_colorscheme_index(default_colorscheme) or 1
  local total = #installed_colorschemes
  local next_index = ((current_index - 1 + step) % total) + 1

  apply_colorscheme(installed_colorschemes[next_index])
end

return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
        },
      },
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      local telescope = require 'telescope'
      local builtin = require 'telescope.builtin'
      local themes = require 'telescope.themes'

      telescope.setup {
        extensions = {
          ['ui-select'] = {
            themes.get_dropdown(),
          },
        },
      }

      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')

      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
      vim.keymap.set('n', '<leader>sc', builtin.colorscheme, { desc = '[S]earch [C]olorscheme' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(themes.get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = 'Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        integrations = {
          gitsigns = true,
          mini = true,
          neotree = true,
          treesitter = true,
          which_key = true,
        },
      }
    end,
  },

  {
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      apply_colorscheme(default_colorscheme)

      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyDone',
        once = true,
        callback = function()
          apply_colorscheme(default_colorscheme)
        end,
      })
    end,
    keys = {
      {
        '<leader>tn',
        function()
          cycle_colorscheme(1)
        end,
        desc = '[T]heme [N]ext',
      },
      {
        '<leader>tp',
        function()
          cycle_colorscheme(-1)
        end,
        desc = '[T]heme [P]revious',
      },
    },
    config = function()
      require('tokyonight').setup {
        styles = {
          comments = { italic = false },
        },
      }
    end,
  },
}
