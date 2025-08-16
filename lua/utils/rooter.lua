-- modified from notjedi/nvim-rooter.lua

local config = {
    cd_scope = "window", -- "global" "window" "tabpage" "smart"
    root_patterns = { ".git", ".hg", ".svn" },
    exclude_filetypes = { "help", "nofile" },
}

local function parent_dir(dir)
    return vim.fn.fnamemodify(dir, ":h")
end

local function change_dir(dir)
    local cd_method = {
        global = vim.api.nvim_set_current_dir,
        window = vim.cmd.lcd,
        tabpage = vim.cmd.tcd,
        smart = vim.fn.chdir,
    }
    cd_method[config.cd_scope](dir)
end

local function rooter()
    if vim.g.SessionLoad == 1 then
        return
    end
    if vim.tbl_contains(config.exclude_filetypes, vim.bo.filetype) then
        return
    end

    local root = vim.fn.exists("b:root_dir") == 1 and vim.api.nvim_buf_get_var(0, "root_dir") or nil
    if root == nil then
        root = vim.fs.root(0, config.root_patterns)
        vim.api.nvim_buf_set_var(0, "root_dir", root)
    end

    change_dir(root)
end

local function rooter_toggle()
    local parent = parent_dir(vim.api.nvim_buf_get_name(0))
    if vim.fn.getcwd() ~= parent then
        change_dir(parent)
    else
        rooter()
    end
end

local group_id = vim.api.nvim_create_augroup("nvim_rooter", { clear = true })

vim.api.nvim_create_autocmd("BufRead", {
    group = group_id,
    callback = function()
        vim.api.nvim_buf_set_var(0, "root_dir", nil)
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    group = group_id,
    nested = true,
    callback = rooter,
})

vim.api.nvim_create_user_command("RooterToggle", rooter_toggle, { nargs = 0 })

-- set the cwd at the moment the script is executed (i.e. VeryLazy)
rooter()
