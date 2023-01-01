local session_manager = require("utils").require("session_manager")

local nmap = require("core.keymap").nmap
nmap("<leader>ss", "<cmd>SessionManager save_current_session<CR>", { desc = "save session" })
nmap("<leader>sl", "<cmd>SessionManager load_last_session<CR>", { desc = "load last session" })
nmap("<leader>sc", "<cmd>SessionManager load_session<CR>", { desc = "load session" })
nmap("<leader>sd", "<cmd>SessionManager delete_session<CR>", { desc = "delete session" })

if session_manager then
    session_manager.setup({
        autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
        autosave_last_session = false,
    })
end
