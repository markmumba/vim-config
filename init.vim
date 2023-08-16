
set shiftwidth=4
set tabstop=4
set scrolloff=40
set expandtab
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set number 
set relativenumber 
set statusline=%f\ -\ FileType:\ %y
set statusline+=%=        " Switch to the right side
set statusline+=Current:\ %-4l        " Current line
set statusline+=Total:\ %-4L        " Total lines
let mapleader = " "

call plug#begin( '~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}
Plug 'xero/miasma.nvim'
Plug 'tomasiser/vim-code-dark'
Plug 'leafgarland/typescript-vim'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' } 
Plug 'peitalin/vim-jsx-typescript'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jlanzarotta/bufexplorer'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
call plug#end()

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
syntax on
set t_Co=256
set cursorline
colorscheme codedark 

nnoremap <leader>t :Ex <CR>
nnoremap <leader>q :q <CR>
nnoremap <leader>w :w <CR>
nnoremap <leader>f :Files <CR>
nnoremap <leader>d :GoDoc <CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim <CR>
nnoremap <C-c> :bn <CR>
nnoremap cc <esc>:!
inoremap jj <esc>

let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif 

set autowrite
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'


let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

let g:go_auto_type_info = 1

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>e  <Plug>(go-test)
au filetype go inoremap <buffer> . .<C-x><C-o>
