-- Function for make mapping easier.
local keymap = require("core.keymap")

local nmap = keymap.nmap
local imap = keymap.imap
local xmap = keymap.xmap
local tmap = keymap.tmap
local omap = keymap.omap

-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Escape in terminal mode
tmap("<ESC>", [[<C-\><C-n>]])

-- Save or quit
nmap("<C-s>", ":w<CR>")
nmap("<C-q>", "<cmd>qa<CR>")

xmap("<", "<gv")
xmap(">", ">gv")

nmap("<c-w>-", "<C-W>s", { desc = "Split window below" })
nmap("<c-w>|", "<C-W>v", { desc = "Split window right" })
nmap("<c-w>\\", "<C-W>v", { desc = "Split window right" })

-- resize
nmap("<A-l>", ":vertical resize -2<CR>")
nmap("<A-h>", ":vertical resize +2<CR>")
nmap("<A-j>", ":resize -1<CR>")
nmap("<A-k>", ":resize +1<CR>")
nmap("<A-=>", "<C-w>=")

-- ctrl + hjkl  jump among windows
nmap("<C-h>", "<C-w>h", { desc = "Jump to left window" })
nmap("<C-j>", "<C-w>j", { desc = "Jump to below window" })
nmap("<C-k>", "<C-w>k", { desc = "Jump to above window" })
nmap("<C-l>", "<C-w>l", { desc = "Jump to right window" })

-- Toggle spelling check
nmap("<leader>sp", "<cmd>set spell!<CR>", { desc = "Toggle spelling check" })

imap("<M-o>", "<C-O>o")
imap("<M-O>", "<C-O>O")
imap("<M-h>", "<Left>")
imap("<M-l>", "<Right>")
imap("<M-H>", "<C-O>^")
imap("<M-L>", "<C-O>$")

nmap("H", "^")
nmap("L", "$")
omap("H", "^")
omap("L", "$")
xmap("H", "^")
xmap("L", "$")

nmap("<A-p>", "<cmd>pu<CR>")
nmap("<A-P>", "<cmd>pu!<CR>")

nmap("<leader>be", ":noh<CR>", { desc = "Erase Search Highlights" })
nmap("<leader>bn", ":enew<CR>", { desc = "New Buffer" })
nmap("<leader>bt", function()
    local winview = vim.fn.winsaveview()
    vim.cmd([[%s/\r$//e]])
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(winview)
end, { desc = "Remove trailing white spaces" })

-- Remap for dealing with word wrap
nmap("k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
nmap("j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
xmap("k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
xmap("j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

imap(",", ",<c-g>u")
imap(".", ".<c-g>u")
imap(";", ";<c-g>u")
imap(":", ":<c-g>u")

-- https://github.com/mhinz/vim-galore#quickly-edit-your-macros
-- Quickly edit your macros
nmap(
    "<leader>m",
    [[:<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>]],
    { desc = "Modify the register" }
)

nmap("[t", "<CMD>tabNext<CR>", { desc = "Previous tab" })
nmap("]t", "<CMD>tabnext<CR>", { desc = "Next tab" })
nmap("<leader><tab><S-tab>", "[t", { remap = true, desc = "Previous tab" })
nmap("<leader><tab><tab>", "]t", { remap = true, desc = "Next tab" })
nmap("<leader><tab>n", "<CMD>tabnew<CR>", { desc = "Create a tab" })
nmap("<leader><tab>d", "<CMD>tabclose<CR>", { desc = "Close tab" })

imap("<C-v>", "<C-r>+", { desc = "Paste" })

keymap.set("s")("<BS>", "<BS>:startinsert<CR>")

nmap("<ESC>", "<CMD>w|e|redraw<CR>")

imap("jj", "<ESC>")

nmap("]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
nmap("[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

local function comment_above_or_below(lnum)
    local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
    local comment_row = row + lnum
    local l_cms, r_cms = string.match(vim.bo.commentstring, "(.*)%%s(.*)")
    l_cms = vim.trim(l_cms)
    r_cms = vim.trim(r_cms)
    if #r_cms ~= 0 then
        r_cms = " " .. r_cms
    end
    vim.api.nvim_buf_set_lines(0, comment_row, comment_row, false, { l_cms .. " " .. r_cms })
    vim.api.nvim_win_set_cursor(0, { comment_row + 1, 0 })
    vim.api.nvim_command("normal! ==")
    vim.api.nvim_win_set_cursor(0, { comment_row + 1, #vim.api.nvim_get_current_line() - #r_cms - 1 })
    vim.api.nvim_feedkeys("a", "ni", true)
end

nmap("gco", function()
    comment_above_or_below(0)
end, { desc = "Comment below" })

nmap("gcO", function()
    comment_above_or_below(-1)
end, { desc = "Comment above" })

nmap("gcA", function()
    local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
    local l_cms, r_cms = string.match(vim.bo.commentstring, "(.*)%%s(.*)")
    l_cms = vim.trim(l_cms)
    r_cms = vim.trim(r_cms)
    if #r_cms ~= 0 then
        r_cms = " " .. r_cms
    end
    local line = vim.api.nvim_get_current_line():gsub("%s*$", "")
    vim.api.nvim_buf_set_lines(0, row - 1, row, false, { line .. " " .. l_cms .. " " .. r_cms })
    vim.api.nvim_win_set_cursor(0, { row, #line + #l_cms + 1 })
    vim.api.nvim_feedkeys("a", "ni", true)
end, { desc = "Comment at the end of line" })

-- remove the default LSP keymaps
vim.keymap.del("n", "grt")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")
vim.keymap.del({ "v", "n" }, "gra")
