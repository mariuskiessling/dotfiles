" -----------------------------------------------
" BASICS
" -----------------------------------------------

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

let mapleader="-"
let maplocalleader=","
nnoremap - <NOP>

set timeoutlen=200

" -----------------------------------------------
" UI
" -----------------------------------------------
" Enable line numbers
set number

" Hide startup message
set shortmess=at

" Turn on the Wild menu
set wildmenu

" Enable cursor line
set cursorline

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Setup indention
set expandtab
set shiftwidth=2
set softtabstop=2

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

set ttyfast

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

" Exit search using Enter key
nnoremap <CR> :noh<CR>

"------------------------------------------------
" EDITOR
"------------------------------------------------
" Enable relative line numbers in current buffer
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

map C y$
map D d$
map Cl 0y$

au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>r :GoRun main.go<CR>

au FileType markdown nmap <leader>c :execute "!pandoc " . expand('%:t:r') . ".md -o " . expand('%:t:r') . ".pdf --template phoenix && mupdf-gl " . expand('%:t:r') . ".pdf" <Enter><Enter>
au FileType markdown nmap <leader>cv :execute "mupdf-gl " . expand('%:t:r') . ".pdf" <Enter><Enter>
au FileType markdown nmap <leader>cL :execute "!pandoc " . expand('%:t:r') . ".md -o " . expand('%:t:r') . ".pdf --template letter && mupdf-gl " . expand('%:t:r') . ".pdf" <Enter><Enter>
au FileType markdown nmap <leader>cp :execute "!lpr -P HP_OfficeJet_6950 '" . % . "' && open /Users/marius/Library/Printers/AS-Drucker-Buero.app" <Enter>

au FileType markdown nmap <leader>\| gaip\|<Enter>

"------------------------------------------------
" TEXT
"------------------------------------------------
" Enable syntax highlighting
syntax enable

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

set background=light

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"------------------------------------------------
" Plugins
"------------------------------------------------
call plug#begin('~/.vim/plugged')

" => Utility
Plug 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>

Plug 'ctrlpvim/ctrlp.vim'

Plug 'scrooloose/nerdcommenter'

Plug 'vim-syntastic/syntastic'
let g:syntastic_go_checkers = ['golint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" => Markdown / Writing stuff
Plug 'reedes/vim-pencil'
let g:pencil#textwidth = 80
let g:airline_section_x = '%{PencilMode()}'
let g:pencil#autoformat_config = {
  \   'markdown': {
  \     'black': [
  \       'htmlH[0-9]',
  \       'markdown(Code|H[0-9]|Url|IdDeclaration|Link|Rule|Highlight[A-Za-z0-9]+)',
  \       'markdown(FencedCodeBlock|InlineCode)',
  \       'mkd(Code|Rule|Delimiter|Link|ListItem|IndentCode)',
  \       'mmdTable[A-Za-z0-9]*',
  \     ]
  \   },
  \ }

Plug 'mattly/vim-markdown-enhancements'

Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

" Workaround: Error message with python 3 and ultisnips
if has('python3')
  silent! python3 1
endif

" => Editor
Plug 'tpope/vim-surround'

Plug 'alvan/vim-closetag'

Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1

" => Version control
Plug 'tpope/vim-fugitive'

" => Language support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=2 shiftwidth=2
let g:go_fmt_command = "goimports"

Plug 'leafgarland/typescript-vim'

Plug 'lervag/vimtex'
let g:vimtex_view_general_viewer='mupdf-gl'
let g:tex_flavor = "latex"

" => User Interface
Plug 'sonph/onehalf', {'rtp': 'vim'}
colorscheme onehalflight
let g:airline_theme='onehalfdark'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

