"map jk to <ESC> to make it more convenient"
inoremap jk <ESC>

nn <C-i> <C-a>
nn <C-k> <C-x>
nmap <down> <nop>
nmap <left> <nop>
nmap <right> <nop>
nmap <up> <nop>
set number

" uses space instead of tab, use 'Ctrl-V <Tab>' to force tab"
set expandtab
" ts = tab stop = num spaces to use in place of tab
" sw = shiftwidth = numspaces to use when audo-indenting (with < > or on
" enter)
set ts=4 sw=4
:so ~/.vim/plugins/cscope_maps.vim

map <f12> :!start /min ctags -F .<cr>

"map oo and OO to insert newlines without going into insert mode"
nmap oo o<Esc>k
nmap OO O<Esc>j

"Map <SOMETHING> to load selected text to tmux buffer to paste into another
"vim session (across panes), not yet working. look into misc chat outlook folder"
vmap ty :'<,'>w !tmux load-buffer -<ENTER>

"map <something> to count the number of matches with the currently searched pattern"
map cm :%s///gn <CR>

fu! ShowWhitespace()
    :highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
    :match ExtraWhitespace /\s\+$/
endfunction

"fu! ToTab()
"    :%s/\(^\s*\)\@<=    /\t/g
"endfunction

"Check for buffer changes while in a file (open from another window)"
":WatchForChanges"

"Turn on syntax highlighting (this is for red hat)
:syntax on
filetype plugin indent on

"Configs from old vimrc:
"set runtimepath=~/.vim,$VIMRUNTIME
"set term=xterm-256color
"execute pathogen#infect()
"syntax enable
"set background=dark
"colorscheme solarized
"

" Pathogen setup
"filetype on
"call pathogen#infect()
"call pathogen#helptags()

"let g:pymod_folding = 0
"

"use 4 space tabs
:map <F3> :se ts=8\|se sw=4\|se expandtab\|se softtabstop=4<CR>
"8 column tabs, tab indent
:map <F4> :se ts=8\|se sw=8\|se noexpandtab\|se softtabstop=8<CR>

" Tab setting examples from: http://tedlogan.com/techblog3.html
" Tabs are eight columns wide, each indentation level is one tab
" :set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
"
" Tabs are four columns wide, each indentation level is one tab
" :set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
"
" Each indentation level is four spaces, no tabs
" :set softtabstop=4 shiftwidth=4 expandtab

"
"Settings for window operations to act like my tmux settings
" Window prefix it 'ctrl+w'
" <prefix> \ splits vertically
" <prefix> " splits horizontally
" <prefix> x quits the current window
" <prefix> z full screens window
" <prefix> [hjkl] move between windows
" other default settings: http://vimcasts.org/episodes/working-with-windows/
:map <C-W>\ <C-W>v
:map <C-W>" <C-W>s
:map <C-W>x <C-W>q
" This last one to maximize properl doesn't work yet
":map <C-W>z <C-W>_ <CR><C-W>|
:set mousefocus

" Wildcard tab completion settings,
set wildmode=longest,list,full
set wildmenu

" clear search highlight
:map <F8> :nohls<CR>
:imap <F8> :nohls<CR>
