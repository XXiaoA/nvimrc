---@diagnostic disable: undefined-global
local postfix_pattern = [[[^%s]+$]]

return {
    s("b", fmt([[*{}*]], i(1, "text"))),
    postfix({ trig = ".b", match_pattern = postfix_pattern, priority = 1001 }, {
        l("*" .. l.POSTFIX_MATCH .. "*"),
    }),

    s("i", fmt([[_{}_]], i(1, "text"))),
    postfix({ trig = ".i", match_pattern = postfix_pattern, priority = 1001 }, {
        l("_" .. l.POSTFIX_MATCH .. "_"),
    }),

    s("hl", fmt([=[#highlight[{}]]=], i(1, "text"))),
    postfix({ trig = ".hl", match_pattern = postfix_pattern, priority = 1001 }, {
        l("#highlight[" .. l.POSTFIX_MATCH .. "]"),
    }),

    s(
        "hlc",
        fmt([=[#highlight(fill: rgb("{}"))[{}]]=], {
            i(1, "#fff3a3"),
            i(2, "text"),
        })
    ),
    postfix(
        { trig = ".hlc", match_pattern = postfix_pattern, priority = 1001 },
        fmt([=[#highlight(fill: rgb("{}"))[{}]]=], {
            i(1, "#fff3a3"),
            l(l.POSTFIX_MATCH),
        })
    ),

    s("u", fmt([=[#underline[{}]]=], i(1, "text"))),
    postfix({ trig = ".u", match_pattern = postfix_pattern, priority = 1001 }, {
        l("#underline[" .. l.POSTFIX_MATCH .. "]"),
    }),

    s("del", fmt([=[#strike[{}]]=], i(1, "text"))),
    postfix({ trig = ".del", match_pattern = postfix_pattern, priority = 1001 }, {
        l("#strike[" .. l.POSTFIX_MATCH .. "]"),
    }),

    s(
        "fig",
        fmt(
            [=[
    #figure(
      image("{}", width: {}),
      caption: [{}],
    ) <{}>{}
    ]=],
            {
                i(1, "figure.png"),
                i(2, "80%"),
                i(3, "Figure caption"),
                i(4, "fig:example"),
                i(0),
            }
        )
    ),

    s(
        "tbl",
        fmt(
            [=[
    #figure(
      table(
        columns: 2,
        table.header([{}], [{}]),
        [{}], [{}],
      ),
      caption: [{}],
    ) <{}>{}
    ]=],
            {
                i(1, "Column 1"),
                i(2, "Column 2"),
                i(3, "Value"),
                i(4, "Value"),
                i(5, "Table caption"),
                i(6, "tbl:example"),
                i(0),
            }
        )
    ),

    s(
        "split",
        fmt(
            [=[
    #grid(
      columns: ({}fr, {}fr),
      gutter: {},
      align: {},
      [
        {}
      ],
      [
        {}
      ],
    ){}
    ]=],
            {
                i(1, "1"),
                i(2, "1"),
                i(3, "10pt"),
                i(4, "horizon"),
                i(5, "Left content"),
                i(6, "Right content"),
                i(0),
            }
        )
    ),

    s(
        "align",
        fmt(
            [=[
    #align({})[
      {}
    ]{}
    ]=],
            {
                i(1, "center"),
                i(2, "content"),
                i(0),
            }
        )
    ),
}
