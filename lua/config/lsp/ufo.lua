local M = {
    "kevinhwang91/nvim-ufo",
    event = { "VeryLazy", "LspAttach" },
    dependencies = {
        "kevinhwang91/promise-async",
    },
}

M.config = function()
    local ufo = require("utils").require("ufo")
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

    local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
                table.insert(newVirtText, chunk)
            else
                chunkText = truncate(chunkText, targetWidth - curWidth)
                local hlGroup = chunk[2]
                table.insert(newVirtText, { chunkText, hlGroup })
                chunkWidth = vim.fn.strdisplaywidth(chunkText)
                -- str width returned from truncate() may less than 2nd argument, need padding
                if curWidth + chunkWidth < targetWidth then
                    suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                end
                break
            end
            curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
    end

    ufo.setup({
        fold_virt_text_handler = handler,
        open_fold_hl_timeout = 150,
        close_fold_kinds_for_ft = {
            default = { "imports" },
        },
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

    local nmap = require("core.keymap").nmap
    nmap("zR", require("ufo").openAllFolds)
    nmap("zM", require("ufo").closeAllFolds)
    nmap("zr", require("ufo").openFoldsExceptKinds)
    nmap("zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
    nmap("K", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
            vim.lsp.buf.hover()
        end
    end)
end

return M
