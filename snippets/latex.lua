---@diagnostic disable: undefined-global
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
    s("sec", fmt([[\section{{{}}}{}]], { i(1, "Title"), i(0) })),
    s("ssec", fmt([[\subsection{{{}}}{}]], { i(1, "Title"), i(0) })),
    s("sssec", fmt([[\subsubsection{{{}}}{}]], { i(1, "Title"), i(0) })),
    s(
        "beg",
        fmt(
            [[
\begin{{{}}}
    {}
\end{{{}}}
]],
            { i(1, "environment"), i(2), rep(1) }
        )
    ),
    s(
        "eq",
        fmt(
            [[
\begin{{equation}}
    \label{{eq:{}}}
    {}
\end{{equation}}
]],
            { i(1, "label"), i(0) }
        )
    ),
    s("ref", fmt([[\ref{{{}}}]], i(1, "label"))),
    s("eqref", fmt([[\eqref{{{}}}]], i(1, "eq:label"))),
    s("cite", fmt([[\cite{{{}}}]], i(1, "citation-key"))),
    s(
        "fig",
        fmt(
            [[
\begin{{figure}}[htbp]
    \centering
    \includegraphics[width={}\linewidth]{{{}}}
    \caption{{{}}}
    \label{{fig:{}}}
\end{{figure}}
]],
            {
                i(1, "0.8"),
                i(2, "path/to/image"),
                i(3, "Caption"),
                i(4, "label"),
            }
        )
    ),
    s(
        "itemize",
        fmt(
            [[
\begin{{itemize}}
    \item {}
    \item {}
\end{{itemize}}
]],
            { i(1), i(2) }
        )
    ),
}
