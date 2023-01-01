local M = {}
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
    for line, content in ipairs(M.data) do
        -- remove the content after #
        content = utils.trim(content:sub(1, (content:find("#") or 0) - 1), "tail")

        if content:match([[%s*[^%s]*:%s[^%s]+]]) then
            local opt = content:match([[([^%s]*):]])
            local value = content:match([[:%s*([^%s]*)]])
            -- if value is `true` or `false`, return the boolean
            value = value == "true" or value
            if value == "false" then
                value = false
            end
            M.config[opt] = { value = value, line = line }
        end

        ::continue::
    end
end

--- get the value of configuration
---@param opt string
---@return string|boolean|nil
function M.get_value(opt)
    if vim.tbl_isempty(M.config) then
        M.convert_yaml(M.data)
    end
    if M.config[opt] then
        return M.config[opt].value
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
