local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  rainbow = {
  enable = true,
  extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
  max_file_lines = 2000, -- Do not enable for files with more than 2000 lines, int
  colors = {
    "#81A1C1",
    "#A3BE8C",
    "#B48EAD",
    "#F0D399",
    "#D9B263",
    "#A6ACB9",
  }, -- table of hex strings
  -- termcolors = {} -- table of colour name strings
  },
  autotag = { enable = true },
}
