local function command(filetype)
    local run_command = {}
    run_command["python"] = "python %"
    run_command["lua"] = "lua %"
    run_command["c"] = { "gcc % -o %<.out", "./%<.out" }
    run_command["cpp"] = { "g++ % -o %<.out", "./%<.out" }
    if run_command[filetype] then
        return run_command[filetype]
    end
end

function RunCode()
    vim.cmd("w")

    local run_command = command(vim.o.filetype)
    if type(run_command) == "string" then
        vim.cmd("1TermExec cmd=" .. "'" .. run_command .. "'")
    elseif type(run_command) == "table" then
        for _, commands in pairs(run_command) do
            vim.cmd("1TermExec cmd=" .. "'" .. commands .. "'")
        end
    elseif not run_command then
        vim.notify("You have not set the commands that should be executed for this file type ")
    else
        vim.notify("Something wrong")
    end
end
