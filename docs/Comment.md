#### 基础映射 Basic mappings
默认情况下启用这些映射。

- 命令模式

```帮助
`gcc` - 使用单行注释注释当前行
`gbc` - 使用多行注释注释当前行
`[行数]gcc` - 使用单行注释向下注释给出的行数
`[行数]gbc` - 使用多行注释向下注释给出的行数
`gc[行数]{方向}` - 使用单行注释向给出的方向注释给出的行数
`gb[行数]{方向}` - 使用多行注释向给出的方向注释给出的行数

```

> 注意:不支持`.`重复 `[行数]gcc` 和 `[行数]gbc`

- 选择模式

```帮助
`gc` - 使用单行注释注释所选的行
`gb` - 使用多行注释注释所选的行
```

#### 额外映射 Extra mappings
默认情况下启用这些映射。

- 命令模式

```帮助
`gco` - 将注释插入到下一行并进入输入模式
`gcO` - 将注释插入到上一行并进入输入模式
`gcA` - 将注释插入到当前行尾并进入输入模式
```

#### 扩展映射 Extended mappings
默认情况下启用这些映射。

- 命令模式

```帮助
`g>[行数]{方向}` - 使用单行注释对区域进行注释
`g>c` - 使用单行注释注释当前行
`g>b` - 使用多行注释注释当前行
`g<[行数]{方向}` - 使用单行注释取消该区域的注释
`g<c` - 使用单行注释取消当前行的注释
`g<b` - 使用多行注释取消当前行的注释
```

- 选择模式

```帮助
`g>` - 使用单行注释注释选择的区域
`g<` - 使用单行注释取消注释选择的区域
```

##### 例子 Examples

```帮助
# 单行注释

`gcw` - Toggle from the current cursor position to the next word
`gc$` - Toggle from the current cursor position to the end of line
`gc}` - Toggle until the next blank line
`gc5l` - Toggle 5 lines after the current cursor position
`gc8k` - Toggle 8 lines before the current cursor position
`gcip` - Toggle inside of paragraph
`gca}` - Toggle around curly brackets

# 多行注释

`gb2}` - Toggle until the 2 next blank line
`gbaf` - Toggle comment around a function (w/ LSP/treesitter support)
`gbac` - Toggle comment around a class (w/ LSP/treesitter support)
```

* 目前默认拓展模式(Extended mappings)未开启，需要开启可前往Comment.lua文件
* [官网](https://github.com/numToStr/Comment.nvim)
