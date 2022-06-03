local formatter = require("utils").requirePlugin("formatter")

local lua_config = {
    function()
        return {
            exe = "stylua",
            args = {
                "--indent-type Spaces",
                "--",
                "-",
            },
            stdin = true,
        }
    end,
}

local python_config = {
    function()
        return {
            exe = "black",
            args = { "-" },
            stdin = true,
        }
    end,
}

local cpp_config = {
    function()
        return {
            exe = "clang-format",
            args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
            stdin = true,
            cwd = vim.fn.expand("%:p:h"), -- Run clang-format in cwd of the file.
        }
    end,
}

if formatter then
    formatter.setup({
        filetype = {
            lua = lua_config,
            python = python_config,
            cpp = cpp_config,
        },
    })
end
