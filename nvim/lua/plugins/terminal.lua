return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        direction = 'float',
      }

      local Terminal = require('toggleterm.terminal').Terminal

      local lazygit = Terminal:new {
        cmd = 'lazygit',
        hidden = true,
        direction = 'float',
      }

      vim.keymap.set('n', '<leader>gg', function()
        lazygit:toggle()
      end, { desc = 'Open lazygit' })
    end,
  },
}
