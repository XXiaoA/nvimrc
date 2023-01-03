return {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    dependencies = "telescope.nvim",
    config = function()
        local require_plugin = require("utils").require
        local project = require_plugin("project_nvim")
        if project then
            project.setup({})
        end

        local nmap = require("core.keymap").nmap
        nmap(
            "<leader>p",
            "<cmd>Telescope projects<CR>",
            { desc = "Access recently opened projects" }
        )

        local telescope = require_plugin("telescope")
        if telescope then
            telescope.load_extension("projects")
        end
    end,
}
