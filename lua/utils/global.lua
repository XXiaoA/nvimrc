local utils = require("utils")

function _G.changeColorscheme()
    vim.ui.select({ "nightfox", "gruvbox-material" }, {
        prompt = "Select a colorscheme:",
        format_item = function(item)
            return item
        end,
    }, function(choice)
        utils.changeColorscheme(choice)
    end)
end
