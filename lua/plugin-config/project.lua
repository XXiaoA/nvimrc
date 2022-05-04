local project = require("utils").requirePlugin("project_nvim")
project.setup {}

-- telescope
local telescope = require("utils").requirePlugin("telescope")
telescope.load_extension("projects")
