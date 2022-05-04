-- Call the setup function to change the default behavior
local aerial = require("utils").requirePlugin("aerial")
aerial.setup {}

-- Set up your LSP clients here, using the aerial on_attach method
local lspconfig = require("utils").requirePlugin("lspconfig")
lspconfig.vimls.setup {
    on_attach = aerial.on_attach
}
-- Repeat this for each language server you have configured

-- telescope support
local telescope = require("utils").requirePlugin("telescope")
telescope.load_extension("aerial")
