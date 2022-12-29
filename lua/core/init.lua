local pack = require("core.pack")

-- 基础设置
require("config.options")
-- 快捷键映射
require("config.keymaps")

pack.boot_strap()

-- UI
require("config.ui")
-- Packer插件管理
require("config.plugins")
-- LSP
require("config.lsp")

pack.load_plugins()
require("core.colorscheme").init()
