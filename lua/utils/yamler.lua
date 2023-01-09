local M = {}
local utils = require("utils")
local fn = vim.fn

M.file_path = vim.fn.stdpath("config") .. "/config.yml"
---@type string[]
M.data = {}
---@type table<string, {value:string|boolean, line:integer}>
M.config = {}

--- read the original data of file
function M.read_data()
    local f = assert(io.open(M.file_path, "r"))
    local data
    if f then
        data = f:read("*a")
        f:close()
        M.data = fn.split(data, "\n")
    end
end

--- convert the original data into table
---@param data string[]
function M.convert_yaml(data)
    if vim.tbl_isempty(data) then
        M.read_data()
    end
    local _skip = 0
    for line, content in ipairs(M.data) do
        while _skip > 0 do
            _skip = _skip - 1
            goto countine
        end
        -- remove the content after #
        content = utils.trim(content:sub(1, (content:find("#") or 0) - 1), "tail")

        -- something likes `a:` maybe is a nested mapping
        if content:match([[^([^%s]*):%s*$]]) then
            --- all content inside nested mapping
            local contents = {}
            local next_content
            while true do
                _, next_content = next(M.data, line)
                next_content =
                    utils.trim(next_content:sub(1, (next_content:find("#") or 0) - 1), "tail")
                if next_content:match("^$") then
                    line = line + 1
                else
                    break
                end
            end
            table.insert(contents, utils.trim(next_content))
            --- count how many lines inside nest
            local count = 0
            while true do
                count = count + 1
                local indent_count = next_content:find("[^%s]") - 1
                local _, new_next_content = next(M.data, line + count)
                if not new_next_content:match([[%s*[^%s]*:%s+[^%s]+%s*]]) then
                    break
                end
                -- without indent or empty string
                if indent_count == 0 or new_next_content:match("^$") then
                    break
                    -- is a comment
                elseif new_next_content:match("%s*#") then
                    goto countine
                end
                local new_indent_count = new_next_content:find("[^%s]") - 1
                -- indent changed
                if new_indent_count ~= indent_count then
                    break
                end
                table.insert(contents, utils.trim(new_next_content))
                ::countine::
            end

            local father = content:match("(%s*[^%s]*):%s*")
            M.config[father] = {}
            for _, _content in ipairs(contents) do
                local opt, value = _content:match([[%s*([^%s]*):%s+([^%s]+)%s*]])
                M.config[father][opt] = value
            end
            _skip = count
        elseif content:match([[%s*[^%s]*:%s+[^%s]+%s*]]) then
            local opt, value = content:match([[%s*([^%s]*):%s+([^%s]+)%s*]])
            -- if value is `true` or `false`, return the boolean
            value = value == "true" or value
            value = (value == "false" and { false } or { value })[1]
            M.config[opt] = { value = value, line = line }
        end
        ::countine::
    end
end

--- get the value of configuration
---@param opt string
---@return string|boolean|table|nil
function M.get_value(opt)
    if vim.tbl_isempty(M.config) then
        M.convert_yaml(M.data)
    end
    if M.config[opt] ~= nil then
        return (M.config[opt].value ~= nil and { M.config[opt].value } or { M.config[opt] })[1]
    end
end

--- modify the value
---@param opt string
---@param value string
function M.modify_value(opt, value)
    if vim.tbl_isempty(M.config) then
        M.convert_yaml(M.data)
    end
    if M.config[opt] and value ~= M.config[opt].value then
        M.config[opt].value = value
        --- the line number of the configuration in the original file
        local opt_line = M.config[opt].line
        M.data[opt_line] = M.data[opt_line]:gsub([[:%s*([^%s]*)]], ": " .. value, 1)

        local f = assert(io.open(M.file_path, "w"))
        f:write(table.concat(M.data, "\n"))
        f:close()
    end
end

return M
