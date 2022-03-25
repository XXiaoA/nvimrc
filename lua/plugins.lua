--在没有安装packer的电脑上，自动安装packer插件
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	 --fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})	--默认地址
	fn.system({'git', 'clone', '--depth', '1', 'https://hub.fastgit.xyz/wbthomason/packer.nvim.git', install_path})	--csdn加速镜像
	vim.cmd 'packadd packer.nvim'
end

require('packer').init({
	git = {
		default_url_format = "https://hub.fastgit.xyz/%s"
	}
})


return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    --    -- gruvbox theme 主题1
    use {
       "ellisonleao/gruvbox.nvim",
       requires = {"rktjmp/lush.nvim"}
    }
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
    use 'DataWraith/auto_mkdir'
    -- 自动对齐
    use 'junegunn/vim-easy-align'
    -- 代码生成图片
    -- use 'kristijanhusak/vim-carbon-now-sh'
    -- surround
    use 'tpope/vim-surround'
    -- 自动保存
    use 'Pocco81/AutoSave.nvim'
    -- 去除末尾空格/空行
    -- use 'McAuleyPenney/tidy.nvim'
    -- 运行时间
    use 'dstein64/vim-startuptime'
    -- 快速转跳
    use {
      'phaazon/hop.nvim',
      branch = 'v1', -- optional but strongly recommended
      config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      end
    }
    -- 电灯泡
    use 'kosayoda/nvim-lightbulb'
    -- 中文文档
    use 'yianwillis/vimcdoc'
    -- 格式化代码
    use 'mhartington/formatter.nvim'
    -- 翻译
    use 'voldikss/vim-translator'
    -- 按键
    use "folke/which-key.nvim"
    -- Debugging
    use 'mfussenegger/nvim-dap'
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    use "Pocco81/DAPInstall.nvim"
end)
