set noshowmode
set relativenumber
set autochdir
set termguicolors
set updatetime=1000
colorscheme gruvbox
map <silent> <leader>bc :Bclose<CR>

let g:python3_host_prog = 'python'
autocmd FileType c,cpp,java setlocal commentstring=//\ %s
autocmd FileType help       wincmd L
autocmd VimEnter * silent NeomakeDisable
command! EnableIDE silent NeomakeEnable<bar>CocStart
command! VTerm     silent vsp term://$SHELL

nnoremap q: <nop>
