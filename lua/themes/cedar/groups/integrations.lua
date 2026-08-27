--- Plugin integration groups (everything else falls back to generic UI groups).
local M = {}

---@param p table palette
---@return table<string, table>
function M.get(p)
    local groups = {}

    local function merge(plugin_groups)
        groups = vim.tbl_extend("force", groups, plugin_groups)
    end

    -- gitsigns
    merge({
        GitSignsAdd = { fg = p.green },
        GitSignsChange = { fg = p.yellow },
        GitSignsDelete = { fg = p.red },
        GitSignsAddNr = { fg = p.green, bold = true },
        GitSignsChangeNr = { fg = p.yellow, bold = true },
        GitSignsDeleteNr = { fg = p.red, bold = true },
        GitSignsAddLn = { fg = p.green, bg = p.diff_add_bg },
        GitSignsChangeLn = { fg = p.yellow, bg = p.diff_change_bg },
        GitSignsDeleteLn = { fg = p.red, bg = p.diff_delete_bg },
        GitSignsUntracked = { fg = p.grey },
        GitSignsCurrentLineBlame = { fg = p.grey, italic = true },
    })

    -- diffview
    merge({
        DiffviewFilePanelTitle = { fg = p.teal, bold = true },
        DiffviewFilePanelCounter = { fg = p.grey },
        DiffviewFilePanelFileName = { fg = p.fg },
        DiffviewFilePanelPath = { fg = p.grey },
        DiffviewStatusAdded = { fg = p.green },
        DiffviewStatusModified = { fg = p.yellow },
        DiffviewStatusDeleted = { fg = p.red },
        DiffviewStatusRenamed = { fg = p.teal },
        DiffviewStatusUntracked = { fg = p.grey },
        DiffviewDiffAdd = { bg = p.diff_add_bg },
        DiffviewDiffChange = { bg = p.diff_change_bg },
        DiffviewDiffDelete = { bg = p.diff_delete_bg },
        DiffviewDiffText = { bg = p.diff_text_bg },
        DiffviewCursorLine = { link = "CursorLine" },
        DiffviewVertSplit = { link = "WinSeparator" },
    })

    -- neo-tree
    merge({
        NeoTreeRootName = { fg = p.teal, bold = true },
        NeoTreeDirectoryName = { fg = p.teal },
        NeoTreeDirectoryIcon = { fg = p.teal },
        NeoTreeFileNameOpened = { fg = p.blue },
        NeoTreeFileNameModified = { fg = p.yellow },
        NeoTreeIndentMarker = { fg = p.grey_dim },
        NeoTreeExpander = { fg = p.grey },
        NeoTreeGitAdded = { fg = p.green },
        NeoTreeGitModified = { fg = p.yellow },
        NeoTreeGitDeleted = { fg = p.red },
        NeoTreeGitConflict = { fg = p.orange, bold = true },
        NeoTreeCursorLine = { bg = p.bg_hl },
        NeoTreeDimText = { fg = p.grey },
        NeoTreeFloatBorder = { fg = p.border, bg = p.bg_alt },
        NeoTreeFloatTitle = { fg = p.teal, bg = p.bg_alt, bold = true },
    })

    -- oil.nvim
    merge({
        OilDir = { fg = p.teal },
        OilDirIcon = { fg = p.teal },
        OilFile = { fg = p.fg },
        OilFileIcon = { fg = p.fg_alt },
        OilCursorLine = { bg = p.bg_hl },
    })

    -- noice
    merge({
        NoiceCmdlinePopupBorder = { fg = p.border, bg = p.bg_alt },
        NoiceCmdlineIcon = { fg = p.teal },
        NoicePopupBorder = { fg = p.border, bg = p.bg_alt },
        NoicePopupTitle = { fg = p.teal, bold = true },
        NoicePopupMenu = { fg = p.fg, bg = p.bg_alt },
        NoicePopupMenuSelected = { fg = p.on_accent, bg = p.teal, bold = true },
        NoiceVirtualText = { fg = p.grey },
    })

    -- notify
    merge({
        NotifyBackground = { fg = p.fg, bg = p.bg_alt },
        NotifyERRORBorder = { fg = p.red, bg = p.bg_alt },
        NotifyWARNBorder = { fg = p.yellow, bg = p.bg_alt },
        NotifyINFOBorder = { fg = p.blue, bg = p.bg_alt },
        NotifyDEBUGBorder = { fg = p.grey, bg = p.bg_alt },
        NotifyTRACEBorder = { fg = p.violet, bg = p.bg_alt },
        NotifyERRORIcon = { fg = p.red },
        NotifyWARNIcon = { fg = p.yellow },
        NotifyINFOIcon = { fg = p.blue },
        NotifyDEBUGIcon = { fg = p.grey },
        NotifyTRACEIcon = { fg = p.violet },
    })

    -- fidget
    merge({
        FidgetTitle = { fg = p.teal, bold = true },
        FidgetTask = { fg = p.teal },
        FidgetDone = { fg = p.green },
    })

    -- fzf-lua
    merge({
        FzfLuaBorder = { fg = p.border, bg = p.bg_alt },
        FzfLuaNormal = { fg = p.fg, bg = p.bg_alt },
        FzfLuaTitle = { fg = p.teal, bg = p.bg_alt, bold = true },
        FzfLuaPreviewNormal = { fg = p.fg, bg = p.bg },
        FzfLuaPreviewBorder = { fg = p.border, bg = p.bg },
        FzfLuaCursorLine = { bg = p.bg_hl },
        FzfLuaCursorLineNr = { fg = p.teal, bold = true },
        FzfLuaSearch = { fg = p.fg, bg = p.search_bg },
        FzfLuaPathLineNr = { fg = p.grey_dim },
        FzfLuaLivePrompt = { fg = p.fg, bold = true },
        FzfLuaLiveSym = { fg = p.teal },
        FzfLuaDirPart = { fg = p.grey_dim },
        FzfLuaFilePart = { fg = p.fg },
    })

    -- leap
    merge({
        LeapMatch = { fg = p.on_accent, bg = p.teal, bold = true },
        LeapLabelPrimary = { fg = p.on_accent, bg = p.violet, bold = true },
        LeapLabelSecondary = { fg = p.on_accent, bg = p.blue, bold = true },
        LeapBackdrop = { bg = "#000000", blend = 60 },
    })

    -- nvim-hlslens
    merge({
        HlSearchLens = { fg = p.on_accent, bg = p.teal, bold = true },
        HlSearchLensNear = { fg = p.incsearch_fg, bg = p.incsearch_bg, bold = true },
    })

    -- ufo
    merge({
        UfoFoldedFg = { fg = p.grey },
        UfoFoldedBg = { bg = p.bg_hl },
        UfoCursorFoldedLine = { bg = p.bg_hl },
    })

    -- aerial
    merge({
        AerialLine = { bg = p.bg_hl },
        AerialGuide = { fg = p.grey_dim },
    })

    -- treesitter-context (keep original syntax colors, decorate only)
    merge({
        TreesitterContext = { bg = p.bg_dim },
        TreesitterContextLineNumber = { fg = p.grey_dim },
        TreesitterContextBottom = { underline = true, sp = p.border },
    })

    -- vim-illuminate (grey bg like everforest's current word)
    merge({
        IlluminatedWordText = { bg = p.bg_hl },
        IlluminatedWordRead = { bg = p.bg_hl },
        IlluminatedWordWrite = { bg = p.bg_hl },
    })

    -- mason
    merge({
        MasonHeader = { fg = p.teal, bold = true },
        MasonHeaderSecondary = { fg = p.teal },
        MasonHighlight = { fg = p.teal, bold = true },
        MasonHighlightBlock = { fg = p.fg, bg = p.bg_alt },
        MasonMuted = { fg = p.grey },
        MasonMutedBlock = { fg = p.grey, bg = p.bg_dim },
    })

    -- quicker.nvim
    merge({
        QuickerLine = { bg = p.bg_hl },
        QuickerBorder = { fg = p.border, bg = p.bg_alt },
    })

    -- undotree
    merge({
        UndotreeNodeCurrent = { fg = p.teal, bold = true },
        UndotreeCurrent = { fg = p.orange },
        UndotreeNext = { fg = p.blue },
        UndotreeSavedBig = { fg = p.green, bold = true },
        UndotreeBranch = { fg = p.violet },
    })

    -- mini.clue
    merge({
        ClueTitle = { fg = p.teal, bold = true },
        ClueDesc = { fg = p.fg },
        ClueBorder = { fg = p.border, bg = p.bg_alt },
    })

    -- nvim-scrollview
    merge({
        ScrollViewCursorLine = { fg = p.orange },
        ScrollViewConflict = { fg = p.red },
        ScrollViewSearch = { fg = p.teal },
    })

    -- showkeys
    merge({
        ShowkeysHint = { fg = p.grey },
        ShowkeysFeedback = { fg = p.teal, bold = true },
    })

    -- lazy.nvim
    merge({
        LazyButtonActive = { fg = p.on_accent, bg = p.teal, bold = true },
        LazyProgressDone = { fg = p.green, bold = true },
        LazyProgressTodo = { fg = p.grey_dim, bold = true },
    })

    -- glance
    merge({
        GlanceListCursorLine = { bg = p.bg_hl },
        GlanceListFilename = { fg = p.teal },
        GlanceListMatch = { fg = p.orange, bold = true },
        GlanceWinbarTitle = { fg = p.teal, bold = true },
    })

    -- zen-mode
    merge({
        ZenBg = { fg = p.fg, bg = p.bg },
    })

    -- matchup (decoration only, colors stay intact)
    merge({
        MatchWord = { underline = true },
        MatchWordCur = { bold = true, underline = true },
        MatchParenCur = { bold = true, underline = true },
    })

    -- nvim-surround
    merge({
        NvimSurroundHighlight = { bg = p.bg_hl },
    })

    -- rainbow-delimiters
    merge({
        RainbowDelimiterRed = { fg = p.red },
        RainbowDelimiterOrange = { fg = p.orange },
        RainbowDelimiterYellow = { fg = p.yellow },
        RainbowDelimiterGreen = { fg = p.green },
        RainbowDelimiterCyan = { fg = p.cyan },
        RainbowDelimiterBlue = { fg = p.blue },
        RainbowDelimiterViolet = { fg = p.violet },
    })

    -- blink.cmp
    merge({
        BlinkCmpMenu = { fg = p.fg, bg = p.bg_alt },
        BlinkCmpMenuBorder = { fg = p.border, bg = p.bg_alt },
        BlinkCmpMenuSelection = { fg = p.on_accent, bg = p.teal, bold = true },
        BlinkCmpLabel = { fg = p.fg },
        BlinkCmpLabelDetail = { fg = p.grey },
        BlinkCmpLabelDescription = { fg = p.grey },
        BlinkCmpLabelMatch = { fg = p.teal, bold = true },
        BlinkCmpLabelMatchSelection = { fg = p.on_accent, bg = p.teal, bold = true },
        BlinkCmpKind = { fg = p.orange },
        BlinkCmpKindDefault = { fg = p.grey },
        BlinkCmpKindKeyword = { fg = p.red },
        BlinkCmpKindClass = { fg = p.orange },
        BlinkCmpKindInterface = { fg = p.orange },
        BlinkCmpKindStruct = { fg = p.orange },
        BlinkCmpKindTypeParameter = { fg = p.orange },
        BlinkCmpKindEnum = { fg = p.orange },
        BlinkCmpKindEnumMember = { fg = p.orange },
        BlinkCmpKindFunction = { fg = p.teal },
        BlinkCmpKindMethod = { fg = p.teal },
        BlinkCmpKindConstructor = { fg = p.blue },
        BlinkCmpKindVariable = { fg = p.blue },
        BlinkCmpKindField = { fg = p.teal },
        BlinkCmpKindProperty = { fg = p.teal },
        BlinkCmpKindModule = { fg = p.teal },
        BlinkCmpKindConstant = { fg = p.orange },
        BlinkCmpKindValue = { fg = p.orange },
        BlinkCmpKindUnit = { fg = p.orange },
        BlinkCmpKindText = { fg = p.grey },
        BlinkCmpKindSnippet = { fg = p.yellow },
        BlinkCmpKindFolder = { fg = p.teal },
        BlinkCmpKindFile = { fg = p.teal },
        BlinkCmpKindReference = { fg = p.fg_alt },
        BlinkCmpKindOperator = { fg = p.fg_alt },
        BlinkCmpKindEvent = { fg = p.orange },
        BlinkCmpKindColor = { fg = p.orange },
        BlinkCmpDoc = { fg = p.fg, bg = p.bg_alt },
        BlinkCmpDocBorder = { fg = p.border, bg = p.bg_alt },
        BlinkCmpSignature = { fg = p.fg, bg = p.bg_alt },
        BlinkCmpSignatureBorder = { fg = p.border, bg = p.bg_alt },
        BlinkCmpGhostText = { fg = p.grey },
    })

    return groups
end

return M
