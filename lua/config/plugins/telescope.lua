local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons",
        { "XXiaoA/telescope-project.nvim", dev = false },
    },
    cmd = "Telescope",
}

M.config = function()
    local utils = require("utils")
    local actions = utils.require("telescope.actions")
    local telescope = utils.require("telescope")
    if not actions or not telescope then
        return
    end

    local function do_builtin(builtin, opts)
        return function()
            builtin = builtin
            opts = vim.tbl_deep_extend("force", { cwd = require("utils").get_root() }, opts or {})
            require("telescope.builtin")[builtin](opts)
        end
    end

    local nmap = require("core.keymap").nmap
    nmap("<leader>gs", ":Telescope git_status<CR>", { desc = "Search git status" })
    nmap("<leader>gc", ":Telescope git_commits<CR>", { desc = "Search commit history" })
    nmap("<leader>gC", ":Telescope git_bcommits<CR>", { desc = "Buffer commit history" })

    nmap("<leader>fw", do_builtin("live_grep"), { desc = "Search words" })
    nmap("<leader>ff", do_builtin("find_files"), { desc = "Search files" })
    nmap("<leader>fr", ":Telescope oldfiles<CR>", { desc = "Search recent files" })
    nmap("<leader>fb", ":Telescope buffers<CR>", { desc = "Search buffers" })
    nmap("<leader>fh", ":Telescope help_tags<CR>", { desc = "Search help tags" })
    nmap("<leader>fu", ":Telescope resume<CR>", { desc = "Resume last picker" })
    nmap("<leader>fm", ":Telescope man_pages<CR>", { desc = "Search man pages" })
    nmap("z=", ":Telescope spell_suggest<CR>", { desc = "Spell suggest" })
    nmap(
        "<leader>fs",
        do_builtin("lsp_document_symbols", {
            symbols = {
                "Class",
                "Function",
                "Method",
                "Constructor",
                "Interface",
                "Module",
                "Struct",
                "Trait",
                "Field",
                "Property",
            },
        }),
        { desc = "Search symbol" }
    )

    require("telescope").load_extension("project")
    nmap("<leader>op", ":Telescope project<CR>", { desc = "Projects" })

    require("telescope").load_extension("themes")
    nmap("<leader>cp", "<cmd>Telescope themes<CR>", { desc = "Change colorscheme with preview" })

    telescope.setup({
        defaults = {
            vimgrep_arguments = {
                "rg",
                "-L",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
            },
            prompt_prefix = "   ",
            selection_caret = "  ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.55,
                    results_width = 0.8,
                },
                vertical = {
                    mirror = false,
                },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
            },
            file_sorter = require("telescope.sorters").get_fuzzy_file,
            generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            path_display = { "truncate" },
            winblend = 0,
            border = {},
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            color_devicons = true,
            set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
            file_previewer = require("telescope.previewers").vim_buffer_cat.new,
            grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
            qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
            -- Developer configurations: Not meant for general override
            buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
            mappings = {
                n = {
                    ["q"] = actions.close,
                    ["-"] = actions.file_split,
                    ["|"] = actions.file_vsplit,
                    ["\\"] = actions.file_vsplit,
                },
            },
            file_ignore_patterns = {
                "./node_modules",
                ".*~",
                "vimcdoc",
                "/usr/share/nvim/runtime/doc",
                "COMMIT_EDITMSG",
            },
        },
    })
end

return M
