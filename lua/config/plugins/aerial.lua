-- Call the setup function to change the default behavior
local aerial = require("utils").requirePlugin("aerial")
if aerial and aerial ~= true then
    aerial.setup({})
end

-- telescope support
local telescope = require("utils").requirePlugin("telescope")
if telescope and telescope ~= true then
    telescope.load_extension("aerial")
end
