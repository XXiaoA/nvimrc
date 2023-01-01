local tr = require("utils").require("nvim-tree")
if not tr then
    return
end

local nmap = require("core.keymap").set_keymap("n")
nmap("<leader>nn", "<cmd>NvimTreeToggle<CR>")
nmap("<A-m>", function()
    return require("nvim-tree").toggle(false, true)
end, { desc = "toggle nvim-tree" })

tr.setup({
    view = {
        mappings = {
            list = {
                { key = { "l" }, action = "edit" },
                { key = { "s" }, action = "split" },
                { key = { "v" }, action = "vsplit" },
            },
        },
        float = {
            enable = false,
            open_win_config = function()
                local columns = vim.o.columns
                local lines = vim.o.lines
                local width = math.max(math.floor(columns * 0.5), 50)
                local height = math.max(math.floor(lines * 0.5), 20)
                local left = math.ceil((columns - width) * 0.5)
                local top = math.ceil((lines - height) * 0.5 - 2)
                return {
                    relative = "editor",
                    border = "rounded",
                    width = width,
                    height = height,
                    row = top,
                    col = left,
                }
            end,
        },
    },

    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
})
