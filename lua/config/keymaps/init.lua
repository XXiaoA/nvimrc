-- Function for make mapping easier.
local map = require("core.keymap").set_keymap

nmap = map("n")
imap = map("i")
vmap = map("v")
tmap = map("t")

-- leader key 为空格
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 退出终端插入模式
tmap({ "<ESC>", [[<C-\><C-n>]] })

-- 移动代码
nmap({ "<A-up>", ":m .-2<cr>" })
nmap({ "<A-down>", ":m .+1<cr>" })
imap({ "<A-up>", "<ESC>:m .-2<cr>i" })
imap({ "<A-down>", "<ESC>:m .+1<cr>i" })
vmap({ "<A-up>", ":m '<-2<cr>gv" })
vmap({ "<A-down>", ":m '>+1<cr>gv" })

-- 移动到行首/行末
imap({ "<C-h>", "<ESC>I" })
imap({ "<C-l>", "<ESC>A" })

-- 保存/退出
imap({ "<C-s>", "<ESC>:w<CR>" })
imap({ "<C-q>", "<ESC>:qall<CR>" })
nmap({ "W", ":w<CR>" })
nmap({ "Q", ":qall<cr>" })

-- ctrl u / ctrl + d  只移动10行，默认移动半屏
nmap({ "<C-u>", "10k" })
nmap({ "<C-d>", "10j" })

-- 输入模式/选择模式 jj/JJ 退出
vmap({ "JJ", "<ESC>" })
imap({ "jj", "<ESC>" })
imap({ "JJ", "<ESC>" })

-- visual模式下缩进代码
vmap({ "<", "<gv" })
vmap({ ">", ">gv" })

-- 分屏快捷键
nmap({ "sv", ":vsp<CR>" })
nmap({ "sh", ":sp<CR>" })

-- 关闭当前
nmap({ "sc", "<C-w>c" })
-- close others
nmap({ "so", "<C-w>o" })

-- 比例控制
nmap({ "s.", ":vertical resize +20<CR>" })
nmap({ "s,", ":vertical resize -20<CR>" })
nmap({ "s=", "<C-w>=" })
nmap({ "sj", ":resize +10<CR>" })
nmap({ "sk", ":resize -10<CR>" })

-- ctrl + hjkl  窗口之间跳转
nmap({ "<C-h>", "<C-w>h" })
nmap({ "<C-j>", "<C-w>j" })
nmap({ "<C-k>", "<C-w>k" })
nmap({ "<C-l>", "<C-w>l" })
tmap({ "<C-h>", [[<C-\><C-n><C-W>h]] })
tmap({ "<C-j>", [[<C-\><C-n><C-W>j]] })
tmap({ "<C-k>", [[<C-\><C-n><C-W>k]] })
tmap({ "<C-l>", [[<C-\><C-n><C-W>l]] })

nmap({ "<leader>i", "gg=G" })
