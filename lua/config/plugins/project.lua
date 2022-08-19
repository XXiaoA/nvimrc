local requirePlugin = require("utils").requirePlugin
local project = requirePlugin("project_nvim")
if project then
    project.setup({})
end

-- telescope
local telescope = requirePlugin("telescope")
if telescope then
    telescope.load_extension("projects")
end
