local api = vim.api
local fn = vim.fn

local block
local delay = 1000 -- ms

local autosave = api.nvim_create_augroup("autosave", { clear = true })
-- Initialization
api.nvim_create_autocmd("BufRead", {
    pattern = "*",
    group = autosave,
    callback = function()
        api.nvim_buf_set_var(0, "queued", false)
        block = false
    end,
})

api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = "*",
    group = autosave,
    callback = function()
        local _, queued = pcall(api.nvim_buf_get_var, 0, "queued")
        if not queued then
            local file = fn.expand("%:p")
            if vim.bo.modified and fn.findfile(file, ".") ~= "" then
                vim.cmd("silent w")
                api.nvim_buf_set_var(0, "queued", true)
                vim.notify("saved at " .. vim.fn.strftime("%H:%M:%S"))
            end
        end

        if not block then
            block = true
            vim.defer_fn(function()
                api.nvim_buf_set_var(0, "queued", false)
                block = false
            end, delay)
        end
    end,
})
