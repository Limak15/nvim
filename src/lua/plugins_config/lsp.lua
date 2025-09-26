vim.lsp.enable('ts_ls')
vim.lsp.enable('clangd')
vim.lsp.enable('cssls')
vim.lsp.enable('html')
vim.lsp.enable('phpactor')

vim.lsp.config('ts_ls', {
    on_attach = lsp_on_attach,
    cmd = { "/usr/bin/typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    init_options = { hostInfo = "neovim" },
    root_markers = {
		"package.json",
        ".git"
	},
    single_file_support = true,
})

vim.lsp.config('clangd', {
    on_attach = lsp_on_attach,
    cmd = {"/usr/bin/clangd"},
    filetypes = {"c", "cpp", "objc", "objcpp"},
    root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git" },
    settings = {},   
})

vim.lsp.config('html', {
    on_attach = lsp_on_attach,
    capabilities = capabilities,
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
            css = true,
            javascript = true
        },
        provideFormatter = true
    }
})
