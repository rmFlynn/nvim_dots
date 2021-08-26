call plug#begin('~/.local/share/nvim/plugged')
Plug 'JuliaEditorSupport/julia-vim'
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'morhetz/gruvbox'
Plug 'chrisbra/csv.vim'
Plug 'jalvesaq/vimcmdline'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'  " make statusline awesome
Plug 'scrooloose/nerdtree'  " file list
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  "to highlight files in nerdtree
Plug 'Vimjas/vim-python-pep8-indent'  "better indenting for python
Plug 'kien/ctrlp.vim'  " fuzzy search files
Plug 'numirias/semshi'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pixelneo/vim-python-docstring'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
Plug 'chrisbra/Colorizer'
Plug 'snakemake/snakemake', {'rtp': 'misc/vim'}
Plug 'snakemake/snakefmt'
Plug '907th/vim-auto-save'
call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:coc_global_extensions = ['coc-diagnostic', 'coc-jedi', 'coc-sh', 'coc-snippets']
" => theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gruvbox_italic=1
colorscheme gruvbox
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => python
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:python_host_prog  = '~/miniconda3/bin/python'
let g:python3_host_prog = '~/miniconda3/bin/python'
let g:coc_node_path = "~/miniconda3/envs/nvim/bin/node"
"let g:ncm2_jedi#environment = '/home/rman/.config/nvim/nvim/bin/python3'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => leader
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufWritePre * %s/\s\+$//e
let mapleader = ";"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => should help with linting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools' ]
let g:vimspector_enable_mappings = 'HUMAN'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => docstring
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:python_style = 'rest'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fix tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  snakefmt
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead Snakefile,*.smk set filetype=snakemake
au FileType snakemake autocmd BufWritePre <buffer> execute ':Snakefmt'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => xolox vim-notes settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:notes_tab_indents = 0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nerd tree toggal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>o :NERDTreeToggle<CR>
nnoremap <leader>v <c-v>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Remember my place
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\""
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => split navigation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => The ESC save mapping :-)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <Esc> :w <CR>
"nnoremap <Esc><Esc> :w <CR>
let g:auto_save = 1  " enable AutoSave on Vim startup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
" set nobackup
" set nowb
"
"set undo swap file
set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => make it transparent & theme, looks good
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi Normal guibg=NONE ctermbg=NONE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spelling stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set spelllang=en
setlocal spell
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Line execution with inline terminal.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim cmdline mappings
let cmdline_map_start          = '<Space>'
let cmdline_map_send           = '<Space>'
let cmdline_map_send_and_stay  = '<LocalLeader><Space>'
let cmdline_map_source_fun     = '<LocalLeader>f'
let cmdline_map_send_paragraph = '<LocalLeader>p'
let cmdline_map_send_block     = '<LocalLeader>b'
let cmdline_map_quit           = '<LocalLeader>q'

" vimcmdline options
let cmdline_vsplit      = 1      " Split the window vertically
let cmdline_esc_term    = 1      " Remap <Esc> to :stopinsert in Neovim's terminal
let cmdline_in_buffer   = 1      " Start the interpreter in a Neovim's terminal
let cmdline_term_height = 15     " Initial height of interpreter window or pane
let cmdline_term_width  = 120     " Initial width of interpreter window or pane
let cmdline_tmp_dir     = '/tmp' " Temporary directory to save files
let cmdline_outhl       = 1      " Syntax highlight the output
let cmdline_auto_scroll = 1      " Keep the cursor at the end of terminal (nvim)
let g:remoteSession = ($STY == "")

"let cmdline_external_term_cmd = 'kitty %s &'
"let cmdline_external_term_cmd = "gnome-terminal -e '%s' &&  sleep 1 & bspc node -f prev.local.!above"

set showtabline=2
set foldcolumn=0
" set number
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fix nave key mapping :-)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " => coc snippets
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<c-p>'
nnoremap <C-b> <PageUp>
nnoremap <C-f> <PageDown>
set clipboard=unnamedplus

