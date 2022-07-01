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
}
