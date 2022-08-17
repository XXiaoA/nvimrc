-- Call the setup function to change the default behavior
local aerial = require("utils").requirePlugin("aerial")
if not aerial then
    return
end


aerial.setup({
    backends = { "lsp", "treesitter", "markdown" },
    filter_kind = {
        "Array",
        "Boolean",
        "Class",
        "Constant",
        "Constructor",
        "Enum",
        "EnumMember",
        "Event",
        "Field",
        "File",
        "Function",
        "Interface",
        "Key",
        "Method",
        "Module",
        "Namespace",
        "Null",
        "Number",
        "Object",
        "Operator",
        "Package",
        "Property",
        "String",
        "Struct",
        "TypeParameter",
        "Variable",
    },
})

-- telescope support
local telescope = require("utils").requirePlugin("telescope")
if telescope then
    telescope.load_extension("aerial")
end
