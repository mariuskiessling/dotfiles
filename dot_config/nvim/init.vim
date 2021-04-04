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

map Y y$
map D d$
map Cl 0y$

" Enable folds based on syntax
set foldmethod=syntax
" Unfold all folds in new buffers
au BufWinEnter * normal zR

au FileType go nmap <leader>b <Plug>(go-build)
"au FileType go nmap <leader>r :GoRun main.go<CR>
au FileType go nmap <leader>r <Plug>(go-run)

au FileType markdown nmap <leader>c :execute "!pandoc " . expand('%:t:r') . ".md -o " . expand('%:t:r') . ".pdf --template phoenix && zathura " . expand('%:t:r') . ".pdf" <Enter><Enter>
au FileType markdown nmap <leader>cv :execute "zathura " . expand('%:t:r') . ".pdf" <Enter><Enter>
au FileType markdown nmap <leader>cL :execute "!pandoc " . expand('%:t:r') . ".md -o " . expand('%:t:r') . ".pdf --template letter && mupdf-gl " . expand('%:t:r') . ".pdf" <Enter><Enter>
au FileType markdown nmap <leader>cp :execute "!lpr -P HP_OfficeJet_6950 '" . % . "' && open /Users/marius/Library/Printers/AS-Drucker-Buero.app" <Enter>

au FileType markdown nmap <leader>\| gaip\|<Enter>

map <leader>of :execute "!open ."<ENTER><ENTER>

" Map ESC to exit of terminal mode
tnoremap <Esc> <C-\><C-n>

" Easier help movements
"nnoremap <buffer> <CR> <C-]>
"nnoremap <buffer> <BS> <C-T>
"nnoremap <buffer> o /'\l\{2,\}'<CR>
"nnoremap <buffer> O ?'\l\{2,\}'<CR>
"nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>
"nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>

nmap <leader>ve :tabe ~/.config/nvim/init.vim<Enter>
nmap <leader>vr :so ~/.config/nvim/init.vim<Enter>
nmap <silent> <leader>an :ALENext<cr>
nmap <silent> <leader>ap :ALEPrevious<cr>

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

autocmd FileType typescript setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType html setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType scss setlocal expandtab shiftwidth=4 softtabstop=4

"------------------------------------------------
" Plugins
"------------------------------------------------
call plug#begin('~/.vim/plugged')

" => Utility
Plug 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,*.acn,*.aux,*.bbl,*.bcf,*.blg,*.fdb_latexmk,*.fls,*.glo,*.ist,*.lof,*.lol,*.lot,*.run.xml,*.synctex.gz,*.toc
let NERDTreeRespectWildIgnore=1

"Plug 'ctrlpvim/ctrlp.vim'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
nnoremap <C-p> :<C-u>Clap files<CR>

Plug 'scrooloose/nerdcommenter'

Plug 'vim-syntastic/syntastic'
let g:syntastic_tex_checkers = ['']
let g:syntastic_go_checkers = ['golint']
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_javascript_standard_generic = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" => Markdown / Writing stuff
Plug 'mattly/vim-markdown-enhancements'

Plug 'w0rp/ale'
let g:ale_linters = {
            \   'mail': ['proselint'],
            \   'markdown': ['proselint'],
            \   'text': ['proselint'],
            \   'latex': ['proselint'],
            \   'go': ['gopls'],
            \   }
let g:ale_fixers = [
            \   'trim_whitespace',
            \]
let g:ale_sign_warning = '⚠'
let g:ale_sign_error = '⨉'

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
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gr :Gpush<CR>

" => Language support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=2 shiftwidth=2
let g:go_fmt_command = "goimports"
let g:go_term_enabled = 1
let g:go_term_mode = "split"
let g:go_term_height = 13
let g:go_fmt_command = "goimports"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

Plug 'leafgarland/typescript-vim'

" => LaTeX support
Plug 'lervag/vimtex'
let g:vimtex_view_general_viewer='zathura'
let g:vimtex_fold_enabled = 0
let g:vimtex_view_method = "zathura"
let g:vimtex_view_zathura_hook_callback = 'ZathuraReloadOnCompile'
"function! ZathuraReloadOnCompile() dict
  "call self.xwin_send_keys('R')
"endfunction
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-pdflatex="pdflatex --shell-escape %O %S"',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ]
    \}
let g:tex_flavor = "latex"

" => User Interface
Plug 'NLKNguyen/papercolor-theme'
set t_Co=256
set background=light
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default': {
  \       'allow_bold': 1,
  \       'allow_italic': 1
  \     }
  \   }
  \ }

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='papercolor'

Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
nnoremap <leader>fa :FlutterRun<cr>
nnoremap <leader>fq :FlutterQuit<cr>
nnoremap <leader>fr :FlutterHotReload<cr>
nnoremap <leader>fR :FlutterHotRestart<cr>

Plug 'rodjek/vim-puppet'

Plug 'liuchengxu/vista.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug '/usr/local/opt/fzf'

Plug 'Chiel92/vim-autoformat'

Plug 'davewongillies/vim-eyaml'

Plug 'tpope/vim-jdaddy'

Plug 'habamax/vim-asciidoctor'

Plug 'godlygeek/tabular'

Plug 'jodosha/vim-godebug'

Plug 'posva/vim-vue'

Plug 'rhysd/vim-go-impl'

call plug#end()

colorscheme PaperColor
