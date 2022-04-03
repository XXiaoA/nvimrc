-- Call the setup function to change the default behavior
local ok, aerial = pcall(require, "aerial")
if not ok then
    vim.notify(' aerial failed to load')
    return
end
aerial.setup({
})


-- Set up your LSP clients here, using the aerial on_attach method
---@diagnostic disable-next-line: redefined-local
local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
    vim.notify(' lspconfig failed to load')
    return
end
lspconfig.vimls.setup{
    on_attach = aerial.on_attach,
}
-- Repeat this for each language server you have configured


-- telescope support
---@diagnostic disable-next-line: redefined-local
local ok, telescope = pcall(require, "telescope")
if not ok then
    vim.notify(' telescope failed to load')
    return
end
telescope.load_extension('aerial')
