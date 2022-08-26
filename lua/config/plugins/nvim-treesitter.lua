local tsc = require("utils").requirePlugin("nvim-treesitter.configs")

if not tsc then
    return
end

tsc.setup({
    -- 安装 language parser
    -- :TSInstallInfo 命令查看支持的语言
    ensure_installed = { "markdown", "vim", "lua", "python", "rust", "fish" },
    -- 启用代码高亮功能
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    -- 彩色括号
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
    -- 增量选择
    incremental_selection = {
        enable = false,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "gnn",
            node_decremental = "grc",
            scope_incremental = "grm",
        },
    },
    -- 基于Treesitter的代码格式化(=) . This is an experimental feature.
    indent = { enable = false },

    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
            selection_modes = {
                ["@parameter.outer"] = "v",
                ["@function.outer"] = "V",
                ["@class.outer"] = "<c-v>",
            },

            include_surrounding_whitespace = true,
        },

        lsp_interop = {
            enable = true,
            border = "single",
            peek_definition_code = {
                ["<leader>df"] = "@function.outer",
            },
        },
    },
})
