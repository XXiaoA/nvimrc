local utils = require("utils")
local api = vim.api

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
