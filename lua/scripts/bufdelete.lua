-- inspired by https://github.com/famiu/bufdelete.nvim
local api = vim.api
local bo = vim.bo

local function Bdelete(bufnr, bang)
    -- bufnr is string from user command and it's maybe nil
    bufnr = tonumber(bufnr) or 0
    bufnr = bufnr == 0 and api.nvim_get_current_buf() or bufnr
    bang = bang or false

    -- If buffer is modified and bang isn't true, print error and abort
    if not bang and bo[bufnr].modified then
        api.nvim_echo({
            {
                string.format(
                    "No write since last change for buffer %d. Would you like to:\n"
                        .. "(s)ave and close\n(i)gnore changes and close\n(c)ancel",
                    bufnr
                ),
            },
        }, false, {})
        local choice = string.char(vim.fn.getchar())
        if choice:lower() == "s" then
            vim.cmd.write()
        elseif choice:lower() == "i" then
            bang = true
        else
            return
        end
    end

    -- Check if buffer still exists, to ensure the target buffer wasn't killed
    -- due to options like bufhidden=wipe.
    if api.nvim_buf_is_valid(bufnr) then
        local command = bang and "bd!" or "bd"
        local force = not vim.bo.buflisted or vim.bo.buftype == "nofile"
        vim.cmd(force and "bd!" or string.format("bp | %s %d", command, bufnr))
    end
end

vim.api.nvim_create_user_command("Bdelete", function(ctx)
    Bdelete(ctx.args, ctx.bang)
end, {
    nargs = "?",
    bang = true,
    desc = "Delete the current Buffer while maintaining the window layout",
})

local nmap = require("core.keymap").nmap
nmap("<leader>bd", ":Bdelete<CR>", { desc = "Close current buffer" })
