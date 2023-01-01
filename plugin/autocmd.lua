local utils = require("utils")
local api = vim.api
local keymap = require("core.keymap")
local nmap = keymap.nmap

local xxiaoa_group = api.nvim_create_augroup("xxiaoa_group", { clear = true })

-- Exit nvim when we only have the following types of windows {{{
local quit_current_win = function()
    local quit_filetypes = { "neo-tree", "aerial" }
    local should_quit = true
    local tabwins = api.nvim_tabpage_list_wins(0)
    for _, w in ipairs(tabwins) do
        local buf = api.nvim_win_get_buf(w)
        local bf = api.nvim_buf_get_option(buf, "filetype")
        if not vim.tbl_contains(quit_filetypes, bf) then
            should_quit = false
        end
    end

    if should_quit then
        vim.cmd("qall")
    end
end

api.nvim_create_autocmd("BufEnter", { callback = quit_current_win, group = xxiaoa_group })
-- }}}

-- smart number from https://github.com/jeffkreeftmeijer/vim-numbertoggle {{{

api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
    command = [[if &nu && mode() != 'i' | set rnu   | endif]],
    group = xxiaoa_group,
})

api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
    command = [[if &nu | set nornu | endif]],
    group = xxiaoa_group,
})
-- }}}

-- Disable inserting comment leader after hitting o or O or <Enter>
api.nvim_create_autocmd("FileType", {
    command = "set formatoptions-=ro",
    group = xxiaoa_group,
})

-- When saving a file, automatically create the file's parent
local function mkdir()
    local dir = vim.fn.expand("<afile>:p:h")
    if not utils.is_directory(dir) then
        vim.fn.mkdir(dir, "p")
    end
end
api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
    callback = mkdir,
    group = xxiaoa_group,
})

-- BUG: doesn't work
-- replace != with ~= in lua file
api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    command = "iabbr <buffer> != ~=",
    group = xxiaoa_group,
})

-- restore last position
api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    group = xxiaoa_group,
    command = [[
    if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        exe "normal! g`\""
    endif
    ]],
})

-- highlight after yanking the text
api.nvim_create_autocmd("TextYankPost", {
    group = xxiaoa_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
    end,
})

-- automatically set cursorline
api.nvim_create_autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
    group = xxiaoa_group,
    pattern = "*",
    callback = function()
        if not vim.opt_local.cursorline:get() then
            vim.opt_local.cursorline = true
        end
    end,
})
api.nvim_create_autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
    group = xxiaoa_group,
    pattern = "*",
    callback = function()
        if vim.opt_local.cursorline:get() then
            vim.opt_local.cursorline = false
        end
    end,
})

-- automatically disable search highlight
-- https://github.com/glepnir/hlsearch.nvim
local function stop_hl()
    if vim.v.hlsearch == 0 then
        return
    end
    local keycode = api.nvim_replace_termcodes("<Cmd>nohl<CR>", true, false, true)
    api.nvim_feedkeys(keycode, "n", false)
end
local function start_hl()
    local res = vim.fn.getreg("/")
    if vim.v.hlsearch == 1 and vim.fn.search([[\%#\zs]] .. res, "cnW") == 0 then
        stop_hl()
    end
end

api.nvim_create_autocmd("InsertEnter", {
    group = xxiaoa_group,
    callback = function()
        stop_hl()
    end,
    desc = "Auto remove hlsearch",
})
api.nvim_create_autocmd("CursorMoved", {
    group = xxiaoa_group,
    callback = function()
        start_hl()
    end,
    desc = "Auto hlsearch",
})

api.nvim_create_autocmd("FileType", {
    group = xxiaoa_group,
    pattern = { "qf", "help", "man", "startuptime", "checkhealth" },
    callback = function(ctx)
        nmap("q", "<cmd>close<CR>", { buffer = ctx.buf })
        vim.opt_local.buflisted = false
    end,
})

api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    group = xxiaoa_group,
    callback = function()
        -- (...) to get first result (root path)
        -- or another means to get root path
        -- https://www.reddit.com/r/neovim/comments/zy5s0l/you_dont_need_vimrooter_usually_or_how_to_set_up/
        local root_path = (require("project_nvim.project").get_project_root())
        if root_path then
            api.nvim_set_current_dir(root_path)
        end
    end,
})
