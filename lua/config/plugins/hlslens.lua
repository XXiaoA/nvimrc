local M = {
    "kevinhwang91/nvim-hlslens",
    keys = {
        { "n", mode = { "n", "x", "o" } },
        { "N", mode = { "n", "x", "o" } },
        { "*", mode = { "n", "x", "o" } },
        { "#", mode = { "n", "x", "o" } },
        { "g*", mode = { "n", "x", "o" } },
        { "g#", mode = { "n", "x", "o" } },
    },
    opts = {},
}

M.config = function(_, opts)
    local hlslens = require("hlslens")
    hlslens.setup(opts)
    hlslens.start()

    -- work with nvim-ufo
    local function nN(char)
        local ok, winid = hlslens.nNPeekWithUFO(char)
        if ok and winid then
            -- Safe to override buffer scope keymaps remapped by ufo,
            -- ufo will restore previous buffer keymaps before closing preview window
            -- Type <CR> will switch to preview window and fire `tarce` action
            vim.keymap.set("n", "<CR>", function()
                local keyCodes = vim.api.nvim_replace_termcodes("<Tab><CR>", true, false, true)
                vim.api.nvim_feedkeys(keyCodes, "im", false)
            end, { buffer = true })
        end
    end

    local map = require("core.keymap").set({ "x", "n", "o" })
    -- stylua: ignore start
    for _, rhs in ipairs({ "n", "N" }) do
        map(rhs, function() nN(rhs) end)
    end
    for _, rhs in ipairs({ "*", "#" }) do
        map(rhs, [[:<c-u>let @/='\V\<'.escape(expand('<cword>'), '/\').'\>'<bar>call histadd('/',@/)<bar>set hlsearch<cr>]])
    end
    for _, rhs in ipairs({ "g*", "g#" }) do
        map(rhs, [[:<c-u>let @/='\V'.escape(expand('<cword>'), '/\').''<bar>call histadd('/',@/)<bar>set hlsearch<cr>]])
    end
    -- stylua: ignore end

    -- makes * and # work on visual mode too.
    vim.cmd([[
      function! g:VSetSearch()
        let temp = @s
        norm! gv"sy
        let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
        let @s = temp
      endfunction
      xnoremap <silent> * :<C-u>call g:VSetSearch()<bar>call histadd('/',@/)<bar>set hlsearch<CR>
      xnoremap <silent> # :<C-u>call g:VSetSearch()<bar>call histadd('/',@/)<bar>set hlsearch<CR>
      xnoremap <silent> g* :<C-u>call g:VSetSearch()<bar>call histadd('/',@/)<bar>set hlsearch<CR>
      xnoremap <silent> g# :<C-u>call g:VSetSearch()<bar>call histadd('/',@/)<bar>set hlsearch<CR>
]])
end

return M
