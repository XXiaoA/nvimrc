-- separate from https://github.com/nvimdev/lspsaga.nvim
-- TODO: refactor it

local lsp, api, fn = vim.lsp, vim.api, vim.fn
local buffers = {}
local main_winid

-- options for peek window
local options = {
    -- nu = true,
}

local maps = {
    edit = "<C-c>o",
    vsplit = "<C-c>v",
    split = "<C-c>i",
    tabe = "<C-c>t",
    quit = "q",
}

local function check_lsp_active(silent)
    silent = silent or true
    local current_buf = api.nvim_get_current_buf()
    local active_clients = vim.lsp.get_clients({ buffer = current_buf })
    if next(active_clients) == nil then
        if not silent then
            vim.notify("Current buffer does not have any lsp server")
        end
        return false
    end
    return true
end

local function make_floating_popup_options(width, height, opts)
    vim.validate({
        opts = { opts, "t", true },
    })
    opts = opts or {}
    vim.validate({
        ["opts.offset_x"] = { opts.offset_x, "n", true },
        ["opts.offset_y"] = { opts.offset_y, "n", true },
    })
    local new_option = {}

    new_option.style = "minimal"
    new_option.width = width
    new_option.height = height
    new_option.focusable = true
    if opts.focusable then
        new_option.focusable = opts.focusable
    end

    if opts.noautocmd then
        new_option.noautocmd = opts.noautocmd
    end

    if opts.relative ~= nil then
        new_option.relative = opts.relative
    else
        new_option.relative = "cursor"
    end

    if opts.anchor ~= nil then
        new_option.anchor = opts.anchor
    end

    if opts.row == nil and opts.col == nil then
        local lines_above = vim.fn.winline() - 1
        local lines_below = vim.fn.winheight(0) - lines_above
        new_option.anchor = ""

        local pum_pos = vim.fn.pum_getpos()
        local pum_vis = not vim.tbl_isempty(pum_pos) -- pumvisible() can be true and pum_pos() returns {}
        if
            pum_vis and vim.fn.line(".") >= pum_pos.row
            or not pum_vis and lines_above < lines_below
        then
            new_option.anchor = "N"
            new_option.row = 1
        else
            new_option.anchor = "S"
            new_option.row = 0
        end

        if vim.fn.wincol() + width <= api.nvim_get_option("columns") then
            new_option.anchor = new_option.anchor .. "W"
            new_option.col = 0
            if opts.move_col then
                new_option.col = new_option.col + opts.move_col
            end
        else
            new_option.anchor = new_option.anchor .. "E"
            new_option.col = 1
            if opts.move_col then
                new_option.col = new_option.col - opts.move_col + 1
            end
        end
    else
        new_option.row = opts.row
        new_option.col = opts.col
    end

    return new_option
end

local function generate_win_opts(contents, opts)
    opts = opts or {}
    local win_width, win_height
    -- _make_floating_popup_size doesn't allow the window size to be larger than
    -- the current window. For the finder preview window, this means it won't let the
    -- preview window be wider than the finder window. To work around this, the
    -- no_size_override option can be set to indicate that the size shouldn't be changed
    -- from what was given.
    if opts.no_size_override and opts.width and opts.height then
        win_width, win_height = opts.width, opts.height
    else
        win_width, win_height = vim.lsp.util._make_floating_popup_size(contents, opts)
    end

    opts = make_floating_popup_options(win_width, win_height, opts)
    return opts
end

local function create_win_with_border(content_opts, opts)
    vim.validate({
        content_opts = { content_opts, "t" },
        contents = { content_opts.content, "t", true },
        opts = { opts, "t", true },
    })

    local contents, filetype = content_opts.contents, content_opts.filetype
    local enter = content_opts.enter or false
    local highlight = content_opts.highlight or "LspFloatWinBorder"
    opts = opts or {}
    opts = generate_win_opts(contents, opts)
    opts.border = content_opts.border or "rounded"
    opts.title = "XXiaoA"
    opts.title_pos = "center"

    -- create contents buffer
    local bufnr = content_opts.bufnr or api.nvim_create_buf(false, true)
    -- buffer settings for contents buffer
    -- Clean up input: trim empty lines from the end, pad
    ---@diagnostic disable-next-line: missing-parameter
    local content = vim.lsp.util._trim(contents)

    if filetype then
        api.nvim_buf_set_option(bufnr, "filetype", filetype)
    end

    content = vim.tbl_flatten(vim.tbl_map(function(line)
        if string.find(line, "\n") then
            return vim.split(line, "\n")
        end
        return line
    end, content))

    if not vim.tbl_isempty(content) then
        api.nvim_buf_set_lines(bufnr, 0, -1, true, content)
    end

    if api.nvim_buf_is_valid(bufnr) then
        api.nvim_buf_set_option(bufnr, "modifiable", false)
        api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")
    end

    local winid = api.nvim_open_win(bufnr, enter, opts)
    api.nvim_win_set_option(winid, "winhl", "Normal:LspFloatWinNormal,FloatBorder:" .. highlight)
    api.nvim_win_set_option(winid, "winblend", content_opts.winblend or 0)

    api.nvim_win_set_option(winid, "winbar", "")

    return bufnr, winid
