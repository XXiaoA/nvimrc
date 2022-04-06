local ok, tsc = pcall(require, "nvim-treesitter.configs")
if not ok then
    vim.notify(' nvim-treesitter.configs failed to load')
    return
end

tsc.setup {
    -- 安装 language parser
    -- :TSInstallInfo 命令查看支持的语言
    ensure_installed = {"markdown", "vim", "lua","python", "c", 'cpp', 'org'},
    -- 启用代码高亮功能
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true
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
            init_selection = 'gnn',
            node_incremental = 'gnn',
            node_decremental = 'grc',
            scope_incremental = 'grm',
        }
    },
    -- 基于Treesitter的代码格式化(=) . NOTE: This is an experimental feature.
    indent = {
        enable = false,
    }
}
-- 开启 Folding
-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
-- vim.wo.foldlevel = 99
