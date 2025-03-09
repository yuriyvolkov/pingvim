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

Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-endwise'

" Javascript & Coffee
Plugin 'elzr/vim-json'

" C++
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'kana/vim-operator-user' "required for vim-clang-format
Plugin 'rhysd/vim-clang-format'
Plugin 'justmao945/vim-clang'
Plugin 'vim-scripts/a.vim'

" Go
Plugin 'fatih/vim-go'
Plugin 'buoto/gotests-vim'

" git
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-fugitive'
Plugin 'int3/vim-extradite'
Plugin 'airblade/vim-gitgutter'

" navigation & search
Plugin 'rking/ag.vim'
Plugin 'vim-scripts/IndexedSearch'
Plugin 'bling/vim-airline'
Plugin 'Konfekt/FastFold'
Plugin 'Konfekt/FoldText'
Plugin 'majutsushi/tagbar'

" Unite & friends
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neomru.vim'
Plugin 'Shougo/unite-outline'
Plugin 'Shougo/vimfiler.vim'

" syntax
Plugin 'scrooloose/syntastic'

" speededit
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'vim-scripts/camelcasemotion'
Plugin 'terryma/vim-multiple-cursors'


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
set colorcolumn=120
set number

"indent settings
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
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

set laststatus=2

set nobackup
set nowritebackup
set noswapfile

" Colorscheme
set t_Co=256 "tell the term has 256 colors
set background=dark
colorscheme  slate

let g:go_fmt_command = "goimports"
"
"Syntastic syntax checker
let g:syntastic_enable_signs=1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" let g:syntastic_always_populate_loc_list = 0
" let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_cpp_checkers = ['clang_tidy']
let g:syntastic_aggregate_errors = 1
let g:syntastic_c_clang_tidy_post_args = "-p=./build/"
let g:syntastic_cpp_clang_tidy_post_args = "-p=./build/"
let g:syntastic_enable_balloons = 1
let g:syntastic_error_symbol = "E"
let g:syntastic_warning_symbol = "W"


"Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline_powerline_fonts = 1

"load ftplugins and indent files
filetype plugin indent on

"turn on syntax highlighting
syntax on
let mapleader = "\<Space>"

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

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

"make <c-l> clear the highlight as well as redraw
nnoremap <Leader>h :nohls<CR>

" Unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <Leader>o :Unite file_rec/async<CR>
nnoremap <Leader>b :Unite -quick-match buffer<CR>

" FILE EXPLORER
nnoremap <expr><C-o> g:My_open_explorer_command()
function! g:My_open_explorer_command()
    return printf(":\<C-u>VimFilerBufferDir -buffer-name=%s -split -toggle -no-quit -winwidth=%s\<CR>",
                \ g:my_vimfiler_explorer_name,
                \ g:my_vimfiler_winwidth)
endfunction
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_marked_file_icon = '✓'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'
let g:vimfiler_readonly_file_icon = '!'
let g:my_vimfiler_explorer_name = 'explorer'
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_directory_display_top = 1
let g:my_vimfiler_winwidth = 60
" /FILEXPLORER

" Ag/grep
if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
    let g:ag_prg="ag --column"
endif
nnoremap <Leader>g :Ag 

" save files with Leader+w
nnoremap <Leader>w :w<CR>

" Copy & paste to system clipboard with <Space>p and <Space>y:
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Unite yank history
let g:unite_source_history_yank_enable = 1
nnoremap <Leader>y :Unite history/yank<cr>

" T-comment mappings
vmap <Leader>c gc
nmap <Leader>c gcc

" Fireplace mappings
nmap <Leader>e :%Eval<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_width = 60

" a.vim mappings
map <Leader>h :A<CR>
map <Leader>s :AS<CR>
map <Leader>v :AV<CR>
map <Leader>t :AT<CR>

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>f :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>f :ClangFormat<CR>

" vim-clang
" disable auto completion for vim-clang
let g:clang_auto = 0
" default 'longest' can not work with neocomplete
let g:clang_c_completeopt = 'menuone'
let g:clang_cpp_completeopt = 'menuone'
let g:clang_c_options = '-std=gnu11'
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
" clang-format in vim-clang plugin
let g:clang_enable_format_command = 0

" vim-clang-format
let g:clang_format#detect_style_file = 1
