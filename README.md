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
**[点此见快捷键](./docs/keybindings.md)**
**初次所以需安装[packer](./docs/packer.md)以管理插件**

neovim版本必须0.5以上，才能使lua  
许多参考自：<https://github.com/nshen/learn-neovim-lua>  

