# neovim_configuration  

## Version
```sh
NVIM v0.7.2
Build type: Release
LuaJIT 2.1.0-beta3
Compiled by builder@3d0cc98614fd
```

<br>

**The following is pretty OUT OF DATE**


## 使用我的配置
1. 你需要安装neovim，并且确保版本在**0.6**及以上
2. clone本仓库的内容到你nvim的配置目录，例如Linux的`~/.config/nvim/`
3. 完成第3步后打开nvim，等待安装[Packer.nvim](./docs/plugins/packer.md) ，有报错很正常。一路跳过即可。然后normal模式执行 `:PackerInstall`
4. 安装[相关依赖](https://github.com/XXiaoA/neovim-configuration#依赖)


## 依赖
* 初次使用需要安装以下依赖，以下以**ubuntu**系统为例 ，其他系统请按照注释自行百度
```
# 安装 python python3.8-venv, g++, gcc, make, nodejs npm
apt install python python3.8-venv g++ gcc make nodejs npm
# 安装 python-lsp-server
pip install python-lsp-server  
# 安装 ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
sudo dpkg -i ripgrep_12.1.1_amd64.deb
# install stylua
apt install stylua
# install black (optional, format the python file)
pip install black
# install clang-format (optional, format the cpp file)
apt install clang-format
 ```

* 如果telescope-fzf-native报错fzf未安装尝试执行以下命令
```
cd ~/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim && make clean && make
```

* 如果 `sniprun` 运行报错执行以下命令
```bash
cd ~/.local/share/nvim/site/pack/packer/start/sniprun && bash ./install.sh 1
```

* 若想使用toggleterm.nvim的`lazygit`窗口请自行百度查找安装lazygit的教程
```bash
sudo add-apt-repository ppa:lazygit-team/daily
sudo apt-get update
sudo apt-get install lazygit
```


markdwon preview
```sh
cd ~/.local/share/nvim/site/pack/packer/opt/
cd markdown-preview.nvim
yarn install
yarn build
```



## 快捷键
[点此见快捷键](./docs/keybindings.md)  


## 注意事项！
**如果你在使用过程中发现问题欢迎提issue，我会尽快回复**

* neovim版本必须***0.6***以上，建议最新版  
* 由于大陆被墙的原因，Packer安装插件困难，所以我使用了镜像。如果不需要可以修改[该文件](https://github.com/XXiaoA/neovim-configuration/blob/master/lua/plugins.lua) 的两个网址


## [插件使用指北](./docs/allPlugins.md)
某些插件的 **简单** 食用方法

## 插件列表
全部请见 [plugins.lua](./lua/plugins.lua#L18)
* [Packer.nvim](https://github.com/wbthomason/packer.nvim) 插件管理
* [gruvbox-material](https://github.com/sainnhe/gruvbox-material) 主题
* [nvim-tree](https://github.com/kyazdani42/nvim-tree.lua) 目录树
* [bufferline](https://github.com/akinsho/bufferline.nvim) buffer显示
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) 语法高亮
* [Comment](https://github.com/numToStr/Comment.nvim) 快捷注释
* [自动补全](https://github.com/hrsh7th/nvim-cmp)  
* [文件搜索等](https://github.com/nvim-telescope/telescope.nvim)
* [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) 括号补全
* [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) 缩进线显示
* [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) 状态栏 
* [nvim-colorizer](https://github.com/norcalli/nvim-colorizer.lua) 显示颜色
* [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) 命令行窗口
* [nvim-ts-rainbow](https://github.com/p00f/nvim-ts-rainbow) 彩色括号
* [sniprun](https://github.com/michaelb/sniprun), [jubnzv/mdeval.nvim](https://github.com/jubnzv/mdeval.nvim) 运行代码
* [dashboard-nvim](https://github.com/glepnir/dashboard-nvim) 启动页
* [impatient.nvim](https://github.com/lewis6991/impatient.nvim)
* [auto_mkdir](https://github.com/DataWraith/auto_mkdir) 自动创建文件夹
* [一键对齐](https://github.com/junegunn/vim-easy-align) 
* [vim-sandwich](https://github.com/machakann/vim-sandwich) 
* [AutoSave.nvim](https://github.com/Pocco81/AutoSave.nvim) 自动保存
* [vim-startuptime](https://github.com/dstein64/vim-startuptime) 计算启动时间
* [hop.nvim](https://github.com/phaazon/hop.nvim) 快速移动
* [vimcdoc](https://github.com/yianwillis/vimcdoc) 中文文档
* [voldikss/vim-translator](https://github.com/voldikss/vim-translator) 翻译
* [formatter](https://github.com/mhartington/formatter.nvim) 格式化代码
* [which-key.nvim](https://github.com/folke/which-key.nvim) 映射按键
* [debugging](https://github.com/mfussenegger/nvim-dap)
* [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens) 高亮搜索
* [aerial.nvim](https://github.com/stevearc/aerial.nvim) 代码大纲
* [project.nvim](https://github.com/ahmedkhalf/project.nvim) 近期项目
* [jubnzv/mdeval.nvim](https://github.com/jubnzv/mdeval.nvim) 在文档运行代码

## 其他
### [TODO](./TODO.md)
### 说明：
感谢：[nshen/learn-neovim-lua](https://github.com/nshen/learn-neovim-lua/tree/bak)
