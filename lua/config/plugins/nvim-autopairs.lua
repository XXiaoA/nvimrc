local npairs = require("utils").require("nvim-autopairs")
if not npairs then
    return
end

npairs.setup({
    check_ts = true,
})

-- If you want insert `(` after select function or method item
local cmp = require("utils").require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
if not cmp then
    return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")
npairs.add_rules({
    Rule(" ", " ")
        :with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({ "()", "{}", "[]" }, pair)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(function(opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = opts.line:sub(col - 1, col + 2)
            return vim.tbl_contains({ "(  )", "{  }", "[  ]" }, context)
        end),
    Rule("", " )")
        :with_pair(cond.none())
        :with_move(function(opts)
            return opts.char == ")"
        end)
        :with_cr(cond.none())
        :with_del(cond.none())
        :use_key(")"),
    Rule("", " }")
        :with_pair(cond.none())
        :with_move(function(opts)
            return opts.char == "}"
        end)
        :with_cr(cond.none())
        :with_del(cond.none())
        :use_key("}"),
    Rule("", " ]")
        :with_pair(cond.none())
        :with_move(function(opts)
            return opts.char == "]"
        end)
        :with_cr(cond.none())
        :with_del(cond.none())
        :use_key("]"),
})

-- Move past some specific character
for _, punct in pairs({ ",", ";" }) do
    npairs.add_rules({
        Rule("", punct)
            :with_move(function(opts)
                return opts.char == punct
            end)
            :with_pair(cond.none())
            :with_del(cond.none())
            :with_cr(cond.none())
            :use_key(punct),
    })
end
