local wk = require("utils").require_plugin("which-key")
local presets = require("utils").require_plugin("which-key.plugins.presets")

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

-- TODO: remove it
-- -- Dap
-- wk.register({
--     d = {
--         name = "Debugging",
--         c = { ':lua require("dap").continue()<CR>', "Continue" },
--         t = { ':lua require("dap").terminate()<CR>', "Terminate" },
--         l = { ':lua require("dap").run_last()<CR>', "Run Last Debugging Config" },
--         d = { ':lua require("dap").repl.open()<CR>', "Open Debug Console" },
--         b = {
--             name = "Breakpoint",
--             t = { ':lua require("dap").toggle_breakpoint()<CR>', "Toggle" },
--             c = {
--                 ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
--                 "Set conditional",
--             },
--             l = {
--                 ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
--                 "With Log Point Message",
--             },
--         },
--         s = {
--             name = "Step",
--             o = { ':lua require("dap").step_over()<CR>', "Step Over" },
--             O = { ':lua require("dap").step_into()<CR>', "Step Into" },
--             i = { ':lua require("dap").step_out()<CR>', "Step Out" },
--             b = { ':lua require("dap").step_back()<CR>', "Step Back" },
--             c = { ':lua require("dap").run_to_cursor()<CR>', "Run To Cursor" },
--         },
--         u = { ':lua require("dapui").toggle()<CR>', "Toggle UI" },
--     },
-- }, { prefix = "<leader>" })
