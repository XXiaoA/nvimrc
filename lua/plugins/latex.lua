return {
    {
        "lervag/vimtex",
        ft = "tex",
        cmd = "VimtexInverseSearch",
        init = function()
            vim.g.vimtex_view_method = "zathura_simple"
            vim.g.vimtex_compiler_method = "latexmk"

            local group = vim.api.nvim_create_augroup("vimtex_zathura_quit", { clear = true })
            vim.api.nvim_create_autocmd("User", {
                group = group,
                pattern = "VimtexEventQuit",
                callback = function()
                    local ok, pdf = pcall(vim.fn.eval, "b:vimtex.viewer.out()")
                    if not ok or type(pdf) ~= "string" or pdf == "" then
                        return
                    end
                    pdf = vim.fn.fnamemodify(pdf, ":p")

                    local function busctl(...)
                        return vim.system({ "busctl", "--user", "--timeout=1", ... }, { text = true }):wait()
                    end

                    local names = busctl("--no-pager", "--no-legend", "list")
                    if names.code ~= 0 then
                        return
                    end

                    for line in names.stdout:gmatch("[^\n]+") do
                        local name = line:match("^(%S+)")
                        if name and name:match("^org%.pwmt%.zathura%.PID%-%d+$") then
                            local property =
                                busctl("get-property", name, "/org/pwmt/zathura", "org.pwmt.zathura", "filename")
                            local encoded_path = property.stdout:match('^s (".*")')
                            if property.code == 0 and encoded_path then
                                local path_ok, open_pdf = pcall(vim.json.decode, encoded_path)
                                if path_ok and open_pdf == pdf then
                                    busctl(
                                        "call",
                                        name,
                                        "/org/pwmt/zathura",
                                        "org.pwmt.zathura",
                                        "ExecuteCommand",
                                        "s",
                                        "quit"
                                    )
                                    return
                                end
                            end
                        end
                    end
                end,
            })

            vim.g.vimtex_compiler_latexmk_engines = {
                ["_"] = "-xelatex",
                pdfdvi = "-pdfdvi",
                pdfps = "-pdfps",
                pdflatex = "-pdf",
                luatex = "-lualatex",
                lualatex = "-lualatex",
                xelatex = "-xelatex",
                ["context (pdftex)"] = "-pdf -pdflatex=texexec",
                ["context (luatex)"] = "-pdf -pdflatex=context",
                ["context (xetex)"] = "-pdf -pdflatex='texexec --xtx'",
            }
        end,
    },
}
