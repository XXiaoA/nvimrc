-- modified from https://github.com/h-hg/fcitx.nvim/

local api = vim.api
local fn = vim.fn

if fn.executable("fcitx5-remote") ~= 1 then
    return
end

if os.getenv("SSH_TTY") ~= nil then
    return
end

local os_name = vim.uv.os_uname().sysname
if (os_name == "Linux" or os_name == "Unix") and os.getenv("DISPLAY") == nil and os.getenv("WAYLAND_DISPLAY") == nil then
    return
end

--- Switch fcitx5 to English. If save is true, record whether the input method
--- was active so it can be restored when re-entering insert mode.
---@param buf integer
---@param save boolean
local function to_en(buf, save)
    local input_status = tonumber(fn.system("fcitx5-remote"))
    if save then
        api.nvim_buf_set_var(buf, "fcitx5_saved", input_status == 2)
    end
    if input_status == 2 then
        fn.system("fcitx5-remote -c")
    end
end

--- On InsertEnter, restore the input method state that was saved when the user
--- last left insert mode. Other modes always start in English.
---@param buf integer
local function restore_on_insert(buf)
    local ok, saved = pcall(api.nvim_buf_get_var, buf, "fcitx5_saved")
    if ok and saved == true then
        fn.system("fcitx5-remote -o")
    end
end

local fcitx5 = api.nvim_create_augroup("fcitx5", { clear = true })

-- Initialize per-buffer state: do not restore input method by default.
api.nvim_create_autocmd("BufRead", {
    pattern = "*",
    group = fcitx5,
    callback = function(ctx)
        if fn.reg_executing() == "" then
            api.nvim_buf_set_var(ctx.buf, "fcitx5_saved", false)
        end
    end,
})

-- Entering insert mode: restore the input method state saved on the last InsertLeave.
api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    group = fcitx5,
    callback = function(ctx)
        if fn.reg_executing() == "" then
            restore_on_insert(ctx.buf)
        end
    end,
})

-- Leaving insert mode: save current state, then switch to English.
api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    group = fcitx5,
    callback = function(ctx)
        if fn.reg_executing() == "" then
            to_en(ctx.buf, true)
        end
    end,
})

-- Entering or leaving the command line: always switch to English, no state saved.
api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
    pattern = "*",
    group = fcitx5,
    callback = function(ctx)
        if fn.reg_executing() == "" then
            to_en(ctx.buf, false)
        end
    end,
})
