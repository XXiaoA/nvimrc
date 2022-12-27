---@diagnostic disable: undefined-global
-- stylua: ignore
return {
    s( "main", fmt([[
    int main(int argc, char *argv[]) {
        <>

        return 0;
    }
    ]], i(0), {delimiters = "<>"})
    ),
}
