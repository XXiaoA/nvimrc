" 基础设置
lua require("basic")
set mouse=
" 快捷键映射
lua require('keybindings')
" Packer插件管理
lua require('plugins')

" 主题
set background=dark
colorscheme gruvbox
" colorscheme zephyr

source $HOME/.config/nvim/vim/RunCode.vim
source $HOME/.config/nvim/vim/rainbow.vim
source $HOME/.config/nvim/vim/dashboard.vim

lua require('plugin-config/nvim-tree')
lua require('plugin-config/bufferline')
lua require('plugin-config/nvim-treesitter')
lua require('plugin-config/Comment')
lua require('plugin-config/telescope')
lua require('plugin-config/nvim-autopairs')
lua require("plugin-config/indent_blankline")
lua require('plugin-config/nvim-colorizer')
" lua require('plugin-config/lualine')
lua require('plugin-config/venn')
lua require('plugin-config/toggleterm')
lua require('plugin-config/galaxyline')
lua require('plugin-config/AutoSave')
lua require('plugin-config/hop')
lua require('plugin-config/formatter')
lua require'impatient'.enable_profile()


lua require('lsp/setup')
lua require('lsp/nvim-cmp')
