local api = vim.api

api.nvim_create_user_command("XXiaoA", function(ctx)
    if ctx.args == "colorschemes" then
        vim.pretty_print(require("core.colorscheme").all_colorschemes)
    elseif ctx.args == "config" then
        vim.cmd.e(vim.fn.stdpath("config") .. "/config.yml")
    end
end, {
    nargs = 1,
    complete = function(arg)
        local list = { "colorschemes", "config" }
        return vim.tbl_filter(function(s)
            return string.match(s, "^" .. arg)
        end, list)
    end,
})
