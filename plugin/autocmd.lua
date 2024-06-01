---@diagnostic disable: param-type-mismatch, missing-fields

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
        local bf = api.nvim_get_option_value("filetype", { buf = buf })
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

-- Disable inserting comment leader after hitting o or O
au("FileType", {
    command = "set formatoptions-=o",
    group = xxiaoa_group,
})

-- When saving a file, automatically create the file's parent
local function mkdir()
    if vim.bo.filetype == "oil" then
        return
    end
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
    callback = stop_hl,
    desc = "Auto remove hlsearch",
})
au("CursorMoved", {
    group = xxiaoa_group,
    callback = start_hl,
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

-- escape the special regex characters
local function escape_regex_chars(str)
    local special_chars_to_escape = { ".", "^", "$", "*", "+", "-", "?", "[", "]", "(", ")", "{", "}", "|" }
    for _, char in ipairs(special_chars_to_escape) do
        str = str:gsub("%" .. char, "\\" .. char)
    end
    return str
end

-- automatically hint after entering nvim and opening a new file
-- TODO: add support for changing fish shell history
local function enter_hint()
    if vim.bo.ft == "oil" then
        return
    end

    local cur_file = vim.fn.expand("<afile>:t")
    local cwd = vim.fn.getcwd()
    local file_dir = vim.fn.expand("<afile>:p:h")
    -- set the cwd which the below command will use
    vim.api.nvim_set_current_dir(file_dir)

    if cur_file ~= "" and vim.fn.findfile(cur_file, ".") == "" then
        local findfile_command = vim.fn.executable("fd") == 1 and "fd . -t f --max-depth 1 --hidden"
            or "find . -maxdepth 1 -type f -printf '%P\n'" -- remove the `./` prefix
        local fuzzy_command = vim.fn.executable("rg") == 1 and "rg --ignore-case" or "grep --ignore-case"
        local command = ("%s | %s '^%s'"):format(findfile_command, fuzzy_command, escape_regex_chars(cur_file))
        local selections = vim.split(vim.fn.system(command), "\n")
        -- remove the trailing newline
        table.remove(selections, #selections)

        if #selections == 0 then
            return
        end

        vim.ui.select(selections, {
            prompt = "Do you mean?",
            format_item = function(item)
                return item
            end,
        }, function(choice)
            if choice then
                vim.api.nvim_buf_delete(0, {})
                vim.cmd.e(file_dir .. "/" .. choice)
            end
        end)
    end

    -- reset the cwd
    vim.api.nvim_set_current_dir(cwd)
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

-- template for competitive code
au("BufNewFile", {
    group = xxiaoa_group,
    pattern = vim.env.HOME .. "/Workspace/oj*/*.cpp",
    command = "0r ~/.config/nvim/templates/oi.cpp",
})
