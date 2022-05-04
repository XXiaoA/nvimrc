local o = vim.opt
local g = vim.g

o.list = true
o.listchars:append("space:⋅")
o.listchars:append("eol:↴")

local indent_blankline = require("utils").requirePlugin("indent_blankline")
indent_blankline.setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true
}

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
