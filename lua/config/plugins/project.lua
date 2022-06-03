local project = require("utils").requirePlugin("project_nvim")
if project then
    project.setup({})
end

-- telescope
local telescope = require("utils").requirePlugin("telescope")
if telescope and telescope ~= true then
    telescope.load_extension("projects")
end
