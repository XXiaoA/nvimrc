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
    -- 美化
    use 'folke/lsp-colors.nvim'

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
    -- 自动补全括号
    use {"windwp/nvim-autopairs"}
    -- 信标（转跳
    use {'danilamihailov/beacon.nvim'}
    -- 信标（搜索
    use {'inside/vim-search-pulse'}
    -- 缩进线
    use "lukas-reineke/indent-blankline.nvim"
    -- 状态栏
    -- use {
    --       'glepnir/galaxyline.nvim',
    --         branch = 'main',
    --         -- your statusline
    --         -- config = function() require'my_statusline' end,
    --         -- some optional icons
    --         requires = {'kyazdani42/nvim-web-devicons', opt = true}
    --     }
    -- use 'Lokaltog/vim-powerline'
    use {
          'nvim-lualine/lualine.nvim',
          requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }
    -- 多光标
    use 'mg979/vim-visual-multi'
    -- 颜色
    use 'norcalli/nvim-colorizer.lua'
    -- 命令行窗口
    use {"akinsho/toggleterm.nvim"}
    -- 画图
    use "jbyuki/venn.nvim"
    -- copilot
    -- use 'github/copilot.vim'
    -- 彩色括号
    use "luochen1990/rainbow"
    -- 运行片段代码
    use { 'michaelb/sniprun', run = 'bash ./install.sh'}
    -- 启动页
    use 'glepnir/dashboard-nvim'
    -- 加快加载时间
    use 'lewis6991/impatient.nvim'
    -- 保存自动创建文件夹
    -- mkdir
    -- use {
    --   'jghauser/mkdir.nvim',
    --   config = function()
    --     require('mkdir')
    --   end
    -- }
    use 'DataWraith/auto_mkdir'
end)
