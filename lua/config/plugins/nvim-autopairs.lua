local npairs = require("utils").requirePlugin("nvim-autopairs")
if not npairs then
    return
end

npairs.setup({
    check_ts = true,
})

-- If you want insert `(` after select function or method item
local cmp = require("utils").requirePlugin("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
if not cmp then
    return
end
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
