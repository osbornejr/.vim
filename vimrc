"plugin management with vim-plug (auto-installs if necessary)
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Newly added plugins must be installed using :PlugInstall
call plug#begin()

"info bar at bottom
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

"Dispatch asyncronously
Plug 'tpope/vim-dispatch'

"Git integration
Plug 'tpope/vim-fugitive'

"filetree
Plug 'preservim/nerdtree'

"vim features
Plug 'lervag/vimtex'

"Github integration
Plug 'tpope/vim-rhubarb'

"add generic REPLS via :terminal command
"Plug 'williamjameshandley/vimteractive'

"type closing characters automatically
"Plug 'jiangmiao/auto-pairs'

"automatically create new directories on save
Plug 'arp242/auto_mkdir2.vim'

"syntax and autocomplete for julia
"using fork for now (cant remember why)
"Plug 'JuliaEditorSupport/julia-vim'
Plug 'cmcaine/julia-vim'

"send julia cells to terminal
"Plug 'mroavi/vim-julia-cell', { 'for': 'julia' }

"send information to terminal
Plug 'jpalardy/vim-slime'

"edit surrounding characters
"Plug 'tpope/vim-surround'

call plug#end()


"let s:VIMROOT = $HOME."/.vim"

" Create necessary folders if they don't already exist.
"if exists("*mkdir")
"    silent! call mkdir(s:VIMROOT, "p")
"    silent! call mkdir(s:VIMROOT."/swap", "p")
"    silent! call mkdir(s:VIMROOT."/undo", "p")
"    silent! call mkdir(s:VIMROOT."/backup", "p")
"else
"    echo "Error: Create the directories ".s:VIMROOT."/, ".s:VIMROOT."/undo/," ".s:VIMROOT."/backup/, and ".s:VIMROOT."/swap/first."
"    exit
"endif

"setup global directories for backups, swapfiles and undo history
"set backupdir=~/.vim/backup//
"set directory=~/.vim/swap//
"set undofile 
"set undodir=~/.vim/undo//

"set persistent undo
set undolevels=1000
set undoreload=10000

"airline config
"let g:airline_theme='term'


"slime config
let g:slime_target = 'vimterminal'
"let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
"let g:slime_dont_ask_default = 1
let g:slime_vimterminal_cmd ="make run"
let g:slime_vimterminal_config = { "vertical": 1 }
let g:slime_no_mappings = 1
xmap <c-s><c-s> <Plug>SlimeRegionSend
nmap <c-s><c-s> <Plug>SlimeLineSend
nmap <c-s><c-p> <Plug>SlimeParagraphSend
nmap <c-s><c-r> :SlimeSend1 Rscript -e "rmarkdown::render('presentation.Rmd')"<cr><c-w><c-w><cr><c-w><c-w>
"nmap <c-s><c-a> ggVG<Plug>SlimeRegionSend<c-O><c-O>
nmap <c-s><c-e> kVgg<SlimeRegionSend<c-O><c-O>
nmap <c-s><c-d> VG<SlimeRegionSend<c-O><c-O>
nmap <c-s><c-a> :%SlimeSend<cr>
nmap <c-s><c-i> :SlimeSend0 'include("'.expand('%').'")'<cr><c-w><c-w><cr><c-w><c-w>
nmap <c-s><c-w> <Esc>:w<cr>:SlimeSend0 'weave("'.expand('%').'",doctype = "md2html",cache=:all)'<cr>:sbuf repl <cr><cr><c-w>c
nmap <c-s><c-w>c :SlimeSend0 'weave("'.expand('%').'",doctype = "md2html",cache = :user)'<cr><c-w><c-w><cr><c-w><c-w>
nmap <c-s><c-t> :SlimeSend0 '@time '.getline(".") <cr><c-w><c-w><cr><c-w><c-w>
nmap <c-s>s     <Plug>SlimeConfig
"Julia cell config
let g:julia_cell_delimit_cells_by = 'tags'

"latex-vim specific: compile latex document to pdf preview
"set global mark on root tex file
nnoremap <LocalLeader>L mL:w<CR> :Dispatch! latexmk -pdf -pv -halt-on-error % && osascript -e 'activate application "kitty"';<CR>
nnoremap <LocalLeader>l mP:w<CR>`L :Dispatch! latexmk -pdf -pv -halt-on-error % && osascript -e 'activate application "kitty"';<CR>`P
"julia-vim specific: navigate to new git pane (under terminal side)
"nmap <c-g> 9<c-w><c-w><Esc><Esc>:sbuf git<cr>i

"shortcut to bring up :sbuf (mainly for terminals)
map <c-w><c-t> <C-W>b <C-w>:split 
tnoremap <c-w><c-t> <C-W>b <C-w>:split 
"window navigation from terminal clears line
tnoremap <c-w><c-w> <c-e><c-u><c-w><c-w>
"yank text from terminal line on switch window
tnoremap <c-y><c-w> <C-\><C-n>0f>llv$yi<c-e><c-u><c-w><c-w>
"jump to another buffer in terminal mode
tnoremap <c-w><c-g> <c-w>:b 
"close terminal buffer
tnoremap <c-w><c-b> <c-w>:bd!<CR>

set path+=**
set wildmenu
set nu "turn line numbers on
filetype plugin indent on "determine filetype specific settings
syntax on "syntax highlighting on
au BufNewFile,BufRead Snakefile set syntax=snakemake
au BufNewFile,BufRead *.smk set syntax=snakemake
"window switching remap
nmap <C-p> <C-w>
"set splitbelow "new windows open below
set splitright
"line settings
set cursorline
hi CursorLine   cterm=NONE ctermbg=black
hi CursorLineNR cterm=bold ctermbg=black
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
"set comments to be dark grey
hi Comment ctermfg=DarkGray
"cursor settings (block in normal, dash in insert)
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[5 q"
let &t_EI = "\<esc>[2 q"
""for tmux
"let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
"let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
let g:vimteractive_vertical = 1
"easy way to close all windows
nnoremap wq :wqa!
:set hidden "buffers don't close when switched"
"global buffer list
nnoremap gb :ls<CR>:b<Space>
"switch to previous buffer
nnoremap fb :b#<CR>
"start and end of line configure
"nnoremap H 0
"nnoremap L $
"Set up escape to work in terminal mode
tnoremap <Esc><Esc> <C-\><C-n>
"yank terminal line
nnoremap <C-y> G/><CR>llv$y
"close buffer and move to previous
nnoremap <leader>q :bp<bar>vsp<bar>bn<bar>bd<CR>
set backspace=indent,eol,start
"set folding colour
hi Folded ctermbg=black
"set split line character and width
set fillchars=vert:│
hi VertSplit cterm=NONE
"allow terminal buffers to be hidden
set hidden
set shiftwidth=4
set expandtab
set smarttab


"add navigation remaps to match terminal
map <C-a> <Esc>^
imap <C-a> <Esc>I
map <C-e> <Esc>$
imap <C-e> <Esc>A

"switch fold method to manual when in insert mode (stops code constantly
"folding and unfolding)
autocmd InsertLeave,WinEnter * setlocal foldmethod=syntax
autocmd InsertEnter,WinLeave * setlocal foldmethod=manual

"for markdown, tick todo list line
map <C-/> 0r<C-k>OK


function Close_term()
    for i in term_list() 
        exec "bd! ".i 
    endfor
endfunction

