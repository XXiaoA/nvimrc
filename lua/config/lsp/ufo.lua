local ufo = require("utils").requirePlugin("ufo")
if not ufo then
    return
end

local ftMap = {
    -- option: lsp treesitter indent ""
    vim = "indent",
    python = { "indent" },
    git = function(bufnr)
        local res = {}
        local fileStart, hunkStart
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
        for i, line in ipairs(lines) do
            if line:match("^diff %-%-") then
                if hunkStart then
                    table.insert(res, { startLine = hunkStart - 1, endLine = i - 2 })
                end
                if fileStart then
                    table.insert(res, { startLine = fileStart - 1, endLine = i - 2 })
                end
                hunkStart, fileStart = nil, nil
            elseif line:match("^@@ %-%d+,%d+ %+%d+,%d+") then
                if hunkStart then
                    table.insert(res, { startLine = hunkStart - 1, endLine = i - 2 })
                end
                hunkStart = i
            elseif line:match("^%-%-%- %S") then
                fileStart = i
            end
        end
        if hunkStart then
            table.insert(res, { startLine = hunkStart - 1, endLine = #lines - 2 })
        end
        if fileStart then
            table.insert(res, { startLine = fileStart - 1, endLine = #lines - 2 })
        end
        return res
    end,
}

local function customizeSelector(bufnr)
    local function handleFallbackException(err, providerName)
        if type(err) == "string" and err:match("UfoFallbackException") then
            return ufo.getFolds(providerName, bufnr)
        else
            return require("promise").reject(err)
        end
    end

    return ufo.getFolds("lsp", bufnr)
        :catch(function(err)
            return handleFallbackException(err, "treesitter")
        end)
        :catch(function(err)
            return handleFallbackException(err, "indent")
        end)
end

ufo.setup({
    open_fold_hl_timeout = 150,
    close_fold_kinds = { "imports", "comment" },
    preview = {
        win_config = {
            border = "single",
            winhighlight = "Normal:Folded",
            winblend = 0,
        },
        mappings = {
            scrollU = "<C-u>",
            scrollD = "<C-d>",
            switch = "K",
        },
    },
    ---@diagnostic disable-next-line: unused-local
    provider_selector = function(bufnr, filetype, buftype)
        return ftMap[filetype] or customizeSelector
    end,
})

vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set("n", "K", function()
    local winid = require("ufo").peekFoldedLinesUnderCursor()
    if not winid then
        vim.lsp.buf.hover()
    end
end)
