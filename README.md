# neovim_configuration  

### 目录树(~/.config/nvim/)  
```
├── init.vim  
├── lua  
│   ├── basic.lua  
│   ├── keybindings.lua  
│   ├── plugin-config  
│   │   ├── Comment.lua  
│   │   ├── bufferline.lua  
│   │   ├── nvim-tree.lua  
│   │   └── nvim-treesitter.lua  
│   └── plugins.lua  
└── plugin  
    └── packer_compiled.lua  
```

### 插件
* <https://github.com/glepnir/zephyr-nvim> 主题配色
* <https://github.com/kyazdani42/nvim-tree.lua> 目录树
* <https://github.com/akinsho/bufferline.nvim> buffer转跳
* <https://github.com/nvim-treesitter/nvim-treesitter> 语法高亮
* <https://github.com/numToStr/Comment.nvim> 注释

### 说明
1. **[点此见快捷键](./docs/keybindings.md)**  
2. 许多参考自：<https://github.com/nshen/learn-neovim-lua>  


## 注意事项！
* 初次使用需安装[packer](./docs/packer.md)以管理插件
* neovim版本必须**0.5**以上，才能使lua  
* treesitter插件里的lua高亮和zephyr主题冲突，删除`$HOME/.local/share/nvim/site/pack/packer/start/zephyr-nvim/after/queries/lua/highlights.scm`文件即可。[见此](https://github.com/nvim-treesitter/nvim-treesitter/issues/2435)
* 初次使用请安装以下依赖```
pip install python-lsp-server  
apt install python3.8-venv nodejs npm
curl -LO
https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
sudo dpkg -i ripgrep_12.1.1_amd64.deb
 ```

### TODO
1. 完善快捷键说明
2. 解决python语法检测无法配置的问题
3. ...
