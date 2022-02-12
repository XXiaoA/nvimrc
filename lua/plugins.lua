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
    -- lspconfig
    use {'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer'}
    -- nvim-cmp
    use 'hrsh7th/cmp-nvim-lsp' -- { name = nvim_lsp }
    use 'hrsh7th/cmp-buffer'   -- { name = 'buffer' },
    use 'hrsh7th/cmp-path'     -- { name = 'path' }
    use 'hrsh7th/cmp-cmdline'  -- { name = 'cmdline' }
    use 'hrsh7th/nvim-cmp'
    -- vsnip
    use 'hrsh7th/cmp-vsnip'    -- { name = 'vsnip' }
    use 'hrsh7th/vim-vsnip'
    use 'rafamadriz/friendly-snippets'
    -- lspkind
    use 'onsails/lspkind-nvim'
	-- 文件搜索 预览 等
	use {
	"nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons"
	    }
	}
-- 加速文件搜索速度,如果安装失败需要到插件目录执行make命令手动编译
	use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}
end)
