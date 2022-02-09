#### Basic mappings

These mappings are enabled by default. (config: `mappings.basic`)

- NORMAL mode

```help
`gcc` - Toggles the current line using linewise comment
`gbc` - Toggles the current line using blockwise comment
`[count]gcc` - Toggles the number of line given as a prefix-count using linewise
`[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
`gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
`gb[count]{motion}` - (Op-pending) Toggles the region using linewise comment
```

<a id="count-prefix">

> NOTE: Dot repeat is not supported with `[count]gcc` and `[count]gbc`

- VISUAL mode

```help
`gc` - Toggles the region using linewise comment
`gb` - Toggles the region using blockwise comment
```

<a id="extra-mappings"></a>

#### Extra mappings

These mappings are enabled by default. (config: `mappings.extra`)

- NORMAL mode

```help
`gco` - Insert comment to the next line and enters INSERT mode
`gcO` - Insert comment to the previous line and enters INSERT mode
`gcA` - Insert comment to end of the current line and enters INSERT mode
```

<a id="extended-mappings"></a>

#### Extended mappings

These mappings are disabled by default. (config: `mappings.extended`)

- NORMAL mode

```help
`g>[count]{motion}` - (Op-pending) Comments the region using linewise comment
`g>c` - Comments the current line using linewise comment
`g>b` - Comments the current line using blockwise comment
`g<[count]{motion}` - (Op-pending) Uncomments the region using linewise comment
`g<c` - Uncomments the current line using linewise comment
`g<b`- Uncomments the current line using blockwise comment
```

- VISUAL mode

```help
`g>` - Comments the region using single line
`g<` - Unomments the region using single line
```

##### Examples

```help
# Linewise

`gcw` - Toggle from the current cursor position to the next word
`gc$` - Toggle from the current cursor position to the end of line
`gc}` - Toggle until the next blank line
`gc5l` - Toggle 5 lines after the current cursor position
`gc8k` - Toggle 8 lines before the current cursor position
`gcip` - Toggle inside of paragraph
`gca}` - Toggle around curly brackets

# Blockwise

`gb2}` - Toggle until the 2 next blank line
`gbaf` - Toggle comment around a function (w/ LSP/treesitter support)
`gbac` - Toggle comment around a class (w/ LSP/treesitter support)
```


* [官网](https://github.com/numToStr/Comment.nvim)
