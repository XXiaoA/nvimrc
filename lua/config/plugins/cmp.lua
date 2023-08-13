local M = {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "LuaSnip",
    },
}

M.config = function()
    local cmp = require("utils").require("cmp")
    if not cmp then
        return
    end

    cmp.setup({
        experimental = {
            ghost_text = true,
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        sorting = {
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.recently_used,
                require("clangd_extensions.cmp_scores"),
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
            { name = "nvim_lsp_signature_help" },
        }),
        mapping = {
            ["<C-k>"] = cmp.mapping.select_prev_item(),
            ["<C-j>"] = cmp.mapping.select_next_item(),

            ["<C-d>"] = cmp.mapping.scroll_docs(4),
            ["<C-u>"] = cmp.mapping.scroll_docs(-4),

            ["<C-e>"] = cmp.mapping(function()
                if cmp.visible() then
                    cmp.abort()
                else
                    cmp.complete()
                end
            end, { "i", "c" }),

            -- Accept currently selected item. If none selected, `select` first item.
            -- Set `select` to `false` to only confirm explicitly selected items.
            ["<CR>"] = cmp.mapping.confirm({
                select = true,
            }, { "i", "c" }),
            ["<S-CR>"] = cmp.mapping.confirm({
                select = true,
                behavior = cmp.ConfirmBehavior.Replace,
            }, { "i", "c" }),

            -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        },

        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, item)
                -- limit the max width of windows
                local ELLIPSIS_CHAR = "…"
                local MAX_LABEL_WIDTH = 25
                local content = item.abbr
                if #content > MAX_LABEL_WIDTH then
                    item.abbr = vim.fn.strcharpart(content, 0, MAX_LABEL_WIDTH) .. ELLIPSIS_CHAR
                end

                -- Kind icons
                local nerd_icons = require("utils.lspkind").icons
                item.kind = nerd_icons[item.kind] or ""
                -- Source
                item.menu = ({
                    buffer = "[Buf]",
                    nvim_lsp = "[LSP]",
                    luasnip = "[Snip]",
                })[entry.source.name]
                return item
            end,
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
end

return M
