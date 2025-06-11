vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'   
    
    -- Colorschemes
    use 'behemothbucket/gruber-darker-theme.nvim'
   
    -- Fzf
    use { "junegunn/fzf", run = ":call fzf#install()" }
    use 'junegunn/fzf.vim'
    
    -- Treesitter
    use { 
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }
    -- Completion stuff
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    
    -- Lsp stuff 
    use 'neovim/nvim-lspconfig'

    -- Snippet engine
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

end)	