end

local function find_current_scope()
    local curr_winid = api.nvim_get_current_win()

    local curr_scope
    for _, scope in pairs(buffers) do
        if type(scope) == "table" then
            if scope.winid == curr_winid then
                curr_scope = scope
                break
            end
        end
    end

    return curr_scope
end

-- Function to iterate all the scopes with given callback function
-- @param cb - The callback function for each scope
local function process_all_scopes(cb)
    for bufnr, scopes in pairs(buffers) do
        if type(scopes) == "table" and api.nvim_buf_is_valid(bufnr) then
            for _, scope in ipairs(scopes) do
                cb(bufnr, scope)
            end
        end
    end
end

-- Function to find the last definition window and then focus it
local function focus_last_window()
    local last_window
    local curr_win = api.nvim_get_current_win()
    process_all_scopes(function(_, scope)
        local valid_win = scope.winid ~= curr_win and api.nvim_win_is_valid(scope.winid)

        if (last_window == nil or scope.winid > last_window) and valid_win then
            last_window = scope.winid
        end
    end)

    if last_window ~= nil then
        api.nvim_set_current_win(last_window)
    end
end

-- Function to close the given window
-- @param curr_scope - Scope data for the current window
-- @param opts       - Options including `close_all`
local function close_window(curr_scope, opts)
    opts = opts or {}
    local curr_bufnr = api.nvim_get_current_buf()

    local close_scope = function(item)
        local bufnr, winid = item.bufnr, item.winid
        if bufnr and api.nvim_buf_is_loaded(bufnr) then
            api.nvim_buf_delete(bufnr, { force = true })
        end

        if winid and api.nvim_win_is_valid(winid) then
            api.nvim_win_close(winid, true)
        end
    end

    if opts.close_all then
        process_all_scopes(function(bufnr, scope)
            close_scope(scope)

            if bufnr ~= curr_bufnr then
                api.nvim_buf_delete(bufnr, { force = true })
            end
        end)
    elseif curr_scope ~= nil then
        close_scope(curr_scope)
    end
end

-- Function to clear the tmp data on triggering the keymap
-- @param bufnr       - Current buffer number
-- @param curr_scope  - Scope data for the current window
-- @param opts        - Options including `close_all`
local function clear_tmp_data(bufnr, curr_scope, opts)
    opts = opts or {}

    if opts.close_all then
        process_all_scopes(function(key, _)
            buffers[key] = nil
        end)
    elseif curr_scope ~= nil then
        local scopes = buffers[bufnr]

        local matched_index
        if scopes ~= nil then
            for i, item in ipairs(scopes) do
                if item.winid == curr_scope.winid then
                    matched_index = i
                end
            end

            if matched_index ~= nil then
                table.remove(scopes, matched_index)
            end
        end
    end

    -- INFO: unset the `main_winid` when all the definition windows are closed.
    local cleared = true
    process_all_scopes(function(_, _)
        cleared = false
    end)

    if cleared then
        main_winid = nil
    end
end

-- Function to clear all the keymappings when there's no window
-- @param bufnr - The buffer number that those keymappings set for
local function clear_all_maps(bufnr)
    local scopes = buffers[bufnr]

    if scopes == nil or next(scopes) == nil then
        if api.nvim_buf_is_valid(bufnr) then
            for _, key in pairs(maps) do
                vim.keymap.del("n", key, { buffer = bufnr })
            end
        end
    end
end

