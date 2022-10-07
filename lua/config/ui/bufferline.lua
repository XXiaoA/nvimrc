local bufferline = require("utils").require_plugin("bufferline")

if not bufferline then
    return
end

local nmap = require("core.keymap").nmap
nmap("<leader>bc", ":BufferLinePickClose<CR>", { desc = "Close Buffer" })
nmap("<leader>bh", ":BufferLineMovePrev<CR>", { desc = "Move buffer Left" })
nmap("<leader>bl", ":BufferLineMoveNext<CR>", { desc = "Move buffer Right" })
nmap("<A-,>", ":BufferLineCyclePrev<CR>", { desc = "Go to previous buffer" })
nmap("<A-.>", ":BufferLineCycleNext<CR>", { desc = "Go to next buffer" })

bufferline.setup({
    options = {
        -- 使用 nvim 内置lsp
        diagnostics = "nvim_lsp",
        -- 左侧让出 File Explorer 的位置
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left",
            },
        },
    },
})
