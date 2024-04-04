-- extract from plenary.nvim
local reload = function(module_name, starts_with_only)
    -- Default to starts with only
    starts_with_only = starts_with_only or true

    -- TODO: Might need to handle cpath / compiled lua packages? Not sure.
    local matcher
    if not starts_with_only then
        matcher = function(pack)
            return string.find(pack, module_name, 1, true)
        end
    else
        local module_name_pattern = vim.pesc(module_name)
        matcher = function(pack)
            return string.find(pack, "^" .. module_name_pattern)
        end
    end

    for pack, _ in pairs(package.loaded) do
        if matcher(pack) then
            package.loaded[pack] = nil
        end
    end
end

vim.api.nvim_create_user_command("Reload", function(ctx)
    reload(ctx.args)
    return require(ctx.args)
end, {
    nargs = 1,
})
