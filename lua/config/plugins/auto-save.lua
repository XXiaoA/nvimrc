local autosave = require("utils").requirePlugin("auto-save")

if not autosave then
    return
end

autosave.setup()

-- autosave.setup({
--     execution_message = {
--         dim = 0,
--     },
-- })
