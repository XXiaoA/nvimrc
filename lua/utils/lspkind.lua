local M = {}

local icons = {
    File = "",
    Module = "", -- ""
    Namespace = "",
    Snippet = "",
    Package = "",
    Class = "ﴯ", -- " "
    Method = "",
    Property = "", --  "ﰠ,
    Keyword = "",
    Field = "", --ﰠ"
    Constructor = "", -- "
    Enum = "練", -- ""
    Interface = "練", -- ""
    Function = "",
    Variable = "", -- " "
    Constant = "",
    String = "",
    Number = "",
    Boolean = "◩",
    Array = "",
    Object = "",
    Key = "",
    Null = "ﳠ",
    EnumMember = "",
    Struct = "פּ", -- " "
    Event = "",
    Operator = "",
    TypeParameter = "",
    Text = "",
    Unit = "塞",
    Value = "",
    Color = "",
    Reference = "",
    Folder = "",

    MarkdownH1 = "󰉫 ",
    MarkdownH2 = "󰉬 ",
    MarkdownH3 = "󰉭 ",
    MarkdownH4 = "󰉮 ",
    MarkdownH5 = "󰉯 ",
    MarkdownH6 = "󰉰 ",
    Call = "󰃷 ",
    BreakStatement = "󰙧 ",
    CaseStatement = "󱃙 ",
    ContinueStatement = "→ ",
    Copilot = " ",
    Declaration = "󰙠 ",
    Delete = "󰩺 ",
    DoStatement = "󰑖 ",
    ForStatement = "󰑖 ",
    Identifier = "󰀫 ",
    IfStatement = "󰇉 ",
    List = "󰅪 ",
    Log = "󰦪 ",
    Lsp = " ",
    Macro = "󰁌 ",
    Regex = " ",
    Repeat = "󰑖 ",
    Scope = "󰅩 ",
    Specifier = "󰦪 ",
    Statement = "󰅩 ",
    SwitchStatement = "󰺟 ",
    Terminal = " ",
    Type = " ",
    WhileStatement = "󰑖 ",
}

M.diagnostic = {
    Error = "󰅚 ",
    Warn = "󰀪 ",
    Hint = "󰌶 ",
    Info = "󰋽 ",
}

M.icons = vim.tbl_map(function(value)
    return require("utils").trim(value)
end, icons)

M.icons_with_whitespaces = vim.tbl_map(function(value)
    return value .. " "
end, M.icons)

return M
