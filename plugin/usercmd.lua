local api = vim.api

api.nvim_create_user_command("XXiaoA", function(ctx)
    if ctx.args == "all_colorschemes" then
        vim.pretty_print(vim.tbl_keys(require("core.colorscheme").all_colorschemes))
    elseif ctx.args == "config" then
        vim.cmd.e(vim.fn.stdpath("config") .. "/config.yml")
    end
end, {
    nargs = 1,
    complete = function(arg)
        local list = { "all_colorschemes", "config" }
        return vim.tbl_filter(function(s)
            return string.match(s, "^" .. arg)
        end, list)
    end,
})
