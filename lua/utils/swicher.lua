local M = {}

M.colorschemes = {
    ["gruvbox-material"] = {
        fish = "Gruvbox",
        wezterm = "Gruvbox Dark",
    },
    ["catppuccin-mocha"] = {
        fish = "Catppuccin Mocha",
        wezterm = "Catppuccin Mocha",
    },
    ["catppuccin-macchiato"] = {
        fish = "Catppuccin Macchiato",
        wezterm = "Catppuccin Macchiato",
    },
    ["duskfox"] = {
        fish = "Duskfox",
        wezterm = "Duskfox",
    },
    ["nightfox"] = {
        fish = "Nightfox",
        wezterm = "Nightfox",
    },
    ["tokyonight-storm"] = {
        fish = "Tokyonight Storm",
        wezterm = "Tokyonight Storm",
    },
    ["tokyonight-moon"] = {
        fish = "Tokyonight Moon",
        wezterm = "Tokyonight Moon",
    },
    ["everforest"] = {
        fish = "Everforest",
        wezterm = "Everforest",
    },
    ["rose-pine"] = {
        fish = "Rosé Pine Moon",
        wezterm = "Rosé Pine Moon",
    },
}

function M.fish(colorscheme)
    if colorscheme and vim.fn.executable("fish") then
        vim.fn.system(("yes | fish_config theme save '%s'"):format(colorscheme))
    end
end

function M.wezterm(colorscheme)
    if colorscheme and vim.fn.executable("wezterm") then
        local stdout = vim.loop.new_tty(1, false)
        stdout:write(
            ("\x1b]1337;SetUserVar=%s=%s\b"):format(
                "Nvim_Colorscheme",
                vim.fn.system({ "base64" }, colorscheme)
            )
        )
        vim.cmd([[redraw]])
    end
end

return M
