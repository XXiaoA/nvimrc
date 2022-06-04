-- 在没有安装packer的电脑上，自动安装packer插件
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    -- fn.system({ "git", "clone", "--depth", "1", "https://hub.fastgit.xyz/wbthomason/packer.nvim.git", install_path })
    vim.cmd("packadd packer.nvim")
end

-- Mirror source
require("packer").init({
    git = {
        default_url_format = "https://github.com/%s",
        -- default_url_format = "https://hub.fastgit.xyz/%s"
    },
})

local all_plugins = {
    -- Packer can manage itself
    { "wbthomason/packer.nvim" },
    -- 加快启动时间
    { "lewis6991/impatient.nvim" },
    -- 主题
    { "sainnhe/gruvbox-material" },
    { "EdenEast/nightfox.nvim", tag = "v1.0.0" },
    -- nvim-tree
    {
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons",
    },
    -- bufferline #buffer
    { "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" },
    -- treesitter 高亮
    { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
    -- Comment 注释
    { "numToStr/Comment.nvim" },
    -- lspconfig
    { "neovim/nvim-lspconfig", "williamboman/nvim-lsp-installer" },
    -- nvim-cmp
    { "hrsh7th/nvim-cmp" },
    {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-emoji",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "petertriho/cmp-git",
        "XXiaoA/cmp-events",
    },
    -- friendly-snippets
    { "rafamadriz/friendly-snippets" },
    -- lspkind
    { "onsails/lspkind-nvim" },
    -- dressing.nvim
    { "stevearc/dressing.nvim" },
    -- lsp_signature
    { "ray-x/lsp_signature.nvim" },
    -- 自动补全括号
    { "windwp/nvim-autopairs" },
    -- 文件搜索 预览 等
    {
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
        },
    },
    -- 加速文件搜索速度,如果安装失败需要到插件目录执行make命令手动编译
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    -- 缩进线
    { "lukas-reineke/indent-blankline.nvim" },
    -- 状态栏
    {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    },
    -- 颜色
    { "norcalli/nvim-colorizer.lua" },
    -- 命令行窗口
    { "akinsho/toggleterm.nvim" },
    -- copilot
    { "github/copilot.vim" },
    -- 彩色括号
    { "p00f/nvim-ts-rainbow" },
    -- 运行片段代码
    { "michaelb/sniprun", run = "bash ./install.sh" },
    -- 启动页
    { "glepnir/dashboard-nvim" },
    -- 保存自动创建文件夹
    { "DataWraith/auto_mkdir" },
    -- 自动对齐
    { "junegunn/vim-easy-align" },
    -- vim-sandwich
    { "machakann/vim-sandwich" },
    -- 自动保存
    { "Pocco81/AutoSave.nvim" },
    -- 运行时间
    { "dstein64/vim-startuptime" },
    -- 快速转跳
    {
        "phaazon/hop.nvim",
        branch = "v1", -- optional but strongly recommended
    },
    -- 中文文档
    { "yianwillis/vimcdoc" },
    -- 格式化代码
    { "mhartington/formatter.nvim" },
    -- 翻译
    { "voldikss/vim-translator" },
    -- 按键
    { "folke/which-key.nvim" },
    -- Debugging
    { "mfussenegger/nvim-dap" },
    { "rcarriga/nvim-dap-ui" },
    { "Pocco81/DAPInstall.nvim" },
    -- hightlight search
    { "kevinhwang91/nvim-hlslens" },
    -- code outline
    { "stevearc/aerial.nvim" },
    -- project
    { "ahmedkhalf/project.nvim" },
    -- evaluates code blocks
    { "jubnzv/mdeval.nvim" },
    -- register
    { "tversteeg/registers.nvim", config = [[vim.g.registers_window_border = "single"]] },
    -- Delete Neovim buffers without losing window layout
    { "famiu/bufdelete.nvim" },
    -- marks
    { "chentoast/marks.nvim" },
}

return require("packer").startup(function()
    for _, plugin in ipairs(all_plugins) do
        ---@diagnostic disable-next-line: undefined-global
        use(plugin)
    end
end)
