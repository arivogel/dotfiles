" look in the .vim directory for vim files
set runtimepath=~/.vim,$VIMRUNTIME

" set variables needed for 256 color
set term=xterm-256color

" use the solarized color scheme
syntax enable
"let g:solarized_termcolors=256
set background=dark
colorscheme solarized


" put line numbers
set number

" change color of gutter
":highlight LineNr ctermbg=55

" set tab to be two spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
