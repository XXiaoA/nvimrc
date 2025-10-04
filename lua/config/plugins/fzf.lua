return {
    "ibhagwan/fzf-lua",
    enabled = true,
    cmd = { "FzfLua" },
    opts = {
        lsp = {
            symbols = {
                symbol_icons = require("utils.lspkind").icons,
            },
        },
    },
    keys = {
        -- stylua: ignore start
        { "<leader>fw", function() require("fzf-lua").live_grep_native() end, desc = "Live grep" },
        { mode = "x", "<leader>fw", "<cmd>lua require('fzf-lua').grep_visual()<cr>", desc = "Live grep" },
        { "<leader>ff", function() require("fzf-lua").files() end, desc = "Files" },
        { "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Buffers" },
        { "<leader>fh", function() require("fzf-lua").help_tags() end, desc = "Help tags" },
        { "<leader>fr", function() require("fzf-lua").oldfiles() end, desc = "Recent files" },
        { "<leader>fu", function() require("fzf-lua").resume() end, desc = "Resume" },
        { "<leader>fm", function() require("fzf-lua").marks() end, desc = "Marks" },
        -- https://github.com/ibhagwan/fzf-lua/issues/441
        { "<leader>fs", function() require("fzf-lua").lsp_document_symbols() end, desc = "Document symbols" },
        { "<leader>fS", function() require("fzf-lua").lsp_workspace_symbols() end, desc = "Workspace symbols" },
        { "z=", function() require("fzf-lua").spell_suggest() end },
        { "<leader>fgs", function() require("fzf-lua").git_status() end, desc = "Status" },
        { "<leader>fgc", function() require("fzf-lua").git_commits() end, desc = "Commits" },
        { "<leader>fgb", function() require("fzf-lua").git_branches() end, desc = "Branchs" },
        { "<leader>fgt", function() require("fzf-lua").git_tags() end, desc = "Tags" },
        {
            "<leader>ft",
            function()
                require("fzf-lua").grep({
                    search = [[\b(TODO|WIP|NOTE|XXX|INFO|DOCS|PERF|TEST|HACK|WARNING|WARN|FIX|FIXME|BUG|ERROR):]],
                    no_esc = true,
                    multiline = true,
                })
            end,
            desc = "Todo comments",
        },
        -- stylua: ignore end
    },
}
