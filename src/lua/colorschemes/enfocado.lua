vim.cmd([[
    augroup enfocado_customization
        autocmd!
            autocmd ColorScheme enfocado ++nested highlight Normal ctermbg=NONE guibg=NONE
            autocmd ColorScheme enfocado ++nested highlight NormalNC ctermbg=NONE guibg=NONE
            autocmd ColorScheme enfocado ++nested highlight LineNr ctermbg=NONE guibg=NONE guifg=#bbc2cf
    augroup END
]])

vim.cmd('colorscheme enfocado')
