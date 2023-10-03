local colorscheme = require("core.colorscheme")
local api = vim.api

api.nvim_create_user_command("XXiaoA", function(ctx)
    if ctx.args == "colorschemes" then
        vim.print(colorscheme.all_colorschemes)
    elseif ctx.args == "current_colorscheme" then
        vim.print(colorscheme.current_colorscheme)
    elseif ctx.args == "oi" then
        if vim.bo.ft ~= "cpp" then
            vim.print("Not in a cpp file")
            return
        else
            api.nvim_buf_set_lines(0, 0, -1, true, {
                "#include <iostream>",
                "using namespace std;",
                "",
                [[int read() {]],
                [[int x = 0, w = 1;]],
                [[char ch = 0;]],
                [[while (ch < '0' || ch > '9') {]],
                [[if (ch == '-')]],
                [[w = -1;]],
                [[ch = getchar();,]],
                [[}]],
                [[while (ch >= '0' && ch <= '9') {]],
                [[x = x * 10 + (ch - '0');]],
                [[ch = getchar();]],
                [[}]],
                [[return x * w;]],
                [[}]],
                "",
                "int main() {",
                "   ios::sync_with_stdio(false);",
                "   int n;",
                "   cin >> n;",
                "",
                "   return 0;",
                "}",
            })
            vim.cmd("w!")
        end
    else
        vim.print("no command " .. ctx.args)
    end
end, {
    nargs = 1,
    complete = function(arg)
        local list = { "colorschemes", "current_colorscheme", "oi" }
        return vim.tbl_filter(function(s)
            return string.match(s, "^" .. arg)
        end, list)
    end,
})
