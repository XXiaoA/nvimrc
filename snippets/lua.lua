-- stylua: ignore
return {
    s("p", {
        t("print("),
        i(1),
        t(")"),
    }),

    s("if", {
        t({ "if " }),
        i(1),
        t({ " then", "\t" }),
        i(2),
        t({ "", "end" }),
        i(0),
    }),

    s("elseif", {
        t({ "elseif " }),
        i(1),
        t({ " then", "\t" }),
        i(0),
    }),

    s("rt", {
        t("return "),
    }),

    s("ll", fmt([[
    local {} = {}
    ]], { i(1), i(2) } )
    ),

    s("req", fmt([[
    require("{}")
    ]], i(1) )
    ),

    s("fu", fmt([[
    function {}({})
        {}
    end
    ]], {
        i(1, "name"),
        i(2),
        i(3, "-- code")
        })
    ),

    s("f=", fmt([[
    {} = function({})
        {}
    end
    ]], {
        i(1, "name"),
        i(2),
        i(3, "-- code")
        })
    ),
}
