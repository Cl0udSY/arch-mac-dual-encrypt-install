syntax enable
set tabstop=4
set shiftwidth=4
filetype on
"set nu

"Set autoindent
set autoindent
set smartindent
"set expandtab
filetype plugin indent on

command! Fsw execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Git functions

function! GitBranch()
	return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
	let l:branchname = GitBranch()
	return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

" Test added command
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set mouse=""		" Disable mouse usage (all modes)
set viminfo=""

"---
" show status bar
" (get highlight group: so $VIMRUNTIME/syntax/hitest.vim)
"---
set ruler
hi StatusLine ctermbg=white ctermfg=24
set laststatus=2 "always show status line
set statusline=
"set statusline+=%#Folded#
"set statusline+=%{StatuslineGit()}
"set statusline+=%#StatusLine#
set statusline+=\ %([dec\ =\ %b]\ [hex\ =\ \%02.2B]%)
set statusline+=%=
set statusline+=%f%m%r%h%w\ \ 
set statusline+=[%L]\ [%p%%]\ \ %04l:%04v





"---
" tell us when anything was changed by : <cmd>
"---
set report=0

"---
"remove error bell
"---
set noerrorbells
set t_vb=
set visualbell

"---
" show typed commnd in lower right corner (cmd's, selection length, etc)
"---
set showcmd

"---
" search stuff
"---
set incsearch
set hlsearch
set noignorecase
"set ignorecase
set magic "extended regexes

"---
" highlight cursor line and column
"---
hi CursorLine   cterm=NONE ctermbg=8 " ctermfg=white
hi CursorColumn cterm=NONE ctermbg=8 " ctermfg=white
set cursorline
"set cursorcolumn


"---
" linenumbering on / off
"---
set number
noremap  <F2> :set nonumber!<CR>
inoremap <F2> <ESC>:set nonumber!<CR>i

"
"----------------------------------( python )
"
" enable all Python syntax highlighting features
let python_highlight_all = 1

"
"----------------------------------( yaml )
"
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" 80 column delimitation
"highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
"match OverLength /\%81v.\+/
highlight ColorColumn ctermbg=1
set colorcolumn=81
"highlight ColorColumn ctermbg=0
"execute "set colorcolumn=" . join(range(81,335), ',')
