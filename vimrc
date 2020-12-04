"plugin management with vim-plug (auto-installs if necessary)
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

"info bar at bottom
Plug 'vim-airline/vim-airline'

"add generic REPLS via :terminal command
"Plug 'williamjameshandley/vimteractive'

"type closing characters automatically
"Plug 'jiangmiao/auto-pairs'

"automatically create new directories on save
Plug 'arp242/auto_mkdir2.vim'

"syntax and autocomplete for julia
Plug 'JuliaEditorSupport/julia-vim'

"send julia cells to terminal
Plug 'mroavi/vim-julia-cell', { 'for': 'julia' }

"send information to terminal
Plug 'jpalardy/vim-slime'

"edit surrounding characters
"Plug "tpope/vim-surround"

call plug#end()

"slime config
let g:slime_target = 'vimterminal'
"let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
"let g:slime_dont_ask_default = 1
let g:slime_vimterminal_cmd ="make run"
let g:slime_vimterminal_config = { "vertical": 1 }
let g:slime_no_mappings = 1
xmap <c-s><c-s> <Plug>SlimeRegionSend
nmap <c-s><c-s> <Plug>SlimeLineSend
nmap <c-s><c-r> <Plug>SlimeParagraphSend
"nmap <c-s><c-a> ggVG<Plug>SlimeRegionSend<c-O><c-O>
nmap <c-s><c-e> kVgg<SlimeRegionSend<c-O><c-O>
nmap <c-s><c-d> VG<SlimeRegionSend<c-O><c-O>
nmap <c-s><c-a> :%SlimeSend<cr>
nmap <c-s><c-i> :SlimeSend0 'include("'.expand('%').'")'<cr><c-w><c-w><cr><c-w><c-w>
nmap <c-s><c-w> :SlimeSend0 'weave("'.expand('%').'",doctype = "md2html")'<cr><c-w><c-w><cr><c-w><c-w>
nmap <c-s><c-w>c :SlimeSend0 'weave("'.expand('%').'",doctype = "md2html",cache = :user)'<cr><c-w><c-w><cr><c-w><c-w>
nmap <c-s><c-t> :SlimeSend0 '@time '.getline(".") <cr><c-w><c-w><cr><c-w><c-w> 
nmap <c-s>s     <Plug>SlimeConfig
"Julia cell config
let g:julia_cell_delimit_cells_by = 'tags'


"window navigation
tnoremap <c-w><c-w> i<c-e><c-u><c-w><c-w>
set path+=**
set wildmenu
set nu "turn line numbers on
filetype plugin indent on "determine filetype specific settings
syntax on "syntax highlighting on
au BufNewFile,BufRead Snakefile set syntax=snakemake
au BufNewFile,BufRead *.smk set syntax=snakemake
"window switching remap
nmap <C-p> <C-w>
set splitbelow "new windows open below
set splitright
"line settings
set cursorline
hi CursorLine   cterm=NONE ctermbg=black		
hi CursorLineNR cterm=bold ctermbg=black
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
"cursor settings (block in normal, dash in insert)
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[5 q"
let &t_EI = "\<esc>[2 q"
"vimteractive settings
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
"autosave buffer, which should allow swp files to be disabled
"autocmd TextChanged,TextChangedI <buffer> silent write
"set noswapfile
nnoremap < :e ~/.vim/vimrc<CR>
"hackfix for julia syntax
set foldmethod=syntax
"yank terminal line
nnoremap <C-y> G/><CR>llv$y
"close buffer and move to previous 
nnoremap <leader>q :bp<bar>vsp<bar>bn<bar>bd<CR>
set backspace=indent,eol,start
"set folding colour
hi Folded ctermbg=black
