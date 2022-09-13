local formatter = require("utils").require_plugin("formatter")
if not formatter then
    return
end

formatter.setup({
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {
        lua = {
            require("formatter.filetypes.lua").stylua,
        },
        python = {
            require("formatter.filetypes.python").black,
        },
        cpp = {
            require("formatter.filetypes.cpp").clangformat,
        },
        fish = {
            require("formatter.filetypes.fish").fishindent,
        },
        rust = {
            require("formatter.filetypes.rust").rustfmt,
        },

        ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace,
        },
    },
})
