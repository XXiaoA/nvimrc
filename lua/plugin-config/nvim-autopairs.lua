local ok, npairs = pcall(require, "nvim-autopairs")
if not ok then
    vim.notify(' nvim-autopairs failed to load')
    return
end

local ok, Rule = pcall(require, "nvim-autopairs.rule")
if not ok then
    vim.notify(' nvim-autopairs.rule failed to load')
    return
end
local Rule = require('nvim-autopairs.rule')


npairs.setup({
    check_ts = true,
})

local ts_conds = require('nvim-autopairs.ts-conds')


-- press % => %% only while inside a comment or string
npairs.add_rules({
  Rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
    :with_pair(ts_conds.is_not_ts_node({'function'}))
})


-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
