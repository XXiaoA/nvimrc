local formatter = require("utils").requirePlugin("formatter")
formatter.setup {
    filetype = {
        lua = {
            -- luafmt
            function()
                return {
                    exe = "luafmt",
                    args = {"--indent-count", 4, "--stdin"},
                    stdin = true
                }
            end
        }
    }
}
