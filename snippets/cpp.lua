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
        i(3)
    })
    )
}
