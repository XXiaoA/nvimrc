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
                        r(1, "scope"),
                    }),

                    { i(1, type), t("!") },

                    fmt([[{}({})!]], {
                        -- t(type),
                        t(type),
                        r(1, "scope"),
                    }),
                }),
                i(2, "title"),
            }),
            {
                stored = {
                    ["scope"] = i(1),
                },
            }
        )
    )
end

table.insert(
    snippets,
    s(
        "cc",
        fmt([[{}: {}]], {
            c(1, {
                r(1, "type"),

                fmt([[{}({})]], {
                    r(1, "type"),
                    r(2, "scope"),
                }),

                { r(1, "type"), t("!") },

                fmt([[{}({})!]], {
                    r(1, "type"),
                    r(2, "scope"),
                }),
            }),
            i(2, "type"),
        }),
        {
            stored = {
                ["type"] = i(1, "cc"),
                ["scope"] = i(1),
            },
        }
    )
)

return snippets
