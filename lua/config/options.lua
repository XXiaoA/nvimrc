local cache_dir = os.getenv("HOME") .. "/.cache/nvim/"
local o = vim.opt
local g = vim.g

-- https://github.com/glepnir/nvim/blob/6bb5e515289171fe197f248ee64206b10d0dbd71/lua/core/init.lua
-- disable_distribution_plugins
g.loaded_gzip = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_2html_plugin = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1

-- 鼠标
o.mouse = "nv" -- "a"
-- backup dir
o.backupdir = cache_dir .. "backup/"
-- open swap
o.swapfile = false
-- 编码设置
o.encoding = "utf-8"
-- 加快响应速度
o.updatetime = 100
-- 连击频率
o.timeoutlen = 500
o.timeout = true
o.ttimeout = true
o.ttimeoutlen = 10
-- 总是在当前目录下执行命令
o.autochdir = true
-- 显示命令字符
o.showcmd = true
-- always show tabline
o.showtabline = 2
-- use global line
o.laststatus = 3
-- 允许当前窗口未保存时切换到其他窗口
o.hidden = true
-- 启用 24-bit 色
o.termguicolors = true
-- 语法高亮
o.syntax = "enable"
-- 高亮当前行
o.cursorline = true
-- 设置行号
o.number = true
-- 显示行尾空格
o.list = true
-- 设置自动折行
o.wrap = true
-- 取消自动换行
o.textwidth = 0
-- jk移动时光标下上方保留8行
o.scrolloff = 10
o.sidescrolloff = 8
-- 使用系统剪切板
o.clipboard = "unnamedplus"
-- 设置自动缩进
o.autoindent = true
-- 将缩进转换为空格
o.expandtab = true
-- 设置 tab 缩进显示宽度
o.tabstop = 4
-- 设置 tab 缩进实际宽度
o.softtabstop = 4
-- 设置>> <<缩进数量
o.shiftwidth = 4
-- 高亮搜索结果
o.hlsearch = true
-- 高亮匹配符号
o.showmatch = true
-- 开启命令补全
o.wildmenu = true
-- 忽略大小写
o.ignorecase = true
-- 智能大小写
o.smartcase = true
-- 打开拼写检查
o.spell = false
-- 设置拼写检查语言
o.spelllang = { "en_us", "cjk" }
o.spelloptions = "camel"

-- 是否支持折叠
o.foldenable = true
-- 折叠的方式
o.foldmethod = "manual"
-- 折叠的级别（100）
o.foldlevel = 100
o.foldlevelstart = 100
-- o.foldcolumn = "1"
o.fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "" }

o.autoindent = true

-- Ask for confirmation when handling unsaved or read-only files
o.confirm = true
o.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time

o.undofile = true
o.undolevels = 10000

o.hidden = true
o.magic = true
o.virtualedit = "block"
o.showmode = false -- Dont show mode since we have a statusline
o.splitkeep = "screen"
o.mousemodel = "extend"

o.matchpairs:append("<:>")

o.autowrite = true -- Enable auto write
o.conceallevel = 0 -- Hide * markup for bold and italic etc.
o.shiftround = true -- Round indent
o.shortmess:append({ W = true, I = true, C = true, c = true })
o.smartindent = true -- Insert indents automatically
o.splitbelow = true -- Put new windows below current
o.splitright = true -- Put new windows right of current
o.winminwidth = 5 -- Minimum window width
o.pumheight = 14 -- limit the max height of windows
