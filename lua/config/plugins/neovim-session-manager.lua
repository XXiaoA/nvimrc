local session_manager = require("utils").requirePlugin("session_manager")

if session_manager then
    session_manager.setup({
        autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
        autosave_last_session = false,
    })
end
