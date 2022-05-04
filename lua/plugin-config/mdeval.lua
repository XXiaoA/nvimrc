local mdeval = require("utils").requirePlugin("mdeval")
mdeval.setup {
    -- Don't ask before executing code blocks
    require_confirmation = false,
    -- Change code blocks evaluation options.
    eval_options = {
        -- Set custom configuration for C++
        cpp = {
            command = {"clang++", "-std=c++20", "-O0"}
        }
    }
}
