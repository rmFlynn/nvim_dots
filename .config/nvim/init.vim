call plug#begin('~/.local/share/nvim/plugged')
Plug 'JuliaEditorSupport/julia-vim'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'vim-syntastic/syntastic'
Plug 'chrisbra/csv.vim'
Plug 'nvie/vim-flake8'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'jalvesaq/vimcmdline'
Plug 'jalvesaq/Nvim-R'
Plug 'gaalcaras/ncm-R'
"Plug 'sirver/UltiSnips'
Plug 'ncm2/ncm2-ultisnips'
Plug 'lervag/vimtex'
Plug 'scrooloose/nerdtree'  " file list
Plug 'majutsushi/tagbar'  " show tags in a bar (functions etc) for easy browsing
"Plug 'vim-airline/vim-airline'  " make statusline awesome
"Plug 'vim-airline/vim-airline-themes'  " themes for statusline 
Plug 'davidhalter/jedi-vim'   " jedi for python
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  "to highlight files in nerdtree
Plug 'Vimjas/vim-python-pep8-indent'  "better indenting for python
Plug 'kien/ctrlp.vim'  " fuzzy search files
Plug 'tweekmonster/impsort.vim'  " color and sort imports
"Plug 'wsdjeg/FlyGrep.vim'  " awesome grep on the fly
Plug 'w0rp/ale'  " python linters
"Plug 'airblade/vim-gitgutter'  " show git changes to files in gutter
Plug 'tpope/vim-commentary'  "comment-out by gc
Plug 'roxma/nvim-yarp'  " dependency of ncm2
Plug 'ncm2/ncm2'  " awesome autocomplete plugin
Plug 'HansPinckaers/ncm2-jedi'  " fast python completion (use ncm2 if you want type info or snippet support)
Plug 'ncm2/ncm2-bufword'  " buffer keyword completion
Plug 'ncm2/ncm2-path'  " filepath completion

call plug#end()       
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => split navigation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Julia
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:default_julia_version = '1.0'
" let g:LanguageClient_serverCommands = {
"         \ 'julia': ['/u', '--startup-file=no', '--history-file=no', '-e', '
"         \       import LanguageServer;
"         \       server = LanguageServer.LanguageServerInstance(stdin, stdout, false);
"         \       server.runlinter = true;
"         \       run(server);
"         \   ']
"         \}
" 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ncm2 settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=menuone,noselect,noinsert
set shortmess+=c
inoremap <c-c> <ESC>
" make it fast
let ncm2#popup_delay = 5
let ncm2#complete_length = [[1, 1]]
" Use new fuzzy based matches
let g:ncm2#matcher = 'substrfuzzy'
  " Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Disable Jedi-vim autocompletion and enable call-signatures options
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"
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
"colo solarized
"colorscheme solarized
hi Normal guibg=NONE ctermbg=NONE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spelling stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set spelllang=en
setlocal spell
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => The ESC save mapping :-)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Esc><Esc> :w<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Auto complete the file
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_autoclose_preview_window_after_completion=1
map <leade r>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
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
let cmdline_term_width  = 80     " Initial width of interpreter window or pane
let cmdline_tmp_dir     = '/tmp' " Temporary directory to save files
let cmdline_outhl       = 1      " Syntax highlight the output
let cmdline_auto_scroll = 1      " Keep the cursor at the end of terminal (nvim)
let g:remoteSession = ($STY == "")
"let cmdline_external_term_cmd = "gnome-terminal -e '%s' &&  sleep 1 & bspc node -f prev.local.!above"

set showtabline=2
set foldcolumn=0
"set number
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fix nave key mapping :-)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<c-p>'
nnoremap <C-b> <PageUp>
nnoremap <C-f> <PageDown>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Multi cursor keybindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

let g:pymode_python = 'python'
set clipboard=unnamedplus


let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


:filetype plugin on


" more info 
" 
" https://afnan.io/post/2018-04-12-my-neovim-development-setup/
