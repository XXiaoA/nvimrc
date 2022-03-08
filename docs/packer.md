## Neovim 插件管理与配置

使用 `Packer.nvim` 安装与更新 `Neovim` 插件

## 安装 Packer.nvim 插件管理器

按照官网的说明

```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

```

## 如果是使用我的配置，可以直接阅读[使用方法](https://github.com/XXiaoA/neovim-configuration/blob/master/docs/packer.md#%E6%8F%92%E4%BB%B6%E5%AE%89%E8%A3%85%E4%B8%8E%E6%9B%B4%E6%96%B0) 

然后创建插件配置文件 `lua/plugins.lua` ，Packer 可以管理和升级他自己

修改 `lua/plugins.lua` 为如下代码

```bash
return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
end)
```

`:wq` 保存退出

修改 `init.vim` ，加载这个文件

```vimL
" Packer插件管理
lua require('plugins')
```

`:wq` 保存退出

## 插件安装与更新

Packer.nvim 安装后会增加以下命令，

```lua
-- Regenerate compiled loader file
:PackerCompile

-- Remove any disabled or unused plugins
:PackerClean

-- Clean, then install missing plugins
:PackerInstall

-- Clean, then update and install plugins
:PackerUpdate

-- Perform `PackerUpdate` and then `PackerCompile`
:PackerSync

-- Loads opt plugin immediately
:PackerLoad completion-nvim ale
```

但通常无论 **安装** 还是 **更新** 插件，只需要下边这一条命令就够了。

`:PackerSync`

每次修改完 `lua/plugins.lua` 这个文件后，保存退出，重新打开

调用 `:PackerSync` 就可以了，但要确定你的网络可以连接到 `github`。

安装完成， 按 `q` 退出


- [回首页](../README.md)
