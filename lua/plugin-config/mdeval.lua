local ok, mdeval = pcall(require, "mdeval")
if not ok then
    vim.notify(' mdeval failed to load')
    return
end
mdeval.setup({
  -- Don't ask before executing code blocks
  require_confirmation=false,
  -- Change code blocks evaluation options.
  eval_options = {
    -- Set custom configuration for C++
    cpp = {
      command = {"clang++", "-std=c++20", "-O0"},
    },
  },
})
