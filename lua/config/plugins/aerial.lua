-- Call the setup function to change the default behavior
local aerial = require("utils").requirePlugin("aerial")
if aerial then
    aerial.setup({})
end

-- telescope support
local telescope = require("utils").requirePlugin("telescope")
if telescope then
    telescope.load_extension("aerial")
end
