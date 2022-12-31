local tsc = require("utils").require_plugin("nvim-treesitter.configs")

if not tsc then
    return
end

tsc.setup({
    -- 安装 language parser
    -- :TSInstallInfo 命令查看支持的语言
    ensure_installed = { "markdown", "vim", "lua", "python", "rust", "fish", "cpp" },
    -- 启用代码高亮功能
    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
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
    matchup = {
        enable = true, -- mandatory, false will disable the whole extension
        include_match_words = true,
        -- disable = { "c", "ruby" },
    },
})
