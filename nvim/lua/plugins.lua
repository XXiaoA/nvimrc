return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
--    -- gruvbox theme 主题1
--    use {
--        "ellisonleao/gruvbox.nvim",
--        requires = {"rktjmp/lush.nvim"}
--    }
    -- 主题2
    use 'glepnir/zephyr-nvim'
    -- nvim-tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons'
        }
    -- bufferline #buffer
    use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
    -- treesitter 高亮
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',  }
    -- Comment 注释
    use {
        'numToStr/Comment.nvim',
        config = function()
                require('Comment').setup()
            end
    }
end)
