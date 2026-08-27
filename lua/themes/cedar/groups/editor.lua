--- Editor UI groups: window chrome, floats, search, diff, messages, spell.
local M = {}

---@param p table palette
---@return table<string, table>
function M.get(p)
    return {
        ------------------------------------------------------------------
        -- Window / buffer
        ------------------------------------------------------------------
        Normal = { fg = p.fg, bg = p.bg },
        NormalNC = { fg = p.fg_alt, bg = p.bg },
        NormalFloat = { fg = p.fg, bg = p.bg_alt },
        NormalPopup = { fg = p.fg, bg = p.bg_alt },
        NormalPopover = { fg = p.fg, bg = p.bg_alt },
        EndOfBuffer = { fg = p.bg, bg = p.bg },
        MsgArea = { fg = p.fg, bg = p.bg },
        MsgSeparator = { fg = p.grey_dim, bg = p.bg },

        Visual = { bg = p.selection },
        VisualNOS = { bg = p.selection },

        LineNr = { fg = p.grey_dim, bg = p.bg },
        LineNrAbove = { fg = p.grey_dim, bg = p.bg },
        LineNrBelow = { fg = p.grey_dim, bg = p.bg },
        Cursor = { bg = p.cursor },
        CursorIM = { bg = p.cursor },
        CursorLine = { bg = p.bg_hl },
        CursorLineNr = { fg = p.teal, bg = p.bg_hl, bold = true },
        CursorLineSign = { bg = p.bg_hl },
        CursorLineFold = { bg = p.bg_hl },
        CursorColumn = { bg = p.bg_hl },
        QuickFixLine = { bg = p.bg_hl },
        qfLineNr = { fg = p.grey_dim },

        Folded = { fg = p.grey, bg = p.bg_hl },
        FoldColumn = { fg = p.grey_dim, bg = p.bg },
        SignColumn = { fg = p.fg, bg = p.bg },
        ColorColumn = { bg = p.bg_hl },

        WinSeparator = { fg = p.border, bg = p.bg },
        WinBar = { fg = p.fg_alt, bg = p.bg, bold = true },
        WinBarNC = { fg = p.grey, bg = p.bg },

        FloatBorder = { fg = p.border, bg = p.bg_alt },
        FloatTitle = { fg = p.teal, bg = p.bg_alt, bold = true },
        FloatFooter = { fg = p.grey, bg = p.bg_alt },
        FloatShadow = { bg = "#000000", blend = 25 },
        FloatShadowThrough = { bg = "#000000", blend = 25 },

        TabLine = { fg = p.fg_alt, bg = p.bg_dim },
        TabLineSel = { fg = p.fg, bg = p.bg_hl, bold = true },
        TabLineFill = { fg = p.grey_dim, bg = p.bg_dim },

        StatusLine = { fg = p.fg, bg = p.bg_dim },
        StatusLineNC = { fg = p.grey, bg = p.bg_dim },
        StatusLineTerm = { link = "StatusLine" },
        StatusLineTermNC = { link = "StatusLineNC" },

        Pmenu = { fg = p.fg, bg = p.bg_alt },
        PmenuSel = { fg = p.on_accent, bg = p.teal, bold = true },
        PmenuSbar = { bg = p.bg_hl },
        PmenuThumb = { bg = p.grey_dim },
        PmenuKind = { fg = p.orange, bg = p.bg_alt },
        PmenuKindSel = { fg = p.on_accent, bg = p.teal, bold = true },
        PmenuExtra = { fg = p.grey, bg = p.bg_alt },
        PmenuExtraSel = { fg = p.on_accent, bg = p.teal },
        PmenuMatch = { fg = p.teal, bold = true },
        PmenuMatchSel = { fg = p.on_accent, bg = p.teal, bold = true },
        WildMenu = { fg = p.on_accent, bg = p.teal, bold = true },

        ------------------------------------------------------------------
        -- Search / matching
        ------------------------------------------------------------------
        Search = { fg = p.fg, bg = p.search_bg },
        CurSearch = { fg = p.fg, bg = p.search_bg, bold = true },
        IncSearch = { fg = p.incsearch_fg, bg = p.incsearch_bg, bold = true },
        IncSearchCursor = { reverse = true },
        Substitute = { fg = p.red, bg = p.diff_delete_bg, bold = true },

        Conceal = { fg = p.grey_dim },
        NonText = { fg = p.grey_dim },
        Whitespace = { link = "NonText" },
        SpecialKey = { fg = p.grey_dim },
        MatchParen = { bold = true, underline = true },

        Title = { fg = p.violet, bold = true },
        Question = { fg = p.green, bold = true },
        File = { fg = p.fg },
        Directory = { fg = p.teal, bold = true },

        Bold = { bold = true },
        Emphasis = { italic = true },
        Underlined = { underline = true },
        Italic = { italic = true },
        Strikethrough = { strikethrough = true },

        ------------------------------------------------------------------
        -- Diff
        ------------------------------------------------------------------
        DiffAdd = { fg = p.green, bg = p.diff_add_bg },
        DiffChange = { fg = p.yellow, bg = p.diff_change_bg },
        DiffDelete = { fg = p.red, bg = p.diff_delete_bg },
        DiffText = { fg = p.orange, bg = p.diff_text_bg, bold = true },

        Added = { fg = p.green },
        Changed = { fg = p.yellow },
        Removed = { fg = p.red },

        ------------------------------------------------------------------
        -- Messages / health / spell
        ------------------------------------------------------------------
        Msg = { fg = p.green },
        MoreMsg = { fg = p.blue, bold = true },
        WarningMsg = { fg = p.yellow, bold = true },
        Error = { fg = p.red },
        ErrorMsg = { fg = p.red, bold = true },
        ModeMsg = { fg = p.grey, bold = true },
        Todo = { fg = p.violet, bold = true },

        healthHelp = { link = "MoreMsg" },
        healthError = { link = "ErrorMsg" },
        healthSuccess = { link = "Msg" },
        healthWarning = { link = "WarningMsg" },

        SpellBad = { sp = p.red, undercurl = true },
        SpellCap = { sp = p.blue, undercurl = true },
        SpellRare = { sp = p.yellow, undercurl = true },
        SpellLocal = { sp = p.fg_alt, undercurl = true },

        ------------------------------------------------------------------
        -- help files
        ------------------------------------------------------------------
        helpCommand = { fg = p.blue, bold = true },
        helpOption = { fg = p.teal, bold = true },
        helpExample = { fg = p.green },
        helpHyperTextEntry = { fg = p.teal },
        helpHyperTextJump = { fg = p.blue, underline = true },
        helpHeader = { fg = p.violet, bold = true },
        helpSectionDelim = { fg = p.grey_dim },

        TermCursor = { fg = p.on_accent, bg = p.teal },
        TermCursorNC = { bg = p.fg_alt },
    }
end

return M
