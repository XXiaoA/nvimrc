local api = vim.api
local fn = vim.fn

local delay = 500 -- ms

local autosave = api.nvim_create_augroup("autosave", { clear = true })
-- Initialization
api.nvim_create_autocmd("BufRead", {
    pattern = "*",
    group = autosave,
    callback = function(ctx)
        api.nvim_buf_set_var(ctx.buf, "autosave_queued", false)
        api.nvim_buf_set_var(ctx.buf, "autosave_block", false)
    end,
})

api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = "*",
    group = autosave,
    callback = function(ctx)
        local ok, queued = pcall(api.nvim_buf_get_var, ctx.buf, "autosave_queued")
        if not ok then
            return
        end

        if not queued then
            if
                -- conditions to save
                vim.bo.modified
                and fn.findfile(ctx.file, ".") ~= ""
                and not ctx.file:match("wezterm.lua")
            then
                vim.cmd("silent w")
                api.nvim_buf_set_var(ctx.buf, "autosave_queued", true)
                vim.notify("Saved at " .. os.date("%H:%M:%S"))
            end
        end

        local block = api.nvim_buf_get_var(ctx.buf, "autosave_block")
        if not block then
            api.nvim_buf_set_var(ctx.buf, "autosave_block", true)
            vim.defer_fn(function()
                if api.nvim_buf_is_valid(ctx.buf) then
                    api.nvim_buf_set_var(ctx.buf, "autosave_queued", false)
                    api.nvim_buf_set_var(ctx.buf, "autosave_block", false)
                end
            end, delay)
        end
    end,
})