local function apply_aciton_keys(scope, bufnr, pos)
    -- Save the current scope data
    if buffers[bufnr] == nil then
        buffers[bufnr] = {}
    end
    table.insert(buffers, scope)

    for action, key in pairs(maps) do
        vim.keymap.set("n", key, function()
            local curr_scope = find_current_scope()
            local link, def_win_ns = curr_scope.link, curr_scope.def_win_ns

            api.nvim_buf_clear_namespace(bufnr, def_win_ns, 0, -1)

            local non_quit_action = action ~= "quit"

            if non_quit_action then
                local win
                api.nvim_win_call(main_winid, function()
                    vim.cmd(action .. " " .. link)
                    win = api.nvim_get_current_win()
                end)

                if win then
                    api.nvim_set_current_win(win)
                    api.nvim_win_set_cursor(win, { pos[1] + 1, pos[2] })
                end
            else
                focus_last_window() -- INFO: Only focus the last window when `quit`
            end

            close_window(curr_scope, { close_all = non_quit_action })

            clear_tmp_data(bufnr, curr_scope, { close_all = non_quit_action })
            clear_all_maps(bufnr)
        end, { buffer = bufnr })
    end
end

local function peek_definition()
    local scope = {}
    if not check_lsp_active() then
        return
    end

    -- push a tag stack
    local pos = api.nvim_win_get_cursor(0)
    local current_word = vim.fn.expand("<cword>")
    local from = { api.nvim_get_current_buf(), pos[1], pos[2] + 1, 0 }
    local items = { { tagname = current_word, from = from } }
    vim.fn.settagstack(api.nvim_get_current_win(), { items = items }, "t")

    local filetype = vim.api.nvim_buf_get_option(0, "filetype")
    local params = lsp.util.make_position_params()

    local current_buf = api.nvim_get_current_buf()
    if not main_winid then
        main_winid = api.nvim_get_current_win()
    end

    lsp.buf_request_all(current_buf, "textDocument/definition", params, function(results)
        if not results or next(results) == nil then
            vim.notify("Response of request method textDocument/definition is nil")
            return
        end

        local result
        for _, res in pairs(results) do
            if res and res.result then
                result = res.result
            end
        end

        if not result then
            vim.notify("Response of request method textDocument/definition is nil")
            return
        end

        local uri, range

        if type(result[1]) == "table" then
            uri = result[1].uri or result[1].targetUri
            range = result[1].range or result[1].targetRange
        else
            uri = result.uri or result.targetUri
            range = result.range or result.targetRange
        end

        if not uri then
            return
        end

        local bufnr = vim.uri_to_bufnr(uri)
        scope.link = vim.uri_to_fname(uri)

        if not vim.api.nvim_buf_is_loaded(bufnr) then
            fn.bufload(bufnr)
        end

        local start_line = range.start.line
        local start_char_pos = range.start.character
        local end_char_pos = range["end"].character

        local opts = {
            relative = "cursor",
            style = "minimal",
        }
        local WIN_WIDTH = api.nvim_get_option("columns")
        local max_width = math.floor(WIN_WIDTH * 0.6)
        local max_height = math.floor(vim.o.lines * 0.6)

        opts.width = max_width
        opts.height = max_height

        opts = lsp.util.make_floating_popup_options(max_width, max_height, opts)

        opts.row = opts.row + 1
        local content_opts = {
            contents = {},
            filetype = filetype,
            enter = true,
            highlight = "DefinitionBorder",
        }

        scope.bufnr, scope.winid = create_win_with_border(content_opts, opts)
        vim.opt_local.modifiable = true
        api.nvim_win_set_buf(0, bufnr)
        --set the initail cursor pos
        api.nvim_win_set_cursor(scope.winid, { start_line + 1, start_char_pos })
        vim.cmd("normal! zt")

        scope.def_win_ns = api.nvim_create_namespace("DefinitionWinNs-" .. scope.bufnr)
        api.nvim_buf_add_highlight(
            bufnr,
            scope.def_win_ns,
            "DefinitionSearch",
            start_line,
            start_char_pos,
            end_char_pos
        )

        apply_aciton_keys(scope, bufnr, { start_line, start_char_pos })

        for option, value in pairs(options) do
            api.nvim_win_set_option(scope.winid, option, value)
        end
    end)
end

api.nvim_create_user_command("LspPeek", peek_definition, {})
