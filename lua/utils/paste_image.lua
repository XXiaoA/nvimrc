-- Paste a clipboard image beside the current Markdown/Typst document.
local formats = {
    {
        mime = "image/png",
        ext = "png",
        valid = function(data)
            return data:sub(1, 8) == "\137PNG\r\n\26\n"
        end,
    },
    {
        mime = "image/jpeg",
        ext = "jpg",
        valid = function(data)
            return data:sub(1, 3) == "\255\216\255"
        end,
    },
    {
        mime = "image/webp",
        ext = "webp",
        valid = function(data)
            return data:sub(1, 4) == "RIFF" and data:sub(9, 12) == "WEBP"
        end,
    },
    {
        mime = "image/gif",
        ext = "gif",
        valid = function(data)
            return data:sub(1, 6) == "GIF87a" or data:sub(1, 6) == "GIF89a"
        end,
    },
}

local function run(argv)
    local result = vim.system(argv, { text = false }):wait(5000)
    if result.code ~= 0 then
        error(table.concat(argv, " ") .. ": " .. (result.stderr or "failed"))
    end
    return result.stdout or ""
end

local function clipboard_image()
    local list, get
    if vim.fn.executable("wl-paste") == 1 and vim.env.WAYLAND_DISPLAY then
        list = { "wl-paste", "--list-types" }
        get = function(mime)
            return { "wl-paste", "--type", mime }
        end
    elseif vim.fn.executable("xclip") == 1 and vim.env.DISPLAY then
        list = { "xclip", "-selection", "clipboard", "-t", "TARGETS", "-o" }
        get = function(mime)
            return { "xclip", "-selection", "clipboard", "-t", mime, "-o" }
        end
    else
        error("Clipboard image requires wl-paste (Wayland) or xclip (X11)")
    end

    local offered = "\n" .. run(list):gsub("\r", "") .. "\n"
    for _, format in ipairs(formats) do
        if offered:find("\n" .. format.mime .. "\n", 1, true) then
            local data = run(get(format.mime))
            assert(format.valid(data), "Invalid " .. format.ext:upper() .. " clipboard image")
            return data, format.ext
        end
    end
    error("No supported image in clipboard (PNG, JPEG, WebP or GIF)")
end

local function paste(name)
    local buf = vim.api.nvim_get_current_buf()
    local ft = vim.bo[buf].filetype
    assert(ft == "markdown" or ft == "typst", "Not a Markdown or Typst buffer")
    assert(vim.bo[buf].modifiable and not vim.bo[buf].readonly, "Buffer is not writable")
    local document = vim.api.nvim_buf_get_name(buf)
    assert(document ~= "", "Save the document before pasting an image")
    name = name and name ~= "" and name or os.date("%Y%m%d-%H%M%S")
    assert(name:match("^[a-zA-Z0-9_-]+$"), "Invalid image name (use letters, digits, _ or -)")

    local data, ext = clipboard_image()
    local dir = vim.fn.fnamemodify(document, ":h") .. "/assets"
    local stat = vim.uv.fs_stat(dir)
    assert(not stat or stat.type == "directory", "Not a directory: " .. dir)
    if not stat then
        assert(vim.fn.mkdir(dir, "p") ~= 0, "Could not create " .. dir)
    end
    local stem, path, index = name, nil, 0
    repeat
        local filename = stem .. (index == 0 and "" or "-" .. index) .. "." .. ext
        path = dir .. "/" .. filename
        index = index + 1
    until not vim.uv.fs_stat(path)

    -- Exclusive creation prevents overwriting an image even if another process creates it meanwhile.
    local fd, err = vim.uv.fs_open(path, "wx", 420)
    assert(fd, err)
    local ok, write_err = pcall(function()
        local offset = 0
        while offset < #data do
            local written, reason = vim.uv.fs_write(fd, data:sub(offset + 1), offset)
            assert(written and written > 0, reason or "Could not write image")
            offset = offset + written
        end
    end)
    vim.uv.fs_close(fd)
    if not ok then
        vim.uv.fs_unlink(path)
        error(write_err)
    end

    local relative = "assets/" .. vim.fn.fnamemodify(path, ":t")
    local text = ft == "markdown" and ("![%s](%s)"):format(name, relative) or ('#image("%s")'):format(relative)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    col = line == "" and 0 or math.min(col + 1, #line)
    local inserted, insert_err = pcall(vim.api.nvim_buf_set_text, buf, row - 1, col, row - 1, col, { text })
    if not inserted then
        vim.uv.fs_unlink(path)
        error(insert_err)
    end
    vim.notify("Image saved: " .. relative)
end

vim.api.nvim_create_user_command("PasteImage", function(args)
    local ok, err = pcall(paste, args.args)
    if not ok then
        vim.notify(err, vim.log.levels.ERROR)
    end
end, { nargs = "?", desc = "Paste clipboard image into assets/" })

local function map_image_paste(buf)
    vim.keymap.set("n", "<leader>pi", "<cmd>PasteImage<cr>", { buffer = buf, desc = "Paste clipboard image" })
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "typst" },
    callback = function(args)
        map_image_paste(args.buf)
    end,
})

-- VeryLazy may fire after FileType for buffers already open at startup.
for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and (vim.bo[buf].filetype == "markdown" or vim.bo[buf].filetype == "typst") then
        map_image_paste(buf)
    end
end
