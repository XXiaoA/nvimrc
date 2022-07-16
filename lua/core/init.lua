local packer = require("core.packer")

-- 基础设置
require("config.options")
-- 快捷键映射
require("config.keymaps")

packer.init_packer()

-- colorscheme
require("config.colorscheme")
-- Packer插件管理
require("config.plugins")
-- LSP
require("config.lsp")

packer.load_plugins()
