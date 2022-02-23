" 基础设置
lua require("basic")
set mouse=
" 快捷键映射
lua require('keybindings')
" Packer插件管理
lua require('plugins')

"一键编译{{{
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec '!clang "%" -o "%<"'
        exec '!./"%<"'
    elseif &filetype == 'cpp'
        exec '!g++ "%" -o "%<"'
        exec '!./"#<"'
    elseif &filetype == 'python'
        exec '!time python3 "%"'
    elseif &filetype == 'pyc'
        exec '!time python3 "%"'
    elseif &filetype == 'java'
        " exec '!javac "%"'
        " exec '!java "%<"'
        exec '!time java "%"'
    elseif &filetype == 'javascript'
        exec '!node "%"'
    elseif &filetype == 'sh'
        exec '!sh "%"'
    endif
endfunc!"}}}

" 主题
set background=dark
" colorscheme gruvbox
colorscheme zephyr

" 插件配置
lua require('plugin-config/nvim-tree')
lua require('plugin-config/bufferline')
lua require('plugin-config/nvim-treesitter')
lua require('plugin-config/Comment')
lua require('plugin-config/telescope')
lua require('lsp/setup')
lua require('lsp/nvim-cmp')
lua require('plugin-config/nvim-autopairs')
lua require("plugin-config/indent_blankline")
lua require('plugin-config/nvim-colorizer')
" lua require('plugin-config/galaxyline')
lua require('plugin-config/lualine')
lua require('plugin-config/venn')
lua require('plugin-config/toggleterm')
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\	'operators': '_,_',
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\	'separately': {
\		'*': {},
\		'tex': {
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\		},
\		'lisp': {
\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\		},
\		'vim': {
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\		},
\		'html': {
\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\		},
\		'css': 0,
\	}
\}

