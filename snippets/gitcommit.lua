---@diagnostic disable: undefined-global
local types = {
    "feat",
    "fix",
    "docs",
    "style",
    "refactor",
    "perf",
    "test",
    "build",
    "ci",
    "chore",
    "revert",
}
local snippets = {}

for _, type in ipairs(types) do
    table.insert(
        snippets,
        s(
            type,
            fmt([[{}: {}]], {
                c(1, {
                    i(1, type),
                    fmt([[{}({})]], {
                        t(type),
                        i(1, "scope"),
                    }),
                }),
                i(2, "title"),
            })
        )
    )
end

table.insert(
    snippets,
    s(
        "cc",
        fmt([[{}: {}]], {
            c(1, {
                i(1, "cc"),
                fmt([[{}({})]], {
                    i(1, "cc"),
                    i(2, "scope"),
                }),
            }),
            i(2, "title"),
        })
    )
)

return snippets
