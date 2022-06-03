local hop = require("utils").requirePlugin("hop")

if hop and hop ~= true then
    hop.setup({
        keys = "etovxqpdygfblzhckisuran",
        -- jump_on_sole_occurrence = false,
    })
end
