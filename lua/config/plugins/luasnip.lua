local M = {
    "L3MON4D3/LuaSnip",
    -- stylua: ignore
    keys = {
        {
            "<tab>",
            function()
                return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
            end,
            expr = true, silent = true, mode = "i",
        },
        { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
        { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        { "<C-l>", function()
            if require("luasnip").choice_active() then
                require("luasnip").change_choice(1)
            end
        end, mode = { "i", "s" } },
        { "<C-h>", function()
            if require("luasnip").choice_active() then
                require("luasnip").change_choice(-1)
            end
        end, mode = { "i", "s" } },
        { "<C-u>", function()
            if require("luasnip").choice_active() then
                require("luasnip.extras.select_choice")()
            end
        end, mode = { "i", "s" } },
    },
}

M.config = function()
    local ls = require("luasnip")
    local types = require("luasnip.util.types")
    ls.setup({
        update_events = { "TextChanged", "TextChangedI" },
        delete_check_events = "TextChanged",
        ext_opts = {
            [types.choiceNode] = {
                active = {
                    virt_text = { { "«", "Boolean" } },
                    priority = 10,
                },
            },
            [types.insertNode] = {
                active = {
                    virt_text = { { "●", "Title" } },
                    virt_text_pos = "inline",
                },
                unvisited = {
                    virt_text = { { "●", "NonText" } },
                    virt_text_pos = "inline",
                },
                visited = {
                    virt_text = { { "●", "NonText" } },
                    virt_text_pos = "inline",
                },
            },
        },
    })
    require("luasnip.loaders.from_lua").load({ paths = "./snippets" })

    -- https://github.com/L3MON4D3/LuaSnip/wiki/Cool-Snippets#all---todo-commentsnvim-snippets
    local s = ls.snippet
    local i = ls.insert_node
    local c = ls.choice_node
    local fmt = require("luasnip.extras.fmt").fmt

    local informations = {
        username = "XXiaoA",
        email = "isxxiaoa@gmail.com",
    }

    --- Options for marks to be used in a TODO comment
    local marks = {
        function()
            return fmt("<{}>", i(1, os.date("%d-%m-%y")))
        end,
        function()
            return fmt("<{}>", i(1, informations.username))
        end,
        function()
            return fmt("<{}{}>", { i(1, os.date("%d-%m-%y")), i(2, ", " .. informations.username) })
        end,
        function()
            return fmt("<{}{}>", { i(1, informations.username), i(2, " " .. informations.email) })
        end,
        function()
            return fmt("<{}{}{}>", {
                i(1, os.date("%d-%m-%y")),
                i(2, ", " .. informations.username),
                i(3, " " .. informations.email),
            })
        end,
    }

    local todo_snippet_nodes = function(aliases)
        local aliases_nodes = vim.tbl_map(function(alias)
            return i(nil, alias) -- generate choices for [name-of-comment]
        end, aliases)
        local sigmark_nodes = {} -- choices for [comment-mark]
        for _, mark in pairs(marks) do
            table.insert(sigmark_nodes, mark())
        end
        -- format them into the actual snippet
        local comment_node = fmt("{}: {}", {
            c(1, aliases_nodes), -- [name-of-comment]
            c(2, {
                i(1), -- {comment-text}
                fmt("{} {}", {
                    i(2),
                    c(1, sigmark_nodes), -- [comment-mark]
                }),
            }),
        })
        return comment_node
    end

    --- Generate a TODO comment snippet with an automatic description and docstring
    ---@param context table merged with the generated context table `trig` must be specified
    ---@param aliases string[] of aliases for the todo comment (ex.: {FIX, ISSUE, FIXIT, BUG})
    local function todo_snippet(context, aliases)
        context = context or {}
        if not context.trig then
            return error("context doesn't include a `trig` key which is mandatory", 2) -- all we need from the context is the trigger
        end
        ---@diagnostic disable-next-line: param-type-mismatch
        local alias_string = table.concat(aliases, "|") -- `choice_node` documentation
        context.name = context.name or (alias_string .. " comment") -- generate the `name` of the snippet if not defined
        context.dscr = context.dscr or (alias_string .. " comment with a signature-mark") -- generate the `dscr` if not defined
        context.docstring = context.docstring or (" {1:" .. alias_string .. "}: {2}{0} ") -- generate the `docstring` if not defined
        local comment_node = todo_snippet_nodes(aliases) -- nodes from the previously defined function for their generation
        return s(context, comment_node) -- the final todo-snippet constructed from our parameters
    end

    local todo_snippet_specs = {
        { { trig = "todo" }, { "TODO" } },
        { { trig = "fix" }, { "FIX", "BUG", "ISSUE", "FIXIT" } },
        { { trig = "hack" }, { "HACK" } },
        { { trig = "warn" }, { "WARN", "WARNING", "XXX" } },
        { { trig = "perf" }, { "PERF", "PERFORMANCE", "OPTIM", "OPTIMIZE" } },
        { { trig = "note" }, { "NOTE", "INFO" } },
    }

    local todo_comment_snippets = {}
    for _, snippet in ipairs(todo_snippet_specs) do
        table.insert(todo_comment_snippets, todo_snippet(snippet[1], snippet[2]))
    end

    ls.add_snippets("commentable", todo_comment_snippets, { key = "todo_comments" })

    if vim.bo.ft ~= "gitcommit" then
        ls.filetype_extend(vim.bo.ft, { "commentable" })
    end
    -- https://github.com/L3MON4D3/LuaSnip/issues/554
    vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*",
        callback = function(ctx)
            if vim.bo[ctx.buf].ft ~= "gitcommit" then
                ls.filetype_extend(vim.bo[ctx.buf], { "commentable" })
            end
        end,
    })
end

return M
