" General Config
" ----------------------------
let mapleader = ";"

set shell=zsh " Set bash as the prompt for Vim
set encoding=utf-8
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set noshowmode
set timeoutlen=1000
set ttimeoutlen=0
set tabstop=4
set shiftwidth=4
set softtabstop=4
" set shiftround
set expandtab
set scrolloff=15
set list listchars=tab:»·,trail:·  " Display extra whitespace characters
set hidden

" Line numbers
set number

" Highlight search matches
set hlsearch

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Tab Shortcuts
nnoremap tn :tabnext<CR>
nnoremap tp :tabprev<CR>
nnoremap <leader>t :tabnew<CR>
"nnoremap tc :CtrlSpaceTabLabel<CR>
nnoremap td :tabclose<CR>

" Buffer Shortcuts
nnoremap bn :bnext<CR>
nnoremap bp :bprevious<CR>
nnoremap bd :bdelete<CR>
nnoremap bs :buffers<CR>

" MacVim use clipboard contents
set clipboard=unnamed

" Remove newbie crutches in Command Mode
cnoremap <Down> <Nop>
cnoremap <Left> <Nop>
cnoremap <Right> <Nop>
cnoremap <Up> <Nop>

" Remove newbie crutches in Insert Mode
imap <Down> <Nop>
imap <Left> <Nop>
imap <Right> <Nop>
imap <Up> <Nop>

" Remove newbie crutches in Normal Mode
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>

" Remove newbie crutches in Visual Mode
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>

" NERDTree
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeChDirMode  = 2
let NERDTreeShowHidden = 1
let NERDTreeWinSize = 50
noremap <space>t :NERDTreeFind<CR>zz
noremap <silent><F4> :NERDTreeToggle<CR>

" Autocommands
" --------------------------
if has("autocmd")
  " Automatically clean trailing whitespace
  autocmd BufWritePre * :%s/\s\+$//e

  autocmd BufRead,BufNewFile *.md set filetype=markdown

  autocmd BufRead,BufNewFile .eslintrc,.jscsrc,.jshintrc,.babelrc set ft=json

  autocmd BufRead,BufNewFile gitconfig set ft=.gitconfig

  " set filetypes as typescriptreact
  autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
endif

set nocompatible

" Airline
let g:airline_powerline_fonts = 1 " Enable the patched Powerline fonts
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.colnr = ' ℅:'

syntax enable

" Source Vim configuration file and install plugins
nnoremap <silent><F5> :source ~/.config/nvim/init.vim \| :PlugInstall<CR>

" Coc setup
let g:coc_global_extensions = ['coc-tsserver', 'coc-emmet', 'coc-git', 'coc-lists', 'coc-snippets', 'coc-html', 'coc-tsserver', 'coc-jest', 'coc-eslint',
            \ 'coc-css', 'coc-json', 'coc-prettier', 'coc-explorer', 'coc-sql']

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> U <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap keys for applying codeAction to the current line.
nmap <space>c  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <space>qf  <Plug>(coc-fix-current)

:nmap <space>e :CocCommand explorer<CR>

" Run the Code Lens action on the current line.
nmap <leader>l  <Plug>(coc-codelens-action)

" Remap for rename current word
nmap <leader>R <Plug>(coc-rename)
nmap <leader>r <Plug>(coc-refactor)

" Remap for format selected region
xmap ==  <Plug>(coc-format-selected)
nmap ==  <Plug>(coc-format)

" select inside function and all function
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)

omap af <Plug>(coc-funcobj-a)
xmap af <Plug>(coc-funcobj-a)

" select inside class/struct/interface and all function
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)

xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <space>l  <Plug>(coc-codeaction-selected)
" Remap for do codeAction of current line
nmap <space>l  <Plug>(coc-codeaction)

nnoremap <silent> <space>1 :call CocAction('runCommand', 'eslint.executeAutofix')<CR>

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>s  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>o  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" CtrlSF
let g:ctrlsf_ackprg = 'rg'
let g:ctrlsf_auto_focus = {
    \ "at" : "start"
    \ }

noremap <leader>w :CtrlSF<space>
noremap <space>w :CtrlSFOpen<CR><space>

" Git
nnoremap gM :Gvsplit origin/master:%<cr>
nnoremap gm :Gvdiffsplit origin/master:%<cr>
nnoremap gD :Gvdiffsplit<cr>
nnoremap gb :G blame<cr>
vnoremap gb :GBrowse<cr>
noremap <leader>g :G<CR>
noremap <leader>g<space> :G<space>
noremap <leader>gg :G<CR><c-w>H
noremap <leader>gp :G pull
noremap <leader>gs :G push
noremap <leader>gf :G fetch

nmap <leader>h <Plug>(GitGutterPreviewHunk)
nmap <leader>x <Plug>(GitGutterUndoHunk)
nmap <leader>v <Plug>(GitGutterStageHunk)

" Specify plugins
" ----------------------------
call plug#begin('~/.vim/plugged')

" UI
" Plug 'trevordmiller/nova-vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'            " Handy info
" Plug 'ryanoasis/vim-webdevicons'
" Plug 'junegunn/goyo.vim'

" Project Navigation
Plug 'dyng/ctrlsf.vim'

" File Navigation
Plug 'preservim/nerdtree'
Plug 'vim-scripts/matchit.zip'  " More powerful % matching
Plug 'Lokaltog/vim-easymotion'  " Move like the wind!
Plug 'jeffkreeftmeijer/vim-numbertoggle'  " Smarter line numbers
Plug 'wellle/targets.vim'
" Plug 'kshenoy/vim-signature'
Plug 'haya14busa/incsearch.vim'           " Better search highlighting

" Editing
Plug 'tpope/vim-surround'   " Change word surroundings
Plug 'tpope/vim-repeat'
Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter'
Plug 'jasonlong/vim-textobj-css'
Plug 'editorconfig/editorconfig-vim'

" Git
Plug 'tpope/vim-fugitive'          " :Gblame
Plug 'airblade/vim-gitgutter'

" Language Support
" 1. JavaScript
" Plug 'pangloss/vim-javascript'    " JavaScript support
" Plug 'leafgarland/typescript-vim' " TypeScript syntax
" Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
" Plug 'jparise/vim-graphql'        " GraphQL syntax

" 2. HTML
Plug 'othree/html5.vim'
Plug 'mattn/emmet-vim'

" 3. CSS
Plug 'hail2u/vim-css3-syntax',  { 'for': 'css' }

" 4. Python
" Plug 'klen/python-mode',    { 'for': 'python' }
" Plug 'davidhalter/jedi-vim',              { 'for': 'python' }
" Plug 'alfredodeza/pytest.vim', { 'for': 'python' }

" 5. Go
" Plug 'fatih/vim-go'
" Plug 'nsf/gocode',  { 'rtp': 'nvim', 'do': './nvim/symlink.sh' }
" Plug 'zchee/deoplete-go'

" Markdown
Plug 'reedes/vim-pencil'    " Markdown, Writing
Plug 'godlygeek/tabular',   { 'for': 'markdown' } " Needed for vim-markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" Theme
set termguicolors
colorscheme gruvbox
set background=dark

