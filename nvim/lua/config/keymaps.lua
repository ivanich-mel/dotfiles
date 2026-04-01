local keymap = vim.keymap.set

keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
keymap('n', '<C-s>', '<cmd>w!<CR>', { desc = 'Save file' })

keymap('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
keymap('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
keymap('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
keymap('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

keymap('n', 'H', 'gT', { desc = 'Previous tab' })
keymap('n', 'L', 'gt', { desc = 'Next tab' })

keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

keymap('n', '|', '<cmd>vsplit<CR>', { desc = 'Vertical split' })
keymap('n', '_', '<cmd>split<CR>', { desc = 'Horizontal split' })

keymap('n', '<leader>w', '<C-w>q', { desc = 'Close current window' })
