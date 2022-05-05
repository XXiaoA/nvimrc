local npairs = require("utils").requirePlugin("nvim-autopairs")
local Rule = require("utils").requirePlugin("nvim-autopairs.rule")
local ts_conds = require("utils").requirePlugin("nvim-autopairs.ts-conds")

if npairs and Rule and ts_conds then
    npairs.setup {
        check_ts = true
    }

    -- press % => %% only while inside a comment or string
    npairs.add_rules {
        Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({"string", "comment"})),
        Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({"function"}))
    }
end

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("utils").requirePlugin("nvim-autopairs.completion.cmp")
local cmp = require("utils").requirePlugin("cmp")
if cmp_autopairs and cmp then
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({map_char = {tex = ""}}))
end
