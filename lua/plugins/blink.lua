return {
    "saghen/blink.cmp",
    enabled = true,
    event = { "InsertEnter", "CmdlineEnter" },
    -- use a release tag to download pre-built binaries
    -- version = "*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    build = "cargo build --release",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "enter",
            ["<C-d>"] = { "scroll_documentation_down" },
            ["<C-u>"] = { "scroll_documentation_up" },
            ["<C-e>"] = { "show", "cancel" },
            -- use the keymaps from luasnip
            ["<Tab>"] = false,
            ["<S-Tab>"] = false,
        },

        completion = {
            accept = {
                create_undo_point = false,
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 0,
                update_delay_ms = 100,
            },
            menu = {
                -- Minimum width should be controlled by components
                min_width = 1,
                draw = {
                    columns = {
                        { "kind_icon" },
                        { "label", "label_description", gap = 1 },
                        { "provider" },
                    },
                    components = {
                        provider = {
                            text = function(ctx)
                                return "[" .. ctx.item.source_name:sub(1, 3):upper() .. "]"
                            end,
                        },
                    },
                },
            },
        },

        cmdline = {
            completion = {
                ghost_text = { enabled = false },
                menu = { auto_show = true },
            },
        },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },

        snippets = { preset = "luasnip" },

        appearance = {
            nerd_font_variant = "mono",
            kind_icons = require("utils.lspkind").icons,
        },
    },
    opts_extend = { "sources.default" },
}
