local ok, project = pcall(require, "project_nvim")
if not ok then
    vim.notify(' project_nvim failed to load')
    return
end
project.setup({})


-- telescope
local ok, telescope = pcall(require, "telescope")
if not ok then
    vim.notify(' telescope failed to load')
    return
end
telescope.load_extension('projects')
