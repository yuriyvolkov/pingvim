"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/plugins/Vundle.vim
call vundle#begin('~/.vim/plugins')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'yuriyvolkov/vim-colorized'
Plugin 'altercation/vim-colors-solarized'

" navigation & search
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'majutsushi/tagbar'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'jeetsukumaran/vim-buffersaurus'
Plugin 'vim-scripts/IndexedSearch'
Plugin 'bling/vim-airline'

" syntax
Plugin 'scrooloose/syntastic'

" markup
Plugin 'tpope/vim-haml'
Plugin 'groenewege/vim-less'
Plugin 'ap/vim-css-color'

" git
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-fugitive'
Plugin 'int3/vim-extradite'
Plugin 'airblade/vim-gitgutter'

" speededit
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'vim-scripts/camelcasemotion'

"ruby & rails stuff
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-cucumber'

" Go
Plugin 'fatih/vim-go'

call vundle#end()

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

set nowrap      "dont wrap lines
set linebreak   "wrap lines at convenient points

"cursor & line numbers settings
set cursorline
set number

"indent settings
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

"folding settings
set foldmethod=syntax   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

"display tabs and trailing spaces
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

"hide buffers when not displayed
set hidden

if has("gui_running")
    "tell the term has 256 colors
    set t_Co=256

    set guioptions-=T  "remove toolbar
    set guifont=Ubuntu\ Mono:h12

    if has("gui_gnome")
        set term=gnome-256color
        colorscheme railscasts
    else
        colorscheme railscasts
        set guitablabel=%M%t
        set lines=39
        set columns=115
    endif
    if has("gui_mac") || has("gui_macvim")
        set guifont=Menlo:h15
    endif
else
    colorscheme xterm16
endif

let g:buffergator_viewport_split_policy="R"
let g:buffergator_autoexpand_on_split=0
let g:buffergator_split_size=90

"mark syntax errors with :signs
let g:syntastic_enable_signs=1

"ack setup for Debian/Ubuntu - comment this line out if u have ack binary in
"your system
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline_powerline_fonts = 1

"load ftplugins and indent files
filetype plugin on
filetype indent on

"turn on syntax highlighting
syntax on

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"define :HighlightLongLines command to highlight the offending parts of
"lines that are longer than the specified length (defaulting to 80)
command! -nargs=? HighlightLongLines call s:HighlightLongLines('<args>')
function! s:HighlightLongLines(width)
    let targetWidth = a:width != '' ? a:width : 79
    if targetWidth > 0
        exec 'match Todo /\%>' . (targetWidth) . 'v/'
    else
        echomsg "Usage: HighlightLongLines [natural number]"
    endif
endfunction

nmap <silent> <Leader>p :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map to buffergator
nnoremap <C-B> :BuffergatorToggle<cr>
"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

