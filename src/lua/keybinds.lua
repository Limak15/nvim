local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

vim.api.nvim_set_keymap('n', '<leader>hh', ':ClangdSwitchSourceHeader<CR>', { noremap = true, silent = true })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<C-j>', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

