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

-- set the language to English
vim.cmd("language en_US.utf8")
-- 鼠标
o.mouse = "nv" -- "a"
-- backup dir
o.backupdir = cache_dir .. "backup/"
-- open swap
o.swapfile = false
o.encoding = "utf-8"
o.updatetime = 100
o.timeoutlen = 500
o.timeout = true
o.ttimeout = true
o.ttimeoutlen = 10
o.showcmd = true
-- show tabline if necessary
o.showtabline = 1
-- use global line
o.laststatus = 3
o.hidden = true
o.termguicolors = true
o.syntax = "enable"
o.cursorline = true
o.number = true
o.list = true
o.wrap = true
o.textwidth = 0
o.scrolloff = 10
o.sidescrolloff = 8
o.clipboard = "unnamedplus"
o.autoindent = true
o.expandtab = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.hlsearch = true
o.showmatch = false
o.wildmenu = false
o.ignorecase = true
o.smartcase = true
o.spell = false
o.spelllang = { "en_us", "cjk" }
o.spelloptions = "camel"

o.foldenable = true
o.foldmethod = "manual"
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
o.pumheight = 14 -- Maximum number of items to show in the popup menu

-- smarter diff algorithm
-- https://vimways.org/2018/the-power-of-diff/
-- https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
-- https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
o.diffopt:append("algorithm:histogram")
o.diffopt:append("indent-heuristic")
