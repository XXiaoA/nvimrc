-- stylua: ignore
return {
    s("p", fmt([[
    println!({});
    ]], i(1) )
    ),

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
