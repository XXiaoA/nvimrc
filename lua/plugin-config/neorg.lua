local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
    vim.notify(" neorg failed to load")
    return
end

neorg.setup {
    -- Tell Neorg what modules to load
    load = {
        -- Load all the default modules
        ["core.defaults"] = {},
        -- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/default_keybinds.lua
        -- ["core.keybinds"] = {
        --   config = {
        --     default_keybinds = true,
        --     neorg_leader = "<leader>",
        --   },
        -- },
        -- Allows for use of icons
        ["core.norg.concealer"] = {},
        -- Manage your directories with Neorg
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    my_workspace = "~/neorg"
                }
            }
        },
        ["core.norg.completion"] = {
            config = {
                engine = "nvim-cmp"
            }
        }
    }
}

local ok, treesitter_parsers = pcall(require, "nvim-treesitter.parsers")
if ok then
  local parser_configs = treesitter_parsers.get_parser_configs()

  parser_configs.norg = {
    install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg",
      files = { "src/parser.c", "src/scanner.cc" },
      branch = "main",
    },
  }

  parser_configs.norg_meta = {
    install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
      files = { "src/parser.c" },
      branch = "main",
    },
  }

  parser_configs.norg_table = {
    install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
      files = { "src/parser.c" },
      branch = "main",
    },
  }
end
