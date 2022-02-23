# neovim_configuration  

### 目录树(~/.config/nvim/)  
<details>
<summary>展开查看</summary>
<pre><code>
.
├── docs
│   ├── Comment.md
│   ├── keybindings.md
│   └── packer.md
├── init.vim
├── lua
│   ├── basic.lua
│   ├── keybindings.lua
│   ├── lsp
│   │   ├── java.lua
│   │   ├── lua.lua
│   │   ├── nvim-cmp.lua
│   │   ├── python.lua
│   │   └── setup.lua
│   ├── plugin-config
│   │   ├── bufferline.lua
│   │   ├── Comment.lua
│   │   ├── galaxyline.lua
│   │   ├── indent_blankline.lua
│   │   ├── lsp-colors.lua
│   │   ├── lualine.lua
│   │   ├── nvim-autopairs.lua
│   │   ├── nvim-colorizer.lua
│   │   ├── nvim-tree.lua
│   │   ├── nvim-treesitter.lua
│   │   ├── rainbow.lua
│   │   ├── telescope.lua
│   │   ├── toggleterm.lua
│   │   └── venn.lua
│   └── plugins.lua
├── plugin
│   └── packer_compiled.lua
├── private_init.lua
└── README.md
</code></pre>
</details>


### 快捷键
**[点此见快捷键](./docs/keybindings.md)**  


## 注意事项！
* 初次使用需安装`packer`以管理插件，请安装。[安装方法](./docs/packer.md) 
* neovim版本必须***0.6***以上，建议最新版  
* treesitter插件里的lua高亮和zephyr主题冲突，删除`$HOME/.local/share/nvim/site/pack/packer/start/zephyr-nvim/after/queries/lua/highlights.scm`文件即可。[见此](https://github.com/nvim-treesitter/nvim-treesitter/issues/2435)
* 初次使用请安装以下依赖
```
pip install python-lsp-server  
apt install python3.8-venv nodejs npm
curl -LO
https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
sudo dpkg -i ripgrep_12.1.1_amd64.deb
 ```
 若想使用lazygit窗口请自行百度查找安装`lazygit`的教程


### 插件
* [主题](https://github.com/glepnir/zephyr-nvim)
* [目录树](https://github.com/kyazdani42/nvim-tree.lua)
* [buffer显示](https://github.com/akinsho/bufferline.nvim)
* [语法高亮](https://github.com/nvim-treesitter/nvim-treesitter)
* [一键注释](https://github.com/numToStr/Comment.nvim)
* [LSP](https://github.com/neovim/nvim-lspconfig)  更多lsp插件请看[plugins.lua文件](./lua/plugins.lua)
* [文件搜索等](https://github.com/nvim-telescope/telescope.nvim)
* [括号补全](https://github.com/windwp/nvim-autopairs) 
* [信标](https://github.com/danilamihailov/beacon.nvim) 
* [搜索转跳提示](https://github.com/inside/vim-search-pulse) 
* [缩进线显示](https://github.com/lukas-reineke/indent-blankline.nvim) 
* [状态栏](https://github.com/nvim-lualine/lualine.nvim) 
* [多光标](https://github.com/mg979/vim-visual-multi) 
* [显示颜色](https://github.com/norcalli/nvim-colorizer.lua) 
* [命令行窗口](https://github.com/akinsho/toggleterm.nvim) 
* [制图](https://github.com/jbyuki/venn.nvim) 
* [彩色括号](https://github.com/luochen1990/rainbow) 
* [运行代码](https://github.com/michaelb/sniprun)
<!-- * [](https://github.com/)  -->
<!-- * [](https://github.com/)  -->
<!-- * [](https://github.com/)  -->
<!-- * [](https://github.com/)  -->
<!-- * [](https://github.com/)  -->
<!-- * [](https://github.com/)  -->
<!-- * [](https://github.com/)  -->
<!-- * [](https://github.com/)  -->
<!-- * [](https://github.com/)  -->

### TODO
1. 完善快捷键说明
2. 解决python语法检测无法配置的问题
3. 给每个插件加使用指北

### 说明：
许多参考自：<https://github.com/nshen/learn-neovim-lua>  
