local M = {
    "Bekaboo/dropbar.nvim",
    event = "BufEnter",
}

M.config = function()
    local default_enable = require("dropbar.configs").opts.bar.enable

    require("dropbar").setup({
        icons = {
            kinds = {
                symbols = require("utils.lspkind").icons_with_whitespaces,
            },
        },
        bar = {
            enable = function(buf, win, src)
                local disabled = { matlab = true }
                if disabled[vim.bo[buf].filetype] then
                    return false
                end
                return default_enable(buf, win, src)
            end,
        },
    })
end

return M
