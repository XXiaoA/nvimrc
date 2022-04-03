local ok, formatter = pcall(require, "formatter")
if not ok then
    vim.notify(' formatter failed to load')
    return
end
formatter.setup(
  {
    filetype = {
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 4, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)
