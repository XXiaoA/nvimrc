local colorscheme = require("core.colorscheme")
local api = vim.api

api.nvim_create_user_command("XXiaoA", function(ctx)
    if ctx.args == "colorschemes" then
        vim.print(colorscheme.all_colorschemes)
    elseif ctx.args == "current_colorscheme" then
        vim.print(colorscheme.current_colorscheme())
    elseif ctx.args == "config" then
        vim.cmd.e(vim.fn.stdpath("config") .. "/config.yml")
    else
        vim.print("no command " .. ctx.args)
    end
end, {
    nargs = 1,
    complete = function(arg)
        local list = { "colorschemes", "current_colorscheme", "config" }
        return vim.tbl_filter(function(s)
            return string.match(s, "^" .. arg)
        end, list)
    end,
})
