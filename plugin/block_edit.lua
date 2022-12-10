local fn = vim.fn
local api = vim.api
local utils = require("utils")

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
    local cache_file = save_dir .. fn.rand()
    local start_row = fn.searchpos([[\s*```]], [[bnW]])
    local end_row = fn.searchpos([[\s*```]], [[nW]])
    local block_ft = get_lines(start_row[1])[1]:match("%s*```%s*(.*)")
    local block_content = get_lines(start_row[1], end_row[1])
    block_content = vim.list_slice(block_content, 2, vim.tbl_count(block_content) - 1)

    -- TODO: use suitable position and size of float window
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

    -- write block contents into cache file
    local file = io.open(cache_file, "w+")
    if file then
        for _, line in ipairs(block_content) do
            file:write(line .. "\n")
        end
        file:close()
    end

    vim.cmd("e! " .. cache_file)
    api.nvim_buf_set_option(0, "ft", block_ft)

    -- mappings for quitting float window
    for _, lhs in ipairs({ "sc", "q" }) do
        nmap(lhs, function()
            -- TODO: clsoe the LSP
            local new_content = get_lines(1, -1)
            api.nvim_buf_delete(0, { force = true })
            -- if new content is empty, set the line of block none instead of one empty line
            if #new_content == 1 and new_content[1] == "" then
                api.nvim_buf_set_lines(0, start_row[1], end_row[1] - 1, true, {})
            else
                api.nvim_buf_set_lines(0, start_row[1], end_row[1] - 1, true, new_content)
            end

            -- delete the cache file
            if utils.is_file(cache_file) then
                fn.delete(cache_file)
            end
        end, { buffer = true })
    end
end

api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        api.nvim_create_user_command("CodeBlockEdit", edit, {})
    end,
    group = api.nvim_create_augroup("CodeBlockEdit", { clear = true }),
})
