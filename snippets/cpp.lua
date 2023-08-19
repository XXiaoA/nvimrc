---@diagnostic disable: undefined-global

-- stylua: ignore
return {
    s("main", fmta([[
    int main(int argc, char *argv[]) {
        <>

        return 0;
    }
    ]], i(0))
    ),

    s("fori", fmt([[
    for (int {} = 0; {i} < {}; {i}++) {{
        {}
    }}
    ]], {
        i(1),
        i = f(function(args) return args[1][1] end, 1),
        i(2),
        i(0)
    })),

    s("forin", fmta([[
    for (<type> <var> : <expr>) {
        <>
    }
    ]], {
        type = c(1, {
            i(1, "type"),
            i(1, "const auto&"),
            i(1, "auto&&"),
        }),
        var = f(function(args)
            local user_input = args[1][1]
            return (#user_input > 1 and user_input:sub(-1) == "s") and user_input:sub(1, -2) or user_input .. "_key"
        end, 2),
        expr = i(2, "expr"),
        i(0),
    })),
}
