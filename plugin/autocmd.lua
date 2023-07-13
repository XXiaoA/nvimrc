local utils = require("utils")
local api = vim.api
local nmap = require("core.keymap").nmap
local au = api.nvim_create_autocmd

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

au("BufEnter", { callback = quit_current_win, group = xxiaoa_group })
-- }}}

-- smart number from https://github.com/jeffkreeftmeijer/vim-numbertoggle {{{

au({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
    command = [[if &nu && mode() != 'i' | set rnu   | endif]],
    group = xxiaoa_group,
})

au({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
    command = [[if &nu | set nornu | endif]],
    group = xxiaoa_group,
})
-- }}}

-- Disable inserting comment leader after hitting o or O or <Enter>
au("FileType", {
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

au({ "BufWritePre", "FileWritePre" }, {
    callback = mkdir,
    group = xxiaoa_group,
})

-- restore last position
au("BufReadPost", {
    pattern = "*",
    group = xxiaoa_group,
    command = [[
    if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        exe "normal! g`\""
    endif
    ]],
})

-- highlight after yanking the text
au("TextYankPost", {
    group = xxiaoa_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
    end,
})

-- automatically set cursorline
au({ "WinEnter", "BufEnter", "InsertLeave" }, {
    group = xxiaoa_group,
    pattern = "*",
    callback = function()
        if not vim.opt_local.cursorline:get() then
            vim.opt_local.cursorline = true
        end
    end,
})
au({ "WinLeave", "BufLeave", "InsertEnter" }, {
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

au("InsertEnter", {
    group = xxiaoa_group,
    callback = function()
        stop_hl()
    end,
    desc = "Auto remove hlsearch",
})
au("CursorMoved", {
    group = xxiaoa_group,
    callback = function()
        start_hl()
    end,
    desc = "Auto hlsearch",
})

au("FileType", {
    group = xxiaoa_group,
    pattern = { "qf", "help", "man", "startuptime", "checkhealth", "spectre_panel", "fugitive" },
    callback = function(ctx)
        nmap("q", "<cmd>close<CR>", { buffer = ctx.buf })
        vim.opt_local.buflisted = false
    end,
})

-- automatically hint after entering nvim and opening a new file
local function enter_hint()
    local cur_file = vim.fn.expand("<afile>:t")

    if cur_file ~= "" and vim.fn.findfile(cur_file, ".") == "" then
        local findfile_command = vim.fn.executable("fd") == 1 and "fd --max-depth 1"
            or "find -maxdepth 1"
        local fuzzy_command = vim.fn.executable("rg") == 1 and "rg --ignore-case"
            or "grep --ignore-case --extended-regexp"
        local command = ("%s | %s '^(./)?%s'"):format(findfile_command, fuzzy_command, cur_file)
        local selections = vim.fn.system(command)
        selections = vim.tbl_filter(function(s)
            return vim.fn.isdirectory(s) ~= 1 and s ~= ""
        end, vim.split(selections, "\n"))

        if #selections == 0 then
            return
        end

        vim.ui.select(selections, {
            prompt = "Do you mean?",
            format_item = function(item)
                return item
            end,
        }, function(choice)
            vim.api.nvim_buf_delete(0, {})
            vim.cmd.e(choice)
        end)
    end
end

au("VimEnter", {
    group = xxiaoa_group,
    callback = enter_hint,
})

-- lazy load my own scripts
au("User", {
    pattern = "VeryLazy",
    group = xxiaoa_group,
    callback = function()
        utils.require("misc")
    end,
})

-- Prevent entering buffers in insert mode.
-- https://github.com/nvim-telescope/telescope.nvim/issues/2027
au("WinLeave", {
    group = xxiaoa_group,
    callback = function()
        if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
            vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
                "i",
                false
            )
        end
    end,
})
