-- SEPARATED from https://github.com/nvimdev/lspsaga.nvim

local lsp, fn, api = vim.lsp, vim.fn, vim.api

local configuraion = {
    width = 0.6,
    height = 0.6,
    border = "rounded",
    keys = {
        edit = "<C-c>o",
        vsplit = "<C-c>v",
        split = "<C-c>i",
        tabe = "<C-c>t",
        quit = "q",
        close = "<C-c>k",
    },
}

local util = {}

util.path_sep = vim.uv.os_uname().sysname:match("Windows") and "\\" or "/"

function util.path_sub(fname, root)
    root = (root and fname:sub(1, #root) == root) and root or vim.env.HOME
    root = root:sub(#root - #util.path_sep + 1) == util.path_sep and root or root .. util.path_sep
    return fname:gsub(vim.pesc(root), "")
end

function util.as_table(value)
    return type(value) ~= "table" and { value } or value
end

function util.map_keys(buffer, keys, rhs, modes, opts)
    opts = opts or {}
    opts.nowait = true
    opts.noremap = true
    modes = modes or "n"

    if type(rhs) == "function" then
        opts.callback = rhs
        rhs = ""
    end

    for _, mode in ipairs(util.as_table(modes)) do
        for _, lhs in ipairs(util.as_table(keys)) do
            api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
        end
    end
end

local win = {}

local function make_floating_popup_options(opts)
    vim.validate({
        opts = { opts, "t", true },
    })
    opts = opts or {}
    vim.validate({
        ["opts.offset_x"] = { opts.offset_x, "n", true },
        ["opts.offset_y"] = { opts.offset_y, "n", true },
    })

    local anchor = ""
    local row, col

    local lines_above = opts.relative == "mouse" and vim.fn.getmousepos().line - 1
        or vim.fn.winline() - 1
    local lines_below = vim.fn.winheight(0) - lines_above

    if lines_above < lines_below then
        anchor = anchor .. "N"
        opts.height = math.min(lines_below, opts.height)
        row = 1
    else
        anchor = anchor .. "S"
        opts.height = math.min(lines_above, opts.height)
        row = 0
    end

    local wincol = opts.relative == "mouse" and vim.fn.getmousepos().column or vim.fn.wincol()

    if wincol + opts.width + (opts.offset_x or 0) <= vim.o.columns then
        anchor = anchor .. "W"
        col = 0
    else
        anchor = anchor .. "E"
        col = 1
    end

    local border = opts.border or configuraion.border

    local title = (border and border ~= "none" and opts.title) and opts.title or nil
    local title_pos

    if title then
        title_pos = opts.title_pos or "center"
    end

    return {
        anchor = anchor,
        bufpos = opts.relative == "win" and opts.bufpos or nil,
        col = col + (opts.offset_x or 0),
        height = opts.height,
        focusable = opts.focusable,
        relative = opts.relative or "cursor",
        row = row + (opts.offset_y or 0),
        style = "minimal",
        width = opts.width,
        border = border,
        zindex = opts.zindex or 50,
        title = title,
        title_pos = title_pos,
        noautocmd = opts.noautocmd or false,
    }
end

local function default()
    return {
        style = "minimal",
        border = configuraion.border,
        noautocmd = false,
    }
end

local obj = {}
obj.__index = obj

function obj:winopt(name, value)
    if type(name) == "table" then
        for key, val in pairs(name) do
            api.nvim_set_option_value(key, val, { scope = "local", win = self.winid })
        end
    else
        api.nvim_set_option_value(name, value, { scope = "local", win = self.winid })
    end
    return self
end

function obj:winhl(normal, border)
    api.nvim_set_option_value("winhl", "Normal:" .. normal .. ",FloatBorder:" .. border, {
        scope = "local",
        win = self.winid,
    })
    return self
end

function obj:wininfo()
    return self.bufnr, self.winid
end

function win:new_float(float_opt, enter, force)
    vim.validate({
        float_opt = { float_opt, "t", true },
    })
    enter = enter or false

    self.bufnr = float_opt.bufnr or api.nvim_create_buf(false, false)
    float_opt.bufnr = nil
    float_opt = not force and make_floating_popup_options(float_opt)
        or vim.tbl_extend("force", default(), float_opt)

    self.winid = api.nvim_open_win(self.bufnr, enter, float_opt)
    return setmetatable(win, obj)
end

function win:minimal_restore()
    local minimal_opts = {
        ["number"] = vim.opt.number,
        ["relativenumber"] = vim.opt.relativenumber,
        ["cursorline"] = vim.opt.cursorline,
        ["cursorcolumn"] = vim.opt.cursorcolumn,
        ["foldcolumn"] = vim.opt.foldcolumn,
        ["spell"] = vim.opt.spell,
        ["list"] = vim.opt.list,
        ["signcolumn"] = vim.opt.signcolumn,
        ["colorcolumn"] = vim.opt.colorcolumn,
        ["fillchars"] = vim.opt.fillchars,
        ["statuscolumn"] = vim.opt.statuscolumn,
        ["winhl"] = vim.opt.winhl,
    }

    local restore = function()
        for opt, val in pairs(minimal_opts) do
            if type(val) ~= "function" then
                vim.opt[opt] = val
            end
        end
    end
    return restore
end

-- a double linked list for store the node infor
local ctx = {}

local function clean_ctx()
    for i, _ in pairs(ctx) do
        ctx[i] = nil
    end
end

local function get_method(index)
    local tbl = { "textDocument/definition", "textDocument/typeDefinition" }
    return tbl[index]
end

local function get_node_idx(list, winid)
    for i, node in ipairs(list) do
        if node.winid == winid then
            return i
        end
    end
end

local function in_def_wins(list, bufnr)
    local wins = fn.win_findbuf(bufnr)
    local in_def = false
    for _, id in ipairs(wins) do
        if get_node_idx(list, id) then
            in_def = true
            break
        end
    end
    return in_def
end

local def = {}
def.__index = def

function def:close_all()
    vim.opt.eventignore:append("WinClosed")
    local function recursive(tbl)
        local node = tbl[#tbl]
        if api.nvim_win_is_valid(node.winid) then
            api.nvim_win_close(node.winid, true)
        end
        if not node.wipe and not in_def_wins(tbl, node.bufnr) then
            self:delete_maps(node.bufnr)
        end
        table.remove(tbl, #tbl)
        if #tbl ~= 0 then
            recursive(tbl)
        end
    end
    recursive(self.list)
    clean_ctx()
    vim.opt.eventignore:remove("WinClosed")
    api.nvim_del_augroup_by_name("SagaPeekdefinition")
end

function def:apply_maps(bufnr)
    for action, map in pairs(configuraion.keys) do
        if action ~= "close" then
            util.map_keys(bufnr, map, function()
                local fname = api.nvim_buf_get_name(0)
                local index = get_node_idx(self.list, api.nvim_get_current_win())
                local start = self.list[index].selectionRange.start
                local client = lsp.get_client_by_id(self.list[index].client_id) or {}
                local pos = {
                    start.line + 1,
                }
                if action == "quit" then
                    vim.cmd[action]()
                    return
                end
                self:close_all()
                local curbuf = api.nvim_get_current_buf()
                if action ~= "edit" or curbuf ~= bufnr then
                    vim.cmd[action](fname)
                end
                pos[2] =
                    lsp.util._get_line_byte_from_position(curbuf, start, client.offset_encoding)
                api.nvim_win_set_cursor(0, pos)
            end)
        else
            util.map_keys(bufnr, map, function()
                self:close_all()
            end)
        end
    end
end

function def:delete_maps(bufnr)
    for _, map in pairs(configuraion.keys) do
        for _, key in ipairs(util.as_table(map)) do
            api.nvim_buf_del_keymap(bufnr, "n", key)
        end
    end
end

function def:create_win(bufnr, root_dir)
    local fname = api.nvim_buf_get_name(bufnr)
    fname = util.path_sub(fname, root_dir)
    if not self.list or vim.tbl_isempty(self.list) then
        local float_opt = {
            width = math.floor(api.nvim_win_get_width(0) * configuraion.width),
            height = math.floor(api.nvim_win_get_height(0) * configuraion.height),
            bufnr = bufnr,
        }
        float_opt.title = fname
        float_opt.title_pos = "center"
        return win:new_float(float_opt, true)
            :winopt("winbar", "")
            :winhl("SagaNormal", "SagaBorder")
            :wininfo()
    end
    local win_conf = api.nvim_win_get_config(self.list[#self.list].winid)
    win_conf.bufnr = bufnr
    win_conf.title = fname
    win_conf.row = win_conf.row[false] + 1
    win_conf.col = win_conf.col[false] + 1
    win_conf.height = win_conf.height - 1
    win_conf.width = win_conf.width - 2
    return win:new_float(win_conf, true, true):wininfo()
end

function def:clean_event()
    api.nvim_create_autocmd("WinClosed", {
        group = api.nvim_create_augroup("SagaPeekdefinition", { clear = true }),
        callback = function(args)
            local curwin = tonumber(args.match)
            local index = get_node_idx(self.list, curwin)
            if not index then
                return
            end
            local bufnr = self.list[index].bufnr

            if self.list[index].restore then
                self.opt_restore()
            end
            local prev = self.list[index - 1] and self.list[index - 1] or nil
            table.remove(self.list, index)
            if prev then
                api.nvim_set_current_win(prev.winid)
            end

            if api.nvim_buf_is_loaded(bufnr) then
                if not in_def_wins(self.list, bufnr) then
                    self:delete_maps(bufnr)
                end
            end

            if not self.list or #self.list == 0 then
                clean_ctx()
                api.nvim_del_autocmd(args.id)
            end
        end,
        desc = "[lspsaga] peek definition clean data event",
    })
end

function def:peek_definition(method)
    if self.pending_reqeust then
        vim.notify(
            "[lspsaga] a peek_definition request has already been sent, please wait.",
            vim.log.levels.WARN
        )
        return
    end

    if not self.list then
        self.list = {}
        self:clean_event()
    end

    local current_buf = api.nvim_get_current_buf()

    -- push a tag stack
    local pos = api.nvim_win_get_cursor(0)
    local current_word = fn.expand("<cword>")
    local from = { current_buf, pos[1], pos[2] + 1, 0 }
    local items = { { tagname = current_word, from = from } }
    fn.settagstack(api.nvim_get_current_win(), { items = items }, "t")

    local params = lsp.util.make_position_params()
    local method_name = get_method(method)
    self.opt_restore = win:minimal_restore()

    self.pending_request = true
    lsp.buf_request(current_buf, method_name, params, function(_, result, context)
        self.pending_request = false
        if not result or next(result) == nil then
            vim.notify(
                "[lspsaga] response of request method " .. method_name .. " is empty",
                vim.log.levels.WARN
            )
            return
        end
        if result.uri then
            result = { result }
        end

        local node = {
            bufnr = vim.uri_to_bufnr(result[1].targetUri or result[1].uri),
            selectionRange = result[1].targetSelectionRange or result[1].range,
            client_id = context.client_id,
        }
        if not api.nvim_buf_is_loaded(node.bufnr) then
            fn.bufload(node.bufnr)
            api.nvim_set_option_value("bufhidden", "wipe", { buf = node.bufnr })
            node.wipe = true
        end
        local root_dir = lsp.get_client_by_id(context.client_id).config.root_dir
        _, node.winid = self:create_win(node.bufnr, root_dir)
        local client = lsp.get_client_by_id(context.client_id) or {}
        api.nvim_win_set_cursor(node.winid, {
            node.selectionRange.start.line + 1,
            lsp.util._get_line_byte_from_position(
                node.bufnr,
                node.selectionRange.start,
                client.offset_encoding
            ),
        })
        self:apply_maps(node.bufnr)
        self.list[#self.list + 1] = node
    end)
end

return setmetatable(ctx, def)
