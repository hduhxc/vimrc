call plug#begin('~/.vim_runtime/my_plugins')
Plug 'yggdroot/leaderf', {'do': './install.sh'}
Plug 'MattesGroeger/vim-bookmarks'
Plug 'vim-airline/vim-airline'
Plug 'mg979/vim-visual-multi'
Plug 'dccmx/google-style.vim'
Plug 'lambdalisue/fern.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'Valloric/ListToggle'
Plug 'tpope/vim-fugitive'
Plug 'justinmk/vim-sneak'
Plug 'morhetz/gruvbox'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'neomake/neomake'
call plug#end()

" leaderf
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<leader>o'
noremap <c-n> :LeaderfMru<CR>
noremap <leader>f :LeaderfFunction<CR>
noremap <leader>ft :LeaderfBufTag<CR>
let g:Lf_StlSeparator = { 'left': '', 'right': '' }

let g:Lf_WorkingDirectoryMode = 'A'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim_runtime/temp_dirs/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_StlColorscheme = 'gruvbox_material'
let g:Lf_ShowDevIcons = 0
let g:Lf_PreviewInPopup = 1
let g:Lf_WildIgnore = { 'dir': ['.*', 'build'] }
let g:Lf_MruFileExclude = ['*.txt']

let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf gtags --recall %s", "")<CR><CR>
noremap <leader>g  :Leaderf rg<space>
noremap <leader>gc :Leaderf rg -t cpp<space>

" sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
map f <Plug>Sneak_s
map F <Plug>Sneak_S

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" unimpaired
nnoremap <silent> [t :tabprevious<CR>
nnoremap <silent> ]t :tabnext<CR>
nnoremap <silent> [T :tprevious<CR>
nnoremap <silent> ]T :tnext<CR>

" list-toggle
let g:lt_quickfix_list_toggle_map = '<f12>'
let g:lt_location_list_toggle_map = '<f2>'

" coc
let g:coc_start_at_startup = 0
let g:coc_global_extensions = ['coc-clangd', 'coc-cmake', 'coc-snippets']
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

nnoremap <silent> A :CocCommand clangd.switchSourceHeader<CR>
nnoremap <silent> H :call CocActionAsync('doHover')<CR>
nnoremap <leader>rn :call CocActionAsync('rename')<CR>
nnoremap <leader>cd :call CocActionAsync('jumpDefinition')<CR>
nnoremap <leader>cr :call CocActionAsync('jumpReferences')<CR>
inoremap <c-s>      <c-\><c-o>:call CocActionAsync('showSignatureHelp')<CR>
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" neomake
let g:neomake_cpp_enabled_makers = ['cpplint', 'cppcheck']
let g:neomake_c_enabled_makers = ['cppcheck']
call neomake#configure#automake('rw', 1000)

function GetBuildDir()
    let l:make = neomake#utils#FindGlobFile("Makefile")
    if filereadable(l:make)
        return fnamemodify(l:make, ":h")
    endif
    let l:cmake = neomake#utils#FindGlobFile("CMakeLists.txt")
    if filereadable(l:cmake)
        let l:bdir = fnamemodify(l:cmake, ":h")."/build"
        if !isdirectory(l:bdir)
           call mkdir(l:bdir, 'p')
        endif
        return l:bdir
    endif
    return expand("%:p:h")
endfunction

autocmd FileType c,cpp nnoremap <buffer><silent><F6>
            \ :<C-U><C-R>=printf("NeomakeSh cd %s;
            \ make clean", GetBuildDir())<CR><CR>
autocmd FileType c,cpp nnoremap <buffer><silent><F7>
            \ :<C-U><C-R>=printf("NeomakeSh cd %s;
            \ cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
            \ -DCMAKE_BUILD_TYPE=Debug ..", GetBuildDir())<CR><CR>
autocmd FileType c,cpp nnoremap <buffer><silent><F8>
            \ :<C-U><C-R>=printf("let &makeprg=\"cd %s; make\"<bar>
            \ Neomake!", GetBuildDir())<CR><CR>

" visual-multi
let g:VM_show_warnings = 0
let g:VM_theme = 'spacegray'
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-m>'
let g:VM_maps['Find Subword Under'] = '<C-m>'

