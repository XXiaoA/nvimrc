local lspkind = require("utils").requirePlugin("lspkind")
local cmp = require("utils").requirePlugin("cmp")
local luasnip = require("utils").requirePlugin("luasnip")

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

if cmp and lspkind and luasnip then
    -- load the luasnip
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
        experimental = {
            ghost_text = true,
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        -- 指定 snippet 引擎
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        -- 来源
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
            { name = "nvim_lua" },
            { name = "luasnip" },
            { name = "emoji" },
            { name = "spell" },
        }),
        -- 快捷键
        mapping = {
            -- 上一个
            ["<C-k>"] = cmp.mapping.select_prev_item(),
            ["<UP>"] = cmp.mapping.select_prev_item(),
            -- 下一个
            ["<C-j>"] = cmp.mapping.select_next_item(),
            ["<DOWN>"] = cmp.mapping.select_next_item(),
            -- 出现/取消补全
            ["<A-.>"] = cmp.mapping(function()
                if cmp.visible() then
                    cmp.abort()
                    cmp.close()
                else
                    cmp.complete()
                end
            end, { "i", "c" }),
            -- 确认
            -- Accept currently selected item. If none selected, `select` first item.
            -- Set `select` to `false` to only confirm explicitly selected items.
            ["<CR>"] = cmp.mapping.confirm({
                select = true,
                -- behavior = cmp.ConfirmBehavior.Replace
            }),
            -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.

            ["<Tab>"] = cmp.mapping(function(fallback)
                if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        },
        -- 使用lspkind-nvim显示类型图标
        formatting = {
            format = lspkind.cmp_format({
                with_text = true, -- do not show text alongside icons
                maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                before = function(entry, vim_item)
                    -- Source 显示提示来源
                    vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
                    return vim_item
                end,
            }),
        },
    })

    -- Use buffer source for `/` `?` and `:`.
    cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })
    cmp.setup.cmdline("?", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "path" },
            { name = "cmdline" },
        },
    })

    cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
            { name = "git" },
            { name = "buffer" },
            { name = "spell" },
            { name = "luasnip" },
        }),
    })
end
