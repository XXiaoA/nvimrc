-- stylua: ignore
return {
    s("fn", fmt([[
    fn {}({}) {{
        {}
    }}
    ]], {
        i(1, "name"),
        i(2),
        i(3),
        })
    ),
}
