--- Legacy syntax groups and language-specific extras.
--- Italic: control flow + preprocessor + comments. Bold: UI only, syntax stays plain.
local M = {}

---@param p table palette
---@return table<string, table>
function M.get(p)
    return {
        Keyword = { fg = p.red, italic = true },
        KeywordFunction = { link = "Keyword" },
        Conditional = { fg = p.red, italic = true },
        Repeat = { fg = p.red, italic = true },
        Label = { fg = p.blue },
        Statement = { fg = p.red, italic = true },
        Exception = { fg = p.red, italic = true },
        Operator = { fg = p.fg_alt },
        Delimiter = { fg = p.fg_alt },

        Function = { fg = p.teal },
        FunctionBuiltin = { fg = p.teal },
        Method = { fg = p.teal },
        Constructor = { fg = p.blue },

        Variable = { fg = p.blue },
        VariableBuiltin = { fg = p.orange, italic = true }, -- self & friends
        Identifier = { fg = p.fg_alt },
        Argument = { fg = p.orange },

        Constant = { fg = p.orange },
        Number = { fg = p.orange },
        Float = { link = "Number" },
        Boolean = { fg = p.orange, italic = true },
        Enum = { fg = p.orange },
        EnumMember = { fg = p.orange },

        String = { fg = p.green },
        StringDelimiter = { fg = p.fg_alt },
        Character = { fg = p.green },

        Special = { fg = p.teal },
        SpecialChar = { fg = p.teal },
        SpecialBold = { fg = p.teal },
        Debug = { fg = p.orange },

        Property = { fg = p.teal },
        Field = { fg = p.teal },
        Attribute = { fg = p.orange, italic = true },

        Type = { fg = p.orange },
        Typedef = { fg = p.orange, italic = true },
        TypeBuiltin = { fg = p.orange },
        Class = { fg = p.orange, italic = true },
        StorageClass = { fg = p.teal },
        Structure = { fg = p.teal },

        Macro = { fg = p.violet, italic = true },
        Define = { fg = p.violet, italic = true },
        Include = { fg = p.violet, italic = true },
        PreProc = { fg = p.violet, italic = true },
        PreCondit = { fg = p.violet, italic = true },

        Tag = { fg = p.cyan },
        Link = { fg = p.blue, underline = true },
        URL = { link = "Link" },

        Comment = { fg = p.grey, italic = true },
        CommentBold = { fg = p.grey, bold = true, italic = true },
        CommentURL = { link = "URL" },
        CommentLabel = { link = "CommentBold" },
        CommentSection = { link = "CommentBold" },
        SpecialComment = { fg = p.violet, italic = true },

        ------------------------------------------------------------------
        -- Language-specific extras
        ------------------------------------------------------------------
        ["@type.java"] = { fg = p.orange, italic = true },
        ["@type.qualifier.java"] = { fg = p.orange, italic = true },

        -- markdown legacy syntax (treesitter takes over where available)
        markdownH1 = { fg = p.violet, bold = true },
        markdownH2 = { fg = p.violet, bold = true },
        markdownH3 = { fg = p.violet, bold = true },
        markdownH4 = { fg = p.violet, bold = true },
        markdownH5 = { fg = p.violet, bold = true },
        markdownH6 = { fg = p.violet, bold = true },
        markdownHeadingDelimiter = { fg = p.cyan, bold = true },
        markdownHeadingRule = { fg = p.cyan },
        markdownCode = { fg = p.grey },
        markdownCodeBlock = { fg = p.grey },
        markdownCodeDelimiter = { fg = p.grey_dim },
        markdownLinkText = { fg = p.blue, underline = true },
        markdownListMarker = { fg = p.teal },
        markdownBlockquote = { fg = p.grey, italic = true },
        markdownBold = { bold = true },
        markdownItalic = { italic = true },

        tomlKey = { fg = p.teal },
        tomlKeyDq = { fg = p.teal },

        gitcommitSummary = { fg = p.fg, bold = true },
        gitcommitBranch = { fg = p.teal },
        gitcommitOverflow = { fg = p.red, bold = true },
        gitcommitHeader = { fg = p.blue },
        gitcommitSelectedType = { fg = p.green },
        gitcommitDiscardedType = { fg = p.red },
        gitcommitUntrackedType = { fg = p.grey },
        gitcommitSelectedFile = { fg = p.green },
        gitcommitDiscardedFile = { fg = p.red },
        gitcommitUntrackedFile = { fg = p.grey },
        gitcommitUnmergedFile = { fg = p.orange },
        gitcommitUnmergedType = { fg = p.orange },
    }
end

return M
