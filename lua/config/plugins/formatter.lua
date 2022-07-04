local formatter = require("utils").requirePlugin("formatter")

if not formatter then
    return
end

local lua_config = {
    function()
        return {
            exe = "stylua",
            args = {
                "--config-path " .. os.getenv("XDG_CONFIG_HOME") .. "/nvim/.stylua.toml",
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
            args = {
                "-style=file:" .. os.getenv("XDG_CONFIG_HOME") .. "/nvim/.clang-format",
                "-",
            },
            stdin = true,
        }
    end,
}

local fish_config = {
    function()
        return {
            exe = "fish_indent",
            stdin = true,
        }
    end,
}

local rust_config = {
    function()
        return {
            exe = "rustfmt",
            stdin = true,
        }
    end,
}

formatter.setup({
    filetype = {
        lua = lua_config,
        python = python_config,
        cpp = cpp_config,
        fish = fish_config,
        rust = rust_config,
    },
})
