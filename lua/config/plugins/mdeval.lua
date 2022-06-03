local mdeval = require("utils").requirePlugin("mdeval")
if mdeval and mdeval ~= true then
    mdeval.setup({
        -- Don't ask before executing code blocks
        require_confirmation = false,
        -- Change code blocks evaluation options.
        eval_options = {
            -- Set custom configuration for C++
            cpp = {
                command = { "clang++", "-std=c++20", "-O0" },
            },
        },
    })
end
