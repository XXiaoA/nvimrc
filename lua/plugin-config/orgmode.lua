local ok, orgmode = pcall(require, "orgmode")
if not ok then
    vim.notify(' orgmode failed to load')
    return
end

-- Load custom tree-sitter grammar for org filetype
orgmode.setup_ts_grammar()

orgmode.setup({
  org_agenda_files = {'~/org/*', '~/my-orgs/**/*'},
  org_default_notes_file = '~/org/refile.org',
})
