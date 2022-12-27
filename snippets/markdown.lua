---@diagnostic disable: undefined-global
-- stylua: ignore
return {
    s("task", fmt([[
    - [{}] {}
    ]], {
        c(1, {
            i(1, " "),
            i(2, "x")
        }),
        i(2, "text") })
    ),

    s("l" , fmt([[
    [{}]({})
    ]], { i(1), i(2) })
    ),

    s("u", fmt([[
    <{}>
    ]], i(1) )
    ),

    s("img" , fmt([[
    ![{}]({})
    ]], { i(1), i(2) })
    ),

    s("strikethrough", fmt([[
    ~~{}~~
    ]], i(1) )
    ),

    s("i", fmt([[
    *{}*
    ]], i(1) )
    ),

    s("b", fmt([[
    **{}**
    ]], i(1) )
    ),

    s("bi", fmt([[
    ***{}***
    ]], i(1) )
    ),

    s("quote", t("> ")),

    s("code", fmt([[
    `{}`
    ]], i(1) )
    ),

    s("codeblock", fmt([[
    ```{}
    {}
    ```
    ]], {
        i(1, "language"),
        i(2)
    } )
    ),

    s("h1", t("# ")),
    s("h2", t("## ")),
    s("h3", t("### ")),
    s("h4", t("#### ")),
    s("h5", t("##### ")),
    s("h6", t("###### ")),

    s("br", t("<br>")),

    s("more", t("<!--more-->")),

    s("detail", fmt([[
    <details>
    <summary><font size="" color="red">{}</font></summary>

    {}
    </details>
    ]], {
        i(1, "Click to show the code."),
        i(2)
        })
    ),

    s("font", fmt([[
    <font {}>{}</font>
    ]], {
        c(1, {
            fmt([[color="{}"]], { i(1) }),
            fmt([[size="{}"]], { i(1, "3") }),
            fmt([[size="{}" color="{}"]], { i(1, "3"), i(2) }),
        }),
        i(2, "text")
    })
    ),

    s("underline", fmt([[
    <u>{}</u>
    ]], i(1))
    ),
}
