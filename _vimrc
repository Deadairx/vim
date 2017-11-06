" Plugins: {{{
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim' "Colorful status bar

Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-sleuth'
Plug 'scrooloose/syntastic'
Plug 'kshenoy/vim-signature'
Plug 'airblade/vim-gitgutter'

Plug 'vim-scripts/dbext.vim' "SQL Connection

Plug 'tpope/vim-dispatch', { 'for': 'cs' }
Plug 'OrangeT/vim-csharp', { 'for': 'cs' }
Plug 'PProvost/vim-ps1',   { 'for': 'ps1' }
Plug 'chrisbra/csv.vim',   { 'for': 'csv' }
Plug 'keith/swift.vim',    { 'for': 'swift' }
Plug 'rust-lang/rust.vim', { 'for': 'rust'  }
Plug 'cespare/vim-toml',   { 'for': 'toml'  }
Plug 'etdev/vim-hexcolor', { 'for': 'css' }
Plug 'kurocode25/mdforvim', { 'for': 'markdown' }
Plug 'myhere/vim-nodejs-complete', { 'for': 'javascript' }

" Colors
Plug 'altercation/vim-colors-solarized' "Colortheme
Plug 'morhetz/gruvbox'

Plug 'bling/vim-bufferline' "Show open buffers
call plug#end()

scriptencoding utf-8

syntax on
filetype plugin on
filetype plugin indent on
"}}}
" Sets: {{{
set nobomb
set so=5
"set lazyredraw
set synmaxcol=800
set title
set listchars=trail:·,tab:»\ ,extends:>,precedes:\<
set nowrap
set nu
set rnu
set laststatus=2
set backspace=indent,eol,start
set ignorecase
set smartcase
set incsearch
set splitright
set splitbelow
set cursorline 
set fillchars=vert:│,fold:─
set wildmode=longest,list,full
set wildmenu
set noshowmode "hides '--INSERT--' since lightline shows it
set encoding=utf-8 "display Unicode
set background=dark
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

" Folding
if @% =~# 'vimrc'
	set foldmethod=marker
	set foldlevel=0
	set foldlevelstart=0
else
	set foldmethod=indent
	set foldlevel=2
endif

set foldnestmax=10
set nofoldenable

set go-=m "remove menu bar
set go-=T "remove toolbar
set go-=r "remove right-hand scroll
set go-=L "remove left-hand scroll

" Cursor Block for cygwin
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
cabbrev ~? ~/
cabbrev 5s %s
"}}}
" Mapings: {{{
let mapleader = ","

" Edit vimrc
nmap <leader>v :tabedit $MYVIMRC<CR>
" Load vimrc
nmap <leader>vs :so $MYVIMRC<CR>

" }}}
" Functions: {{{
function! DeleteHiddenBuffers()
  let tpbl = []
  let nClosed = 0
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')

  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val) == -1')
    if getbufvar(buf, '&mod') == 0
      silent execute 'bwipeout' buf
      let nClosed += 1
    endif
  endfor

  if nClosed > 0
    echo "Closed " . nClosed . " hidden buffers."
  else
    redraw!
  endif
endfunction

function! DeleteStringLead()
	" Delete beginning of string that has a '_' in it
	normal! yy
	if @" =~ "_"
		execute ":s/\"\a*_/\"/"
	endif
endfunction

"if exists('*OpenInBrowser')
"  nnoremap <leader>w :call OpenInBrowser()<cr>
"endif

function! TidyCurrent()
  :!tidy -m -wrap 0 %
endfunction

nnoremap <leader>t :call TidyCurrent()<cr>

function! WhatIsMyLeaderKey()
  :echo 'Map leader is' (exists('g:mapleader')? g:mapleader : '\')
endfunction

function! SynStack()
  if !exists('*synstack')
    return
  endif

  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

if exists('*SynStack')
  nmap <leader>s :call SynStack()<cr>
endif

function! GetCurrentByteOffset()
  echo eval(line2byte(line("."))+col(".")-1)
endfunction

"function! LintVimrc()
"  call vimlint#vimlint($MYVIMRC, {'output': 'quickfix'})
"  source $MYVIMRC
"endfunction
"}}}
" Colorscheme: {{{
"colorscheme darkblue
colorscheme solarized
let g:solarized_italic=0
let g:lightline = { 'colorscheme': 'solarized',} "must come after theme options...no idea why...
"}}}
" SQL {{{
" SQL Server
let g:dbext_default_profile_local = 'type=SQLSRV:user=vim:passwd=qjkCTW4!:host=localhost:dbname=vimDB'
"}}}
