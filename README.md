# neovim_configuration  

## Version
```text
nightly
```


## Install
```bash
git clone https://github.com/XXiaoA/nvimrc ~/.config/nvim
```


## Dependencies
Run `:checkhealth` in neovim


## Notice
for formatting feature (optional): [formatters](./lua/config/plugins/formatter.lua) <br>
for lazygit float window (optional): [lazygit](https://github.com/jesseduffield/lazygit) <br>

If you fail to install telescope-fzf-native, try to run the following code:
```bash
cd ~/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim && make clean && make
```

If you want to use markdwon preview, run:
```bash
cd ~/.local/share/nvim/site/pack/packer/opt/
cd markdown-preview.nvim
yarn install
yarn build
```


## Others
### [TODO](./TODO.md)
