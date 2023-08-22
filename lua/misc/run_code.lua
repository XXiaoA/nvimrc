local fn = vim.fn
local nmap = require("core.keymap").nmap

local function run_code()
    local file = fn.expand("%:p")
    local file_type = vim.api.nvim_buf_get_option(0, "filetype")

    vim.cmd("silent w")

    if file_type == "lua" then
        vim.cmd("so")
    elseif file_type == "rust" then
        vim.cmd("RustRun")
    elseif file_type == "python" then
        vim.cmd(
            [[ AsyncRun -mode=term -reuse -listed=0 -focus=0 -rows=6 python "$(VIM_FILEPATH)" ]]
        )
    elseif file_type == "fish" then
        vim.notify(fn.system("fish " .. file))
    elseif file_type == "cpp" then
        local exe_dir = (fn.expand("%:p:h") .. "/build")
        if fn.isdirectory(exe_dir) == 0 then
            fn.system("mkdir -p " .. exe_dir)
        end
        vim.cmd([[
            AsyncRun -mode=term -reuse -listed=0 -focus=0 -rows=6 g++ "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/build/$(VIM_FILENOEXT)" && "$(VIM_FILEDIR)/build/$(VIM_FILENOEXT)"
            ]])
    end
end

local function build_code()
    local file = fn.expand("%:p")
    local file_type = vim.api.nvim_buf_get_option(0, "filetype")

    vim.cmd("silent w")
    if file_type == "cpp" then
        local exe_dir = (fn.expand("%:p:h") .. "/build")
        if fn.isdirectory(exe_dir) == 0 then
            fn.system("mkdir -p " .. exe_dir)
        end
        vim.cmd([[
            AsyncRun -reuse -listed=0 -focus=0 -rows=6 g++ "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/build/$(VIM_FILENOEXT)"
            ]])
    end
end

nmap("<F5>", run_code, { desc = "Run code" })
nmap("<F4>", build_code, { desc = "Build code" })
