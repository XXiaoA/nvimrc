local surround = require("utils").require_plugin("nvim-surround")
if not surround then
    return
end

surround.setup({
    keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "sa",
        normal_cur = "ssa",
        normal_line = "sA",
        normal_cur_line = "ssA",
        visual = "sa",
        visual_line = "sA",
        delete = "sd",
        change = "sr",
    },
})
