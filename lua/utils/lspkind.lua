local M = {}

M.icons = {
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
}

M.icons_with_whitespaces = {}
for name, icon in pairs(M.icons) do
    M.icons_with_whitespaces[name] = icon .. " "
end

return M
