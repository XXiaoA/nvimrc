local function command(filetype)
    local run_command = {}
    run_command['python'] = 'python %'
    run_command['c'] = {"gcc % -o %<", './%<'}
    run_command['lua'] = 'lua %'
    if run_command[filetype] then
        return run_command[filetype]
    end
end

function RunCode()
    vim.cmd("w")
    local run_command = command(vim.o.filetype)
    if type(run_command) == 'string' then
        vim.cmd('1TermExec cmd=' .. "'" .. run_command .. "'")
    else
        for _, commands in pairs(run_command) do
            vim.cmd('1TermExec cmd=' .. "'" .. commands .. "'")
        end
    end
end
