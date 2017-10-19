set nocompatible

" Colors {{{
colorscheme default " can replace with solarized as well
syntax enable       " enable syntax processing

" }}}
" Spaces & Tabs {{{
set expandtab       " tabs are spaces
set copyindent      " copy the previous indentation on autoindenting
set shiftwidth=2            " Number of spaces to shift for autoindent or >,<
set softtabstop=2           " Spaces 'feel' like tabs
set tabstop=2               " The One True Tab

" }}}
" UI Layout {{{
set number              " show line numbers
set ruler               " Show row/col and percentage
set notitle             " Don't set the title of the Vim window
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
filetype indent on      " load filetype-specific indent files

set wildmenu            " visual autocomplete for command menu
set wildmode=list:longest,full " List all options and complete
set lazyredraw          " redraw only when we need to.
set ttyfast             " Send more characters for redraws

set textwidth=120           " 120 is the new 80
set scroll=4                " Number of lines to scroll with ^U/^D
set scrolloff=15            " Keep cursor away from this many chars top/bot
set sidescrolloff=3         " Keep cursor away from this many chars left/right
set sessionoptions-=options " Don't save runtimepath in Vim session (see tpope/vim-pathogen docs)
set shiftround              " Shift to certain columns, not just n spaces
set shortmess+=A            " Don't bother me when a swapfile exists
set showbreak=              " Show for lines that have been wrapped, like Emacs
set showmatch               " Hilight matching braces/parens/etc.

" GitGutter styling to use · instead of +/-
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'
" }}}
" Mouse {{{
set mouse=a             " enable mouse for all modes
set ttymouse=xterm2

" }}}
" Clipboard {{{
set clipboard=unnamed   " use the system clipboard
" }}}
" Search {{{
set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

set smartcase               " Lets you search for ALL CAPS
set suffixes+=.pyc          " Ignore these files when tab-completing
set wildignore=*.class,*.o,*~,*.pyc,.git,node_modules  " Ignore certain files in tab-completion

" FZF (replaces Ctrl-P, FuzzyFinder and Command-T)
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
nmap ; :Buffers<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>a :Ag<CR>

" highlight last inserted text
nnoremap gV `[v`]

" }}}
" Fold {{{
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
nnoremap <space> za     " space open/closes folds
set foldmethod=indent   " fold based on indent level

" }}}
" Key Bindings {{{

nmap \e :NERDTreeToggle<CR>

" Use Ctrl+e to open a new editor buffer and then Ctrl+n/p to switch buffers
nmap <C-e> :e#<CR>
" Move between open buffers.
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" Emacs-like bindings in insert mode
imap <C-e> <C-o>$
imap <C-a> <C-o>0

" For any plugins that use this, make their keymappings use comma
let mapleader = ","
let maplocalleader = ","
inoremap jk <esc>       " jk is escape

set backspace=2 " make backspaces work like most other apps

" }}}
" AutoGroups {{{

augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END

" }}}
" Backups {{{
" move backups to /tmp
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}
" Custom Functions {{{

" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" Use `sudo` to save this file
cmap w!! w !sudo tee % >/dev/null

" }}}
" Typos {{{
iabbrev operatino operation
iabbrev adn and
" }}}

set modelines=1
" vim:foldmethod=marker:foldlevel=0
