" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Generates config files for YouCompleteMe
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" A light and configurable statusline/tabline plugin
Plug 'itchyny/lightline.vim'

" quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" emmet
Plug 'mattn/emmet-vim'

" Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
Plug 'w0rp/ale'

" EditorConfig plugin
Plug 'editorconfig/editorconfig-vim'

" True Sublime Text style multiple selections for Vim
Plug 'terryma/vim-multiple-cursors'

" shows a git diff in the gutter (sign column) and stages/undoes hunks
Plug 'airblade/vim-gitgutter'

" A file system explorer for the Vim editor and various additions
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'PhilRunninger/nerdtree-visual-selection'

" Fuzzy file finder
Plug 'wincent/command-t'

" Adds filetype glyphs (icons) to various vim plugins
Plug 'ryanoasis/vim-devicons'

" Shows a git diff in the sign column
Plug 'airblade/vim-gitgutter'

" Full path fuzzy finder (file, buffer, mru, tag, etcetera) for Vim.
Plug 'ctrlpvim/ctrlp.vim'

" Comment functions
Plug 'scrooloose/nerdcommenter'

" Prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Panes
Plug 'christoomey/vim-tmux-navigator'

" Status/tabline for vim
Plug 'vim-airline/vim-airline'

" Bright theme with pastel 'retro groove' colors
Plug 'morhetz/gruvbox'

" TS Syntax
Plug 'HerringtonDarkholme/yats.vim'

" Initialize plugin system
call plug#end()

filetype plugin indent on

" show existing tab with 4 spaces width
set tabstop=4

" when indenting with '>', use 4 spaces width
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab

" show line number by default
set number

" Add file structure
map <C-o> :NERDTreeToggle<CR>

" add character position of cursor
:set ruler

inoremap jk <ESC>
nmap <C-n> :NERDTreeToggle<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
" open NERDTree automatically
"autocmd StdinReadPre _ let s:std_in=1
" Start NERDTree and leave the cursor in it.
" autocmd VimEnter * NERDTree
let g:NERDTreeGitStatusWithFlags = 1
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"let g:NERDTreeGitStatusNodeColorization = 1
"let g:NERDTreeColorMapCustom = {
"\ "Staged" : "#0ee375",
 "\ "Modified" : "#d9bf91",
 "\ "Renamed" : "#51C9FC",
 "\ "Untracked" : "#FCE77C",
 "\ "Unmerged" : "#FC51E6",
 "\ "Dirty" : "#FFBD61",
 "\ "Clean" : "#87939A",
 "\ "Ignored" : "#808080"
 "\ }
let g:NERDTreeIgnore = ['^node_modules$']
" vim-prettier
"let g:prettier#quickfix*enabled = 0
"let g:prettier#quickfix_auto_focus = 0
" prettier command for coc
"command! -nargs=0 Prettier :CocCommand prettier.formatFile
" run prettier on save
"let g:prettier#autoformat = 0
"autocmd BufWritePre *.js,_.jsx,_.mjs,_.ts,_.tsx,_.css,_.less,_.scss,_.json,_.graphql,_.md,_.vue,_.yaml,\_.html PrettierAsync
" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
set number
set smarttab
set cindent
set tabstop=2
set shiftwidth=2
" always uses spaces instead of tab characters
set expandtab
" \***\* for nord time something **\*\*\*\*\*
" sync open file with NERDTree
" " Check if NERDTree is open or active
"function! IsNERDTreeOpen()
" return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
"endfunction
" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
"function! SyncTree()
" if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
" NERDTreeFind
" wincmd p
" endif
"endfunction
" Highlight currently open buffer in NERDTree
"autocmd BufEnter \* call SyncTree()
"\***\* end here **\*\*\*\*\*\*\*\*
" coc config
let g:coc_global_extensions = [
\ 'coc-snippets',
\ 'coc-pairs',
\ 'coc-tsserver',
\ 'coc-eslint',
\ 'coc-prettier',
\ 'coc-json',
\ ]
" from readme
" if hidden is not set, TextEdit might fail.
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
\ pumvisible() ? "\<C-n>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1] =~# '\s'
endfunction
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
if (index(['vim','help'], &filetype) >= 0)
execute 'h '.expand('<cword>')
else
call CocAction('doHover')
endif
endfunction
" Highlight symbol under cursor on CursorHold
autocmd CursorHold \* silent call CocActionAsync('highlight')
" Remap for rename current word
nmap <F2> <Plug>(coc-rename)
" Remap for format selected region
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
augroup mygroup
autocmd!
" Setup formatexpr specified filetype(s).
autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
" Update signature help on jump placeholder
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf <Plug>(coc-fix-current)
" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a :<C-u>CocList diagnostics<cr>

" Manage extensions
nnoremap <silent> <space>e :<C-u>CocList extensions<cr>

" Show commands
nnoremap <silent> <space>c :<C-u>CocList commands<cr>

" Find symbol of current document
nnoremap <silent> <space>o :<C-u>CocList outline<cr>

" Search workspace symbols
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>

" Do default action for next item.
nnoremap <silent> <space>j :<C-u>CocNext<CR>

" Do default action for previous item.
nnoremap <silent> <space>k :<C-u>CocPrev<CR>

" Resume latest coc list
nnoremap <silent> <space>p :<C-u>CocListResume<CR>

" Alternative way to save
nnoremap <C-s> :w<CR>

" Alternative way to quit
nnoremap <C-M> :wq<CR>
