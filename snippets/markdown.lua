return {
    s( "task", fmt([[
    - [{}] {}
    ]], { i(1, " "), i(2, "text") })
    ),

    s( "l" , fmt([[
    [{}]({})
    ]], { i(1), i(2) })
    ),

    s( "br", t("<br>")),

    s( "more", t("<!--more-->")),

    s( "detail", fmt([[
    <details>
    <summary><font size="2" color="red">{}</font></summary>

    {}
    </details>
    ]], {
        i(1, "Click to show the code."),
        i(2)
        })
    ),
}
