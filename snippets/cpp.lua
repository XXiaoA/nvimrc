---@diagnostic disable: undefined-global
-- stylua: ignore
return {
    s( "main", fmt([[
    int main() {
        <>

        return 0;
    }
    ]], i(1), {delimiters = "<>"})
    ),

    s( "#inc", fmt([[
    #include "{}"
    ]], i(1))
    ),

    s( "#inc<", fmt([[
    #include <{}>
    ]], i(1))
    ),
}
