local api = vim.api
-- Exit nvim when we only have the following types of windows {{{
local quit_current_win = function()
    local quit_filetypes = {"NvimTree", "aerial"}
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

api.nvim_create_autocmd("BufEnter", {callback = quit_current_win})
-- }}}

-- smart number from https://github.com/jeffkreeftmeijer/vim-numbertoggle {{{
local numbertoggle = api.nvim_create_augroup(("numbertoggle"), {clear = true})

api.nvim_create_autocmd(
    {"BufEnter", "FocusGained", "InsertLeave", "WinEnter"},
    {
        command = [[if &nu && mode() != 'i' | set rnu   | endif]],
        group = numbertoggle
    }
)

api.nvim_create_autocmd(
    {"BufLeave", "FocusLost", "InsertEnter", "WinLeave"},
    {
        command = [[if &nu | set nornu | endif]],
        group = numbertoggle
    }
)
-- }}}

api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = "plugins.lua",
        command = "source <afile> | PackerCompile"
    }
)

-- Disable inserting comment leader after hitting o or O or <Enter>
api.nvim_create_autocmd(
    {"BufRead", "BufNewFile"},
    {
        command = "set formatoptions-=ro"
    }
)
