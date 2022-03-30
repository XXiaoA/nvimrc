require("project_nvim").setup({})


-- nvim-tree
vim.g.nvim_tree_respect_buf_cwd = 1

require("nvim-tree").setup({
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
})

-- telescope
require('telescope').load_extension('projects')
