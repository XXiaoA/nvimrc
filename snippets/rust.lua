---@diagnostic disable: undefined-global
-- stylua: ignore
return {
    s("println", fmta([[println!("{<>:#?}");]], {
        i(1)
    })
    ),
}
