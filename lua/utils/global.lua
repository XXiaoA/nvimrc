local colorscheme = require("utils.colorscheme")

function _G.changeColorscheme()
    vim.ui.select(
        {"nightfox", "gruvbox-material"},
        {
            prompt = "Select a colorscheme:",
            format_item = function(item)
                return item
            end
        },
        function(choice)
            colorscheme.changeColorscheme(choice)
        end
    )
end
