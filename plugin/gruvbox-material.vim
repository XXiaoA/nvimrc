if has('termguicolors')
  set termguicolors
endif
set background=dark

" option: hard, medium, soft
let g:gruvbox_material_background = 'hard'

" options: 'grey background', 'green background', 'blue background', 'red background', 'reverse'
let g:gruvbox_material_visual = 'blue background'

let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_enable_italic = 1
" let g:gruvbox_material_transparent_background = 1

" option: 'default' 'mix' 'original'
let g:gruvbox_material_statusline_style = 'mix'

" option: 'material' 'mix' 'original'
let g:gruvbox_material_palette = 'original'

colorscheme gruvbox-material
