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
    for (auto <var> : <array>) {
        <>
    }
    ]], {
        var = f(function(args)
            local user_input = args[1][1]
            return user_input:sub(-1) == "s" and user_input:sub(1, -2) or user_input .. "_key"
        end, 1),
        array = i(1, "array"),
        i(0),
    }))
}
