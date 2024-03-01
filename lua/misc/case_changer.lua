local api = vim.api
local fn = vim.fn

local all_case = {
    "dash",
    "camel",
    "snake",
    "upper",
    "pascal",
    "title",
}

-- Gets the row and column for a mark, 1-indexed, if it exists, returns nil otherwise.
---@param mark string The mark whose position will be returned.
---@return integer[]? @The position of the mark.
local function get_mark(mark)
    local position = vim.api.nvim_buf_get_mark(0, mark)
    if position[1] == 0 then
        return nil
    end
    return { position[1], position[2] + 1 }
end

--- Get the current buffer text
---@param start_pos integer[]
---@param end_pos integer[]
---@return string[]
local function get_text(start_pos, end_pos)
    return api.nvim_buf_get_text(0, start_pos[1] - 1, start_pos[2] - 1, end_pos[1] - 1, end_pos[2], {})
end

--- check what kind of type the text is
---@param text string
local function check_type(text)
    -- \C - case sensitive
    -- \v  -  magic mode
    local dash = vim.regex([==[\v^[a-z0-9]+(-+[a-z0-9]+)+$]==]) -- dash-case
    local camel = vim.regex([==[\v\C^[a-z][a-z0-9]*([A-Z][a-z0-9]*)*$]==]) --  camelCase
    local snake = vim.regex([==[\v\C^[a-z0-9]+(_+[a-z0-9]+)*$]==]) -- snake_case
    local upper = vim.regex([==[\v\C^[A-Z][A-Z0-9]*(_[A-Z0-9]+)*$]==]) -- UPPER_CASE
    local pascal = vim.regex([==[\v\C^[A-Z][a-z0-9]*([A-Z0-9][a-z0-9]*)*$]==]) -- PascalCase
    local title = vim.regex([==[\v\C^[A-Z][a-z0-9]*( [A-Z][a-z0-9]+)*$]==]) -- Title Case

    if dash:match_str(text) then
        return "dash"
    elseif camel:match_str(text) then
        return "camel"
    elseif snake:match_str(text) then
        return "snake"
    elseif upper:match_str(text) then
        return "upper"
    elseif pascal:match_str(text) then
        return "pascal"
    elseif title:match_str(text) then
        return "title"
    end
end

--- split text into words
---@param text string
---@return string[]
local function split_text(text)
    local text_type = check_type(text)
    if text_type == "dash" then
        return fn.split(text, "-")
    elseif text_type == "camel" then
        local words = {}
        local first_upper_char = text:find("%u")
        local first_word = text:sub(0, first_upper_char - 1)
        local rest_word = text:sub(first_upper_char)
        table.insert(words, first_word)
        for word in rest_word:gmatch("%u%U*") do
            table.insert(words, word:lower())
        end
        return words
    elseif text_type == "snake" then
        return fn.split(text, "_")
    elseif text_type == "upper" then
        return fn.split(text, "_")
    elseif text_type == "pascal" then
        local words = {}
        for word in text:gmatch("%u%U*") do
            table.insert(words, word:lower())
        end
        return words
    elseif text_type == "title" then
        return fn.split(text, " ")
    else
        return { text }
    end
end

--- convert the text into dash style
---@param text string
---@return string
local function to_dash(text)
    local texts = split_text(text)
    return table.concat(texts, "-"):lower()
end

--- convert the text into camel style
---@param text string
---@return string
local function to_camel(text)
    local texts = split_text(text)
    local result = ""
    for i, word in ipairs(texts) do
        if i == 1 then
            result = result .. word
        else
            -- upper the first char
            result = result .. word:gsub("^%l", string.upper)
        end
    end
    return result
end

--- convert the text into snake style
---@param text string
---@return string
local function to_snake(text)
    local texts = split_text(text)
    return table.concat(texts, "_"):lower()
end

--- convert the text into upper style
---@param text string
---@return string
local function to_upper(text)
    local texts = split_text(text)
    return table.concat(texts, "_"):upper()
end

--- convert the text into pascal style
---@param text string
---@return string
local function to_pascal(text)
    local texts = split_text(text)
    local result = ""
    for _, word in ipairs(texts) do
        -- upper the first char
        result = result .. word:gsub("^%l", string.upper)
    end
    return result
end

--- convert the text into title style
---@param text string
---@return string
local function to_title(text)
    local texts = split_text(text)
    for i, word in ipairs(texts) do
        -- upper the first char
        texts[i] = word:gsub("^%l", string.upper)
    end
    return table.concat(texts, " ")
end

--- change the case
---@param text string
---@param type string
local function change_case(text, type)
    type = type or "snake"
    if type == "dash" then
        return to_dash(text)
    elseif type == "camel" then
        return to_camel(text)
    elseif type == "snake" then
        return to_snake(text)
    elseif type == "upper" then
        return to_upper(text)
    elseif type == "pascal" then
        return to_pascal(text)
    elseif type == "title" then
        return to_title(text)
    end
end

api.nvim_create_user_command("CaseChange", function(ctx)
    local current_name
    if ctx.range == 0 then
        current_name = vim.fn.expand("<cword>")
    else
        local start_pos = get_mark("<")
        local end_pos = get_mark(">")
        ---@diagnostic disable-next-line: param-type-mismatch
        current_name = get_text(start_pos, end_pos)
        current_name = table.concat(current_name, "\n")
    end

    local new_name
    new_name = change_case(current_name, ctx.args)

    if ctx.range == 0 then
        vim.cmd.normal({ "diwi" .. new_name, bang = true })
    else
        vim.cmd.normal({ "gvc" .. new_name, bang = true })
    end
end, {
    range = true,
    nargs = 1,
    complete = function(arg)
        return vim.tbl_filter(function(s)
            return string.match(s, "^" .. arg)
        end, all_case)
    end,
})
