-- modified from https://github.com/h-hg/fcitx.nvim/

local api = vim.api
local fn = vim.fn

if vim.fn.executable("fcitx5-remote") ~= 1 then
    return
end

if os.getenv("SSH_TTY") ~= nil then
    return
end

local os_name = vim.loop.os_uname().sysname
if
    (os_name == "Linux" or os_name == "Unix")
    and os.getenv("DISPLAY") == nil
    and os.getenv("WAYLAND_DISPLAY") == nil
then
    return
end

--- switch fcitx5 to English input
---@param buf integer
---@param mode "i"|"o"
local function fcitx5_to_en(buf, mode)
    local input_status = tonumber(fn.system("fcitx5-remote"))
    if input_status == 2 then
        api.nvim_buf_set_var(buf, "fcitx5_should_toggle_" .. mode, true)
        fn.system("fcitx5-remote" .. " -c")
    end
end

--- switch fcitx5 to Non-Latin input
---@param buf integer
---@param mode "i"|"o"
local function fcitx5_to_nonlatin(buf, mode)
    local _, fcitx5_should_toggle =
        pcall(api.nvim_buf_get_var, buf, "fcitx5_should_toggle_" .. mode)
    if fcitx5_should_toggle == true then
        fn.system("fcitx5-remote" .. " -o")
        api.nvim_buf_set_var(buf, "fcitx5_should_toggle_" .. mode, false)
    end
end

local fcitx5 = api.nvim_create_augroup("autosave", { clear = true })

-- Initialization
api.nvim_create_autocmd("BufRead", {
    pattern = "*",
    group = fcitx5,
    callback = function(ctx)
        api.nvim_buf_set_var(ctx.buf, "fcitx5_should_toggle_i", false)
        api.nvim_buf_set_var(ctx.buf, "fcitx5_should_toggle_o", false)
    end,
})

api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    group = fcitx5,
    callback = function(ctx)
        fcitx5_to_nonlatin(ctx.buf, "i")
    end,
})
api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    group = fcitx5,
    callback = function(ctx)
        fcitx5_to_en(ctx.buf, "i")
    end,
})
api.nvim_create_autocmd("CmdlineEnter", {
    pattern = "[/?]",
    group = fcitx5,
    callback = function(ctx)
        fcitx5_to_nonlatin(ctx.buf, "o")
    end,
})
api.nvim_create_autocmd("CmdlineLeave", {
    pattern = "*",
    group = fcitx5,
    callback = function(ctx)
        fcitx5_to_en(ctx.buf, "o")
    end,
})
