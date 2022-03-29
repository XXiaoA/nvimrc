-- Call the setup function to change the default behavior
require("aerial").setup({
})


-- Set up your LSP clients here, using the aerial on_attach method
require("lspconfig").vimls.setup{
  on_attach = require("aerial").on_attach,
}
-- Repeat this for each language server you have configured


-- telescope support
require('telescope').load_extension('aerial')
