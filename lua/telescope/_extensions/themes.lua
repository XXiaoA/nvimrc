-- modfied from https://github.com/NvChad/extensions/blob/f76b8460d2f960c1c5c2af40845ead33c725bbf7/lua/telescope/_extensions/themes.lua

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")

local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local colorscheme = require("core.colorscheme")

local reload_theme = colorscheme.load_colorscheme

local function switcher()
    local bufnr = vim.api.nvim_get_current_buf()
    local bufname = vim.api.nvim_buf_get_name(bufnr)

    -- show current buffer content in previewer
    local previewer = previewers.new_buffer_previewer({
        define_preview = function(self, entry)
            -- add content
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
            vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)

            -- add syntax highlighting in previewer
            local ft = require("plenary.filetype").detect(bufname) or "diff"
            require("telescope.previewers.utils").highlighter(self.state.bufnr, ft)

            reload_theme(entry.value)
        end,
    })

    -- our picker function: colors
    local picker = pickers.new({
        prompt_title = "󱥚 Colorscheme",
        previewer = previewer,
        finder = finders.new_table({
            results = colorscheme.all_colorschemes,
        }),
        sorter = conf.generic_sorter(),

        attach_mappings = function(prompt_bufnr, map)
            -- reload theme while typing
            vim.schedule(function()
                vim.api.nvim_create_autocmd("TextChangedI", {
                    buffer = prompt_bufnr,
                    callback = function()
                        reload_theme(action_state.get_selected_entry()[1])
                    end,
                })
            end)
            -- reload theme on cycling
            map("i", "<C-n>", function()
                actions.move_selection_next(prompt_bufnr)
                reload_theme(action_state.get_selected_entry()[1])
            end)

            map("i", "<C-p>", function()
                actions.move_selection_previous(prompt_bufnr)
                reload_theme(action_state.get_selected_entry()[1])
            end)

            ------------ save theme ----------------
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                reload_theme(action_state.get_selected_entry()[1])
            end)
            return true
        end,
    })

    picker:find()
end

return require("telescope").register_extension({
    exports = { themes = switcher },
})
