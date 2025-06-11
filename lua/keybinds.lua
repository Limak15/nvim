local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

-- Fzf --
map('n', '<C-p>', ':Files<CR>')
map('n', '<C-j>', ':Buffers<CR>')

vim.api.nvim_set_keymap('n', '<leader>hh', ':ClangdSwitchSourceHeader<CR>', { noremap = true, silent = true })
