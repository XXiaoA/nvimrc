local wk = require("utils").requirePlugin("which-key")
local presets = require("utils").requirePlugin("which-key.plugins.presets")

if not wk or not presets then
    return
end

presets.operators["v"] = nil

wk.setup({
    key_labels = {
        ["<space>"] = "SPC",
        ["<leader>"] = "SPC",
        ["<cr>"] = "ENT",
        ["<tab>"] = "TAB",
        ["<a>"] = "ALT",
        ["<s>"] = "SHI",
        ["<c>"] = "CTR",
    },
    window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    ignore_missing = false,
})

-- Packer
wk.register({
    p = {
        name = "Packer",
        i = { ":PackerInstall<CR>", "Clean, then install missing plugins " },
        u = { ":PackerUpdate<CR>", "Clean, then update and install plugins " },
        r = { ":PackerClean<CR>", "Remove any disabled or unused plugins " },
        s = { ":PackerSync<CR>", "Perform `PackerUpdate` and then `PackerCompile`" },
        c = { ":PackerCompile<CR>", "Regenerate compiled loader file" },
        t = { ":PackerStatus<CR>", "Show packer's status" },
    },
}, { prefix = "<leader>" })

wk.register({
    b = {
        name = "Buffer",
        c = { ":BufferLinePickClose<CR>", "Close Buffer" },
        e = { ":noh<CR>", "Erase Search Highlights" },
        l = { ":BufferLineMoveNext<CR>", "Move buffer Right" },
        h = { ":BufferLineMovePrev<CR>", "Move buffer Left" },
        n = { ":DashboardNewFile<CR>", "New Buffer" },
        f = { ":Format<CR>", "Format Buffer" },
    },
}, { prefix = "<leader>" })

wk.register({
    ["<A-h>"] = { ":BufferLineCyclePrev<CR>", "Go to previous buffer" },
    ["<A-l>"] = { ":BufferLineCycleNext<CR>", "Go to next buffer" },
    ["<A-w>"] = { ":Bdelete<CR>", "Close current buffer" },
})

-- File Explorer
wk.register({
    n = {
        name = "File Explorer",
        f = { ":NeoTreeFocus<CR>", "Focus on File Explorer" },
    },
}, { prefix = "<leader>" })

wk.register({
    ["<A-m>"] = { ":NeoTreeFocusToggle<CR>", "Toggle File Explorer" },
})

-- Finding different stuf.
wk.register({
    f = {
        name = "Find",
        w = { ":Telescope live_grep<CR>", "Word" },
        f = { ":Telescope find_files<CR>", "File" },
        r = { ":Telescope oldfiles<CR>", "Recent File" },
        b = { ":Telescope buffers<CR>", "Buffer" },
        h = { ":Telescope help_tags<CR>", "Help File" },
    },
}, { prefix = "<leader>" })

wk.register({
    ["<leader>/"] = { ":Telescope current_buffer_fuzzy_find<CR>", "FInd current buffer" },
})

-- Git keybinds.
wk.register({
    g = {
        name = "Git",
        s = { ":Telescope git_status<CR>", "Status + Git Diff" },
        c = { ":Telescope git_commits<CR>", "Commit History" },
        C = { ":Telescope git_bcommits<CR>", "Buffer Commit History" },
        b = { ":Telescope git_branches<CR>", "Branches history" },
    },
}, { prefix = "<leader>" })

-- ColorScheme keybindings.
wk.register({
    c = {
        name = "Theme",
        c = { ":lua require('core.colorscheme').changeColorschemeUI()<CR>", "Change ColorScheme" },
        f = {
            ":Telescope colorscheme enable_preview=true<CR>",
            "Find Colorscheme with previwer ",
        },
    },
}, { prefix = "<leader>" })

