---@diagnostic disable: undefined-global
-- stylua: ignore
return {
    s( "date", p(os.date, "%Y-%m-%d")),

    s( "time", p(os.date, "%T")),
}
