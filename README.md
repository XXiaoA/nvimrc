# neovim_configuration  


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
# 用npm安装luafmt(可选，格式化lua文件)
npm i -g lua-fmt
# 安装 ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
sudo dpkg -i ripgrep_12.1.1_amd64.deb
 ```

* 如果telescope-fzf-native报错fzf未安装尝试执行以下命令
```
cd ~/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim && make clean && make
```

* 若想使用toggleterm.nvim的`lazygit`窗口请自行百度查找安装lazygit的教程


## 快捷键
[点此见快捷键](./docs/keybindings.md)  


## 注意事项！
**如果你在使用过程中发现问题欢迎提issue，我会尽快回复**

* neovim版本必须***0.6***以上，建议最新版  
* 由于大陆被墙的原因，Packer安装插件困难，所以我使用了镜像。如果不需要可以删除[该文件](https://github.com/XXiaoA/neovim-configuration/blob/master/lua/plugins.lua) 的10-14行


## [插件使用指北](./docs/allPlugins.md)
某些插件的 **简单** 食用方法

## 插件列表
* [Packer.nvim](https://github.com/wbthomason/packer.nvim) 插件管理
* [gruvbox-material](https://github.com/sainnhe/gruvbox-material) 主题
* [nvim-tree](https://github.com/kyazdani42/nvim-tree.lua) 目录树
* [bufferline](https://github.com/akinsho/bufferline.nvim) buffer显示
* [语法高亮](https://github.com/nvim-treesitter/nvim-treesitter)
* [Comment](https://github.com/numToStr/Comment.nvim) 快捷注释
* [自动补全](https://github.com/hrsh7th/nvim-cmp)  
* [文件搜索等](https://github.com/nvim-telescope/telescope.nvim)
* [括号补全](https://github.com/windwp/nvim-autopairs) 
* [信标](https://github.com/danilamihailov/beacon.nvim) 
* [搜索转跳提示](https://github.com/inside/vim-search-pulse) 
* [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) 缩进线显示
* [状态栏](https://github.com/nvim-lualine/lualine.nvim) 
* [多光标](https://github.com/mg979/vim-visual-multi) 
* [显示颜色](https://github.com/norcalli/nvim-colorizer.lua) 
* [命令行窗口](https://github.com/akinsho/toggleterm.nvim) 
* [彩色括号](https://github.com/luochen1990/rainbow) 
* [运行代码](https://github.com/michaelb/sniprun)
* [dashboard-nvim](https://github.com/glepnir/dashboard-nvim) 启动页
* [impatient.nvim](https://github.com/lewis6991/impatient.nvim); [filetype.nvim](https://github.com/nathom/filetype.nvim)  加快启动速度
* [auto_mkdir](https://github.com/DataWraith/auto_mkdir) 自动创建文件夹
* [一键对齐](https://github.com/junegunn/vim-easy-align) 
* [vim-sandwich](https://github.com/machakann/vim-sandwich) 
* [AutoSave.nvim](https://github.com/Pocco81/AutoSave.nvim) 自动保存
* [vim-startuptime](https://github.com/dstein64/vim-startuptime) 计算启动时间
* [快速移动](https://github.com/phaazon/hop.nvim',) 
* [vimcdoc](https://github.com/yianwillis/vimcdoc) 中文文档
* [翻译](https://github.com/voldikss/vim-translator) 
* [formatter](https://github.com/mhartington/formatter.nvim) 格式化代码
* [which-key.nvim](https://github.com/folke/which-key.nvim) 映射按键
* [debugging](https://github.com/mfussenegger/nvim-dap)
* [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens) 高亮搜索
* [aerial.nvim](https://github.com/stevearc/aerial.nvim) 代码大纲


## 其他
### TODO
1. plugins:  
    - [ ] leaderf  
    - [ ] https://github.com/ahmedkhalf/project.nvim  
    - [ ] https://github.com/ray-x/lsp_signature.nvim  
    - [ ] neo-tree or fern (optional)  
    - [ ] jubnzv/mdeval.nvim (optional)  
    - [ ] xeluxee/competitest.nvim  
2. - [ ] 配置插件  
3. 配置lsp:  
    - [ ] clangd (c, c++)
    - [ ] pylsp (python)
    - [ ] sumneko_lua (lua)
4. - [ ] ~~完善文档~~(maybe)
5. - [ ] ~~给某些插件加使用指北~~(maybe)  

### 说明：
感谢：[nshen/learn-neovim-lua](https://github.com/nshen/learn-neovim-lua)
