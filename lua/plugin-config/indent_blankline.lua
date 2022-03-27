local o = vim.opt
local g = vim.g

o.list = true
o.listchars:append("space:⋅")
o.listchars:append("eol:↴")

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true
}

-- g.indent_blankline_context_patterns = {
--     "class",
--     "function",
--     "method",
--     "^if",
--     "^while",
--     "^typedef",
--     "^for",
--     "^object",
--     "^table",
--     "block",
--     "arguments",
--     "typedef",
--     "while",
--     "^public",
--     "return",
--     "if_statement",
--     "else_clause",
--     "jsx_element",
--     "jsx_self_closing_element",
--     "try_statement",
--     "catch_clause",
--     "import_statement"
-- }

g.indent_blankline_filetype_exclude = {
    "help",
    "startify",
    "TERMINAL",
    "terminal",
    "packer",
    "lsp-installer",
    "",
    "startuptime",
    "toggleterm",
    "translator",
    "dashboard"
}

g.indent_blankline_show_end_of_line = false -- 占用隐藏符号
g.indent_blankline_show_trailing_blankline_indent = false -- 删除多余的缩进线
