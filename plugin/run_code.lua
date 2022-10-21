local fn = vim.fn

local nmap = require("core.keymap").set_keymap("n")

local function run_code()
    local file = fn.expand("%:p")
    local file_type = vim.api.nvim_buf_get_option(0, "filetype")

    vim.cmd("silent w")

    if file_type == "lua" then
        vim.cmd("so")
    elseif file_type == "rust" then
        vim.cmd("RustRun")
    elseif file_type == "python" then
        vim.notify(fn.system("python3 " .. file))
    elseif file_type == "fish" then
        vim.notify(fn.system("fish " .. file))
    elseif file_type == "cpp" then
        vim.cmd("!g++ % -o %<.out")
        vim.notify(fn.system("./" .. fn.expand("%:r") .. ".out"))
    end
end

nmap("<F5>", run_code, { desc = "Run code" })
