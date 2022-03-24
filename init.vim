" 基础设置
lua require("basic")
" 快捷键映射
lua require('keybindings')
" Packer插件管理
lua require('plugins')

" 主题
set termguicolors
set background=dark
colorscheme gruvbox

source $HOME/.config/nvim/vim/RunCode.vim
source $HOME/.config/nvim/vim/rainbow.vim
source $HOME/.config/nvim/vim/dashboard.vim

lua require('plugin-config')
