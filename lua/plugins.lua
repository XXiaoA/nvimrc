-- 在没有安装packer的电脑上，自动安装packer插件
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "--depth", "1", "https://hub.fastgit.xyz/wbthomason/packer.nvim.git", install_path})
    vim.cmd "packadd packer.nvim"
end

-- Mirror source
require("packer").init(
    {
        git = {
            default_url_format = "https://hub.xn--p8jhe.tw/%s"
        }
    }
)

local all_plugins = {
    -- Packer can manage itself
    {"wbthomason/packer.nvim"},
    -- 加快启动时间
   {"lewis6991/impatient.nvim"},
    {"nathom/filetype.nvim"},
    -- 主题
    {"sainnhe/gruvbox-material"},
    -- nvim-tree
    {
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons"
    },
    -- bufferline #buffer
    {"akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons"},
    -- treesitter 高亮
    {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"},
    -- Comment 注释
    {"numToStr/Comment.nvim"},
    -- lspconfig
    {"neovim/nvim-lspconfig", "williamboman/nvim-lsp-installer"},
    -- nvim-cmp
    {"hrsh7th/cmp-nvim-lsp"}, -- { name = nvim_lsp }
    {"hrsh7th/cmp-buffer"}, -- { name = 'buffer' },
    {"hrsh7th/cmp-path"}, -- { name = 'path' }
    {"hrsh7th/cmp-cmdline"}, -- { name = 'cmdline' }
    {"hrsh7th/nvim-cmp"},
    -- vsnip
    {"hrsh7th/cmp-vsnip"}, -- { name = 'vsnip' }
    {"hrsh7th/vim-vsnip"},
    {"rafamadriz/friendly-snippets"},
    -- lspkind
    {"onsails/lspkind-nvim"},
    -- 美化
    {"folke/lsp-colors.nvim"},
    -- 文件搜索 预览 等
    {
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons"
        }
    },
    -- 加速文件搜索速度,如果安装失败需要到插件目录执行make命令手动编译
    {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
    -- 自动补全括号
    {"windwp/nvim-autopairs"},
    -- 缩进线
    {"lukas-reineke/indent-blankline.nvim"},
    -- 状态栏
    {
        "nvim-lualine/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons", opt = true}
    },
    -- 多光标
    {"mg979/vim-visual-multi"},
    -- 颜色
    {"norcalli/nvim-colorizer.lua"},
    -- 命令行窗口
    {"akinsho/toggleterm.nvim"},
    -- copilot
    --  'github/copilot.vim'
    -- 彩色括号
    {"p00f/nvim-ts-rainbow"},
    -- 运行片段代码
    {"michaelb/sniprun", run = "bash ./install.sh"},
    -- 启动页
    {"glepnir/dashboard-nvim"},
    -- 保存自动创建文件夹
    {"DataWraith/auto_mkdir"},
    -- 自动对齐
    {"junegunn/vim-easy-align"},
    -- 代码生成图片
    --  'kristijanhusak/vim-carbon-now-sh'
    -- vim-sandwich
    {"machakann/vim-sandwich"},
    -- 自动保存
    {"Pocco81/AutoSave.nvim"},
    -- 运行时间
    {"dstein64/vim-startuptime"},
    -- 快速转跳
    {
        "phaazon/hop.nvim",
        branch = "v1" -- optional but strongly recommended
    },
    -- 中文文档
    {"yianwillis/vimcdoc"},
    -- 格式化代码
    {"mhartington/formatter.nvim"},
    -- 翻译
    {"voldikss/vim-translator"},
    -- 按键
    {"folke/which-key.nvim"},
    -- Debugging
    {"mfussenegger/nvim-dap"},
    {"rcarriga/nvim-dap-ui"},
    {"Pocco81/DAPInstall.nvim"},
    -- hightlight search
    {"kevinhwang91/nvim-hlslens"},
    -- code outline
    {"stevearc/aerial.nvim"},
    -- project
    {"ahmedkhalf/project.nvim"},
    -- evaluates code blocks
    {"jubnzv/mdeval.nvim"},
}

return require("packer").startup(
    function()
        for _, plugin in ipairs(all_plugins) do
---@diagnostic disable-next-line: undefined-global
            use(plugin)
        end
    end
)
