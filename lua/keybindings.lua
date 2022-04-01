-- Function for make mapping easier.
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true,
    silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {
    noremap = true,
    silent = true
}

-- leader key 为空格
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- {{{"基础
-- 退出终端插入模式
map('t', '<ESC>', [[<C-\><C-n>]])
map('t', 'jk', [[<C-\><C-n>]])

-- 移动代码
map('n', '<A-up>', ':m .-2<cr>')
map('n', '<A-down>', ':m .+1<cr>')
map('i', '<A-up>', '<ESC>:m .-2<cr>i')
map('i', '<A-down>', '<ESC>:m .+1<cr>i')
map('v', '<A-up>', ":m '<-2<cr>gv")
map('v', '<A-down>', ":m '>+1<cr>gv")

-- 移动到行首/行末
map("i", "<C-h>", "<ESC>I")
map("i", "<C-l>", "<ESC>A")

-- 保存/退出
map("n", "W", ":w<CR>")
map("n", "Q", ":q<cr>")

-- ctrl u / ctrl + d  只移动10行，默认移动半屏
map("n", "<C-u>", "10k")
map("n", "<C-d>", "10j")

-- 输入模式/选择模式 jk/JK 退出
map("v", "JK", "<ESC>")
map("i", "jk", "<ESC>")
map("i", "JK", "<ESC>")

-- visual模式下缩进代码
map("v", "<", "<gv")
map("v", ">", ">gv")

-- 运行代码
map('n', '<leader>cr', ':call RunCode()<cr>')

-- 分屏快捷键
map("n", "sv", ":vsp<CR>")
map("n", "sh", ":sp<CR>")

-- 关闭当前
map("n", "sc", "<C-w>c")
-- 关闭其他
map("n", "so", "<C-w>o") -- close others

-- 比例控制
map("n", "s.", ":vertical resize +20<CR>")
map("n", "s,", ":vertical resize -20<CR>")
map("n", "s=", "<C-w>=")
map("n", "sj", ":resize +10<CR>")
map("n", "sk", ":resize -10<CR>")

-- ctrl + hjkl  窗口之间跳转
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map('t', '<C-h>', [[<C-\><C-n><C-W>h]])
map('t', '<C-j>', [[<C-\><C-n><C-W>j]])
map('t', '<C-k>', [[<C-\><C-n><C-W>k]])
map('t', '<C-l>', [[<C-\><C-n><C-W>l]])

-- }}}

-- 插件快捷键{{{
-- nvim-treesitter 代码格式化
map("n", "<leader>i", "gg=G")


-- hlslens
map('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
map('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
map('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]])
map('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]])
map('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]])
map('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]])



-- lsp 回调函数快捷键设置
local pluginKeys = {}
pluginKeys.maplsp = function(mapbuf)
    -- rename
    mapbuf('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opt)
    -- code action
    mapbuf('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opt)

    -- go xx
    mapbuf('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
    mapbuf('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)
    mapbuf('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opt)
    mapbuf('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opt)
    mapbuf('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opt)

    -- diagnostic
    mapbuf('n', 'go', '<cmd>lua vim.diagnostic.open_float()<CR>', opt)
    mapbuf('n', 'gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opt)
    mapbuf('n', 'gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opt)
    -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')
    mapbuf('n', '<gk>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opt)
    mapbuf('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opt)
    -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
    -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
    -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
    -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
end

-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
    return {
        -- 上一个
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        -- 下一个
        ['<C-j>'] = cmp.mapping.select_next_item(),
        -- 出现补全
        ['<A-.>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        -- 取消
        ['<A-,>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- 确认
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({
            select = true ,
            behavior = cmp.ConfirmBehavior.Replace
        }),
        -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    }
end


return pluginKeys--}}}
