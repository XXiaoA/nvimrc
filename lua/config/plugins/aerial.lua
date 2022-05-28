-- Call the setup function to change the default behavior
local aerial = require("utils").requirePlugin("aerial")
if aerial and aerial ~= true then
    aerial.setup {}
end

-- Set up your LSP clients here, using the aerial on_attach method
local lspconfig = require("utils").requirePlugin("lspconfig")
if lspconfig then
    lspconfig.vimls.setup {
        on_attach = aerial.on_attach
    }
end
-- Repeat this for each language server you have configured

-- telescope support
local telescope = require("utils").requirePlugin("telescope")
if telescope and telescope ~= true then
    telescope.load_extension("aerial")
end