" :filetype plugin on

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " => coc autocompletion
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " TextEdit might fail if hidden is not set.
 set hidden
 " Some servers have issues with backup files, see #649.
 set nobackup
 set nowritebackup
 " Give more space for displaying messages.
 set cmdheight=2
 " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
 " delays and poor user experience.
 set updatetime=300

 " Don't pass messages to |ins-completion-menu|.
 set shortmess+=c

 " Always show the signcolumn, otherwise it would shift the text each time
 " diagnostics appear/become resolved.
 if has("patch-8.1.1564")
   " Recently vim can merge signcolumn and number column into one
   set signcolumn=number
 else
   set signcolumn=yes
 endif

 " Use tab for trigger completion with characters ahead and navigate.
 " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
 " other plugin before putting this into your config.
 inoremap <silent><expr> <TAB>
       \ pumvisible() ? "\<C-n>" :
       \ <SID>check_back_space() ? "\<TAB>" :
       \ coc#refresh()
 inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

 function! s:check_back_space() abort
   let col = col('.') - 1
   return !col || getline('.')[col - 1]  =~# '\s'
 endfunction

 " Use <c-space> to trigger completion.
 if has('nvim')
   inoremap <silent><expr> <c-space> coc#refresh()
 else
   inoremap <silent><expr> <c-@> coc#refresh()
 endif

 " Make <CR> auto-select the first completion item and notify coc.nvim to
 " format on enter, <cr> could be remapped by other vim plugin
 inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

 " Use `[g` and `]g` to navigate diagnostics
 " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
 nmap <silent> [g <Plug>(coc-diagnostic-prev)
 nmap <silent> ]g <Plug>(coc-diagnostic-next)

 " GoTo code navigation.
 nmap <silent> gd <Plug>(coc-definition)
 nmap <silent> gy <Plug>(coc-type-definition)
 nmap <silent> gi <Plug>(coc-implementation)
 nmap <silent> gr <Plug>(coc-references)

 " Use K to show documentation in preview window.
 nnoremap <silent> K :call <SID>show_documentation()<CR>

 function! s:show_documentation()
   if (index(['vim','help'], &filetype) >= 0)
     execute 'h '.expand('<cword>')
   elseif (coc#rpc#ready())
     call CocActionAsync('doHover')
   else
     execute '!' . &keywordprg . " " . expand('<cword>')
   endif
 endfunction

 " Highlight the symbol and its references when holding the cursor.
 autocmd CursorHold * silent call CocActionAsync('highlight')

 " Symbol renaming.
 nmap <leader>rn <Plug>(coc-rename)

 " Formatting selected code.
 xmap <leader>f  <Plug>(coc-format-selected)
 nmap <leader>f  <Plug>(coc-format-selected)

 augroup mygroup
   autocmd!
   " Setup formatexpr specified filetype(s).
   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
   " Update signature help on jump placeholder.
   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
 augroup end

 " Applying codeAction to the selected region.
 " Example: `<leader>aap` for current paragraph
 xmap <leader>a  <Plug>(coc-codeaction-selected)
 nmap <leader>a  <Plug>(coc-codeaction-selected)

 " Remap keys for applying codeAction to the current buffer.
 nmap <leader>ac  <Plug>(coc-codeaction)
 " Apply AutoFix to problem on the current line.
 nmap <leader>qf  <Plug>(coc-fix-current)

 " Map function and class text objects
 " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
 xmap if <Plug>(coc-funcobj-i)
 omap if <Plug>(coc-funcobj-i)
 xmap af <Plug>(coc-funcobj-a)
 omap af <Plug>(coc-funcobj-a)
 xmap ic <Plug>(coc-classobj-i)
 omap ic <Plug>(coc-classobj-i)
 xmap ac <Plug>(coc-classobj-a)
 omap ac <Plug>(coc-classobj-a)

 " Use CTRL-S for selections ranges.
 " Requires 'textDocument/selectionRange' support of language server.
 nmap <silent> <C-s> <Plug>(coc-range-select)
 xmap <silent> <C-s> <Plug>(coc-range-select)

 " Add `:Format` command to format current buffer.
 command! -nargs=0 Format :call CocAction('format')

 " Add `:Fold` command to fold current buffer.
 command! -nargs=? Fold :call     CocAction('fold', <f-args>)

 " Add `:OR` command for organize imports of the current buffer.
 command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

 " Add (Neo)Vim's native statusline support.
 " NOTE: Please see `:h coc-status` for integrations with external plugins that
 " provide custom statusline: lightline.vim, vim-airline.
 set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

 " Mappings for CoCList
 " Show all diagnostics.
 nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
 " Manage extensions.
 nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
 " Show commands.
 nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
 " Find symbol of current document.
 nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
 " Search workspace symbols.
 nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
 " Do default action for next item.
 nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
 " Do default action for previous item.
 nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
 " Resume latest coc list.
 nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

 autocmd BufNew,BufEnter *.json,*.md execute "silent! CocDisable"
