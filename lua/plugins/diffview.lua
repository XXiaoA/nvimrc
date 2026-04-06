return {
    "dlyongemallo/diffview.nvim",
    cmd = {
        "DiffviewOpen",
        "DiffviewToggle",
        "DiffviewFileHistory",
        "DiffviewDiffFiles",
        "DiffviewLog",
    },
    opts = {
        enhanced_diff_hl = true,
        auto_close_on_empty = false,
        view = {
            merge_tool = {
                layout = "diff3_mixed",
                disable_diagnostics = true,
                winbar_info = true,
            },
            cycle_layouts = {
                merge_tool = { "diff3_mixed", "diff4_mixed", "diff3_horizontal", "diff1_plain" },
            },
            default = {
                winbar_info = true,
            },
        },
        file_panel = {
            listing_style = "tree",
            win_config = {
                position = "left",
                width = 35,
            },
        },
    },
}