-- Dap
wk.register({
    d = {
        name = "Debugging",
        c = { ':lua require("dap").continue()<CR>', "Continue" },
        t = { ':lua require("dap").terminate()<CR>', "Terminate" },
        l = { ':lua require("dap").run_last()<CR>', "Run Last Debugging Config" },
        d = { ':lua require("dap").repl.open()<CR>', "Open Debug Console" },
        b = {
            name = "Breakpoint",
            t = { ':lua require("dap").toggle_breakpoint()<CR>', "Toggle" },
            c = {
                ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
                "Set conditional",
            },
            l = {
                ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
                "With Log Point Message",
            },
        },
        s = {
            name = "Step",
            o = { ':lua require("dap").step_over()<CR>', "Step Over" },
            O = { ':lua require("dap").step_into()<CR>', "Step Into" },
            i = { ':lua require("dap").step_out()<CR>', "Step Out" },
            b = { ':lua require("dap").step_back()<CR>', "Step Back" },
            c = { ':lua require("dap").run_to_cursor()<CR>', "Run To Cursor" },
        },
        u = { ':lua require("dapui").toggle()<CR>', "Toggle UI" },
    },
}, { prefix = "<leader>" })

-- comment
wk.register({
    ["<C-_>"] = { "gcc", "Comment current line" },
}, { noremap = false })

wk.register({
    ["<C-_>"] = { "gcc", "Comment selected line" },
}, { mode = "v", noremap = false })

-- aerial
wk.register({
    a = {
        name = "Outline",
        t = { "<cmd>AerialToggle<CR>", "Toggle outline" },
        h = { "<cmd>AerialPrev<CR>", "Jump to previous symbol" },
        l = { "<cmd>AerialNext<CR>", "Jump to next symbol" },
        u = { "<cmd>AerialPrevUp<CR>", "Jump up to the tree's previous level" },
        d = { "<cmd>AerialNextUp<CR>", "Jump up to the tree's next level" },
        s = { "<cmd>Telescope aerial<CR>", "Use telescope to open outline" },
    },
}, { prefix = "<leader>" })

wk.register({
    ["<leader>P"] = { "<cmd>Telescope projects<CR>", "Access recently opened projects" },
})

-- toggleterm
wk.register({
    t = {
        name = "terminal",
        t = { '<cmd>exe v:count."ToggleTerm"<CR>', "Toggle a common terminal" },
        f = { '<cmd>lua require("toggleterm").float_toggle()<CR>', "Toggle a float terminal" },
        g = { "<cmd>lua require('toggleterm').lazygit_toggle()<CR>", "Toggle a lazygit terminal" },
        a = { "<cmd>ToggleTermToggleAll<CR>", "Toggle all terminal" },
    },
}, { prefix = "<leader>" })

-- hop.nvim
wk.register({
    h = {
        name = "hop",
        l = { "<cmd>HopLineStart<CR>", "Line" },
        w = { "<cmd>HopWord<CR>", "Word" },
        p = { "<cmd>HopPattern<CR>", "Pattern" },
        a = { "<cmd>HopChar1<CR>", "One char" },
        c = { "<cmd>HopChar2<CR>", "Two char" },
    },
}, { prefix = "<leader>" })

wk.register({
    ["f"] = { "<cmd>HopChar1CurrentLineAC<CR>", "Use hop to move next char" },
    ["F"] = { "<cmd>HopChar1CurrentLineBC<CR>", "Use hop to move previous char" },
})

-- sniprun
wk.register({
    r = {
        name = "SnipRun",
        s = { "<cmd>SnipRun<cr>", "Run code snippet with SnipRun" },
        c = { "<cmd>SnipClose<cr>", "Close SnipRun" },
        r = { "Run file with toggleterm" },
    },
}, { prefix = "<leader>" })

wk.register({
    ["<leader>f"] = { "<Plug>SnipRun", "Run code snippet" },
}, { mode = "v", silent = true })

wk.register({
    s = {
        name = "Session",
        s = { "<cmd>SessionManager save_current_session<CR>", "Save session" },
        l = { "<cmd>SessionManager load_last_session<CR>", "Load session" },
    },
}, { prefix = "<leader>" })

-- neogen
wk.register({
    ["gcn"] = { ":Neogen<CR>", "Neogen" },
})
