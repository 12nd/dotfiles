"
" --------------
" James' vimrc
" --------------
"


"  ------------------------------------------------------------------------
"  Use vim-plug for plugin management!
"  :PlugInstall / :PlugUpdate for stuffs
"  ---------------------

if !has("nvim")
  set runtimepath+=~/.config/nvim
endif

" Auto download for new installs
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load/get the plugins
call plug#begin('~/.config/nvim/plugged')

" Colour scheme
Plug 'danilo-augusto/vim-afterglow'

" Some core things we want
Plug 'tpope/vim-commentary' " Commenting ('gcc')
Plug 'machakann/vim-sandwich' " Quoting
Plug 'tpope/vim-sleuth' " Indent autodetect

" Additional nice things
Plug 'nvim-lualine/lualine.nvim'
Plug 'junegunn/goyo.vim' " Nice centre thing
Plug 'ctrlpvim/ctrlp.vim' " Use ctrl+p for fuzzy files
Plug 'scrooloose/nerdtree' " File browsing
" Plug 'unblevable/quick-scope' " 420 noscope (press f)

" More heavy, IDE-like stuff
" Autocompletion + snippets (coc) - run the following:
"     - :CocInstall coc-python coc-bibtex coc-texlab coc-ultisnips
"Plug 'neoclide/coc.nvim', { 'branch': 'release' }
"Plug 'honza/vim-snippets' " The actual snippets


" Syntax stuff
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'kovetskiy/sxhkd-vim'
Plug 'lervag/vimtex'
Plug 'harenome/vim-mipssyntax'
call plug#end()



" -------------------------------------------------------------------------
"  Let's go!
"  ---------------------
"  Basics
let mapleader=","

set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber

set nohlsearch
set splitbelow splitright " why isn't this the default?
set scrolloff=6

"   Colour scheme
"   Always patch our overrides on scheme load
"   https://github.com/junegunn/goyo.vim/issues/84#issuecomment-156299446
function! s:transparent_bg_force()
  hi! Normal ctermbg=NONE guibg=NONE
  hi! LineNr ctermbg=NONE guibg=NONE
  hi! StatusLine ctermbg=NONE ctermfg=DarkCyan cterm=NONE
endfunction
autocmd! ColorScheme afterglow call s:transparent_bg_force()
colorscheme afterglow


"  Tabs - 4 wide
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4

"  Mouse - dont kill me pls
set mouse=a

"  Autowrites
autocmd BufWritePost *Xresources,*Xdefaults !xrdb -merge %



" ----------------------
"  Plugin config

"  Lua config
lua << END
require('lualine').setup{
  options = {
    theme = 'jellybeans',
    section_separators = '',
    component_separators = '|'
  }
}
END

"  nerdtree
map <leader>n :NERDTreeToggle<CR>

"  use vimtex latex
let g:tex_flavor = 'latex'

"  use vimsurround bindings with sandwich
runtime macros/sandwich/keymap/surround.vim

" ----------------------
"  Bindings
"  Fullscreen for prose
map <leader>f :Goyo \| set linebreak<CR>

" Jump to a placeholder character
map <leader><leader> <Esc>/<++><Enter>"_d4lzzi
nnoremap <leader><leader> <Esc>/<++><Enter>"_d4lzzi
inoremap <leader><leader> <Esc>/<++><Enter>"_d4lzzi

"  Splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"  Yank to end of line (no new line)
nnoremap Y y$

"  System clipboard management
"  Copy + paste
vnoremap <leader>c "+y
vnoremap <leader>x "*y
map <leader>v "+P

"  Paste mode
set pastetoggle=<F12>

"  Replace All
nnoremap S :%s//g<Left><Left>

"  Nice little helper for saving sudo when forget
cmap w!! w !sudo tee >/dev/null %

"  Read tex files properly
autocmd BufRead,BufNewFile *.tex set filetype=tex

"  Moving lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv



" ---------------------
"  Language specific 'Macros'

"  LaTeX
autocmd FileType tex nnoremap <F5> :w<Enter>:!latexmk<space>-pdf<space>-cd<space><c-r>%<Enter>
autocmd FileType tex nnoremap <S-F5> :w<Enter>:!latexmk<space>-xelatex<space><c-r>%<Enter>
autocmd FileType tex nnoremap <F4> :w<Enter>:!texliveonfly<space>--terminal_only<space>-c<space>latexmk<space>-a<space>'-pdf'<space>%<Enter>

"  Markdown
autocmd FileType markdown nnoremap <F5> :w<CR>:!pandoc<space>-i<space><c-r>%<space>-o<space>%:r.pdf<CR>

autocmd FileType tex,markdown nnoremap <F6> :!$READER<space>%:r.pdf<space>&<CR><CR>
