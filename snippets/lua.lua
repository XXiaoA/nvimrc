---@diagnostic disable: undefined-global
-- stylua: ignore
return {
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
    ]], { i(1), i(0) } )
    ),

    s("req", fmt([[
    require("{}")
    ]], i(1) )
    ),

    s("class", fmta([[
    local <> = {}

    function <class>:new(<>)
        <o> = <o> or {}
        <>
        self.__index = self
        setmetatable(<o>, self)
        return <o>
    end
    ]], {
        i(1, "Class"),
        class = f(function(args) return args[1] end, { 1 }),
        i(2, "o"),
        o = f(function(args) return args[1] end, { 2 }),
        i(0),
    })),
}
