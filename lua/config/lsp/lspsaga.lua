local saga = require("utils").require_plugin("lspsaga")
if not saga then
    return
end

saga.init_lsp_saga({
    code_action_lightbulb = {
        enable_in_insert = false,
        sign = true,
        virtual_text = false,
    },
    diagnostic_header = { " ", " ", " ", " " },
    show_outline = {
        jump_key = "<CR>",
    },
    symbol_in_winbar = {
        enable = false,
        in_custom = true,
        click_support = function(node, clicks, button, modifiers)
            -- To see all avaiable details: vim.pretty_print(node)
            local st = node.range.start
            local en = node.range["end"]
            if button == "l" then
                if clicks == 2 then
                -- double left click to do nothing
                else -- jump to node's starting line+char
                    vim.fn.cursor(st.line + 1, st.character + 1)
                end
            elseif button == "r" then
                if modifiers == "s" then
                    print("lspsaga") -- shift right click to print "lspsaga"
                end -- jump to node's ending line+char
                vim.fn.cursor(en.line + 1, en.character + 1)
            elseif button == "m" then
                -- middle click to visual select node
                vim.fn.cursor(st.line + 1, st.character + 1)
                vim.cmd("normal v")
                vim.fn.cursor(en.line + 1, en.character + 1)
            end
        end,
    },
})

local function config_winbar_or_statusline()
    local exclude = {
        ["terminal"] = true,
        ["toggleterm"] = true,
        ["prompt"] = true,
        ["NvimTree"] = true,
        ["help"] = true,
    } -- Ignore float windows and exclude filetype
    if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
        vim.wo.winbar = ""
    else
        local lspsaga_sym = require("lspsaga.symbolwinbar")
        local sym = lspsaga_sym.get_symbol_node()
        if type(sym) == "string" then
            sym = sym:match([[%#LspSagaWinbarSep# (.*)]])
        end
        vim.wo.winbar = sym or " "
    end
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "CursorMoved" }, {
    pattern = "*",
    callback = function()
        config_winbar_or_statusline()
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "LspsagaUpdateSymbol",
    callback = function()
        config_winbar_or_statusline()
    end,
})
