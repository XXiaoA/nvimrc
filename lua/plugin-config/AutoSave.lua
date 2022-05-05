local autosave = require("utils").requirePlugin("autosave")

if autosave then
    autosave.setup {
        enabled = true,
        -- execution_message = "AutoSave: 于 " .. vim.fn.strftime("%H:%M:%S") .. ' 自动保存',
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true, -- don't save the file if it doesn't exist
            filename_is_not = {},
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
end
