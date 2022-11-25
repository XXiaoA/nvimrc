local fn = vim.fn
local api = vim.api

local save_dir = fn.stdpath("data") .. "/XXiaoA/"
local nmap = require("core.keymap").nmap

-- Gets a set of lines from the buffer, inclusive and 1-indexed.
---@param start integer The starting line.
---@param stop integer The final line.
---@return string[] @A table consisting of the lines from the buffer.
local function get_lines(start, stop)
    stop = stop or start
    local content = api.nvim_buf_get_lines(0, start - 1, stop, false)
    return content
end

local function edit()
    local start_row = fn.searchpos([[\s*```]], [[bnW]])
    local end_row = fn.searchpos([[\s*```]], [[nW]])
    local block_ft = get_lines(start_row[1])[1]:match("%s*```%s*(.*)")
    local block_content = get_lines(start_row[1], end_row[1])
    block_content = vim.list_slice(block_content, 2, vim.tbl_count(block_content) - 1)

    api.nvim_open_win(0, true, {
        relative = "win",
        width = 110,
        height = 20,
        title = "XXiaoA",
        title_pos = "center",
        border = "single",
        row = 20,
        col = 20,
    })

    vim.cmd("e! " .. save_dir .. "XXiaoA")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, block_content)
    api.nvim_buf_set_option(0, "ft", block_ft)
    nmap("sc", function()
        -- TODO: clsoe the LSP
        local new_content = get_lines(1, -1)
        api.nvim_buf_delete(0, { force = true })
        api.nvim_buf_set_lines(0, start_row[1], end_row[1] - 1, true, new_content)
    end, { buffer = true })
end

api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        api.nvim_create_user_command("CodeBlockEdit", edit, {})
    end,
    group = api.nvim_create_augroup("CodeBlockEdit", { clear = true }),
})
