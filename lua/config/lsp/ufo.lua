local ufo = require("utils").require_plugin("ufo")
if not ufo then
    return
end

local ftMap = {
    -- option: lsp treesitter indent ""
    vim = "indent",
    python = { "indent" },
    git = "",
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

local nmap = require("core.keymap").nmap
nmap("zR", require("ufo").openAllFolds)
nmap("zM", require("ufo").closeAllFolds)
nmap("zr", require("ufo").openFoldsExceptKinds)
nmap("zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
nmap("K", function()
    local winid = require("ufo").peekFoldedLinesUnderCursor()
    if not winid then
        vim.cmd("Lspsaga hover_doc")
    end
end)
