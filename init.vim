" vim: set expandtab tabstop=4 shiftwidth=4:

"---- vim-plug setup  ----

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif
"-------- end vim-plug setup ----

set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
call plug#begin(expand('~/.config/nvim/plugged'))

" Sensible defaults
Plug 'tpope/vim-sensible'

" Color schemes
Plug 'bluz71/vim-nightfly-guicolors'

" VimTeX
Plug 'lervag/vimtex'

" Jedi
" Plug 'davidhalter/jedi-vim'
" Plug 'zchee/deoplete-jedi'

" Vim airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Auto-pairs
Plug 'jiangmiao/auto-pairs'

" Nerd commenter
Plug 'scrooloose/nerdcommenter'

" Neoformatter
Plug 'sbdchd/neoformat'

" Highlight yanked text
Plug 'machakann/vim-highlightedyank'

" vim-which-key
Plug 'liuchengxu/vim-which-key', { 'on':['WhichKey', 'WhichKey!'] }

" Plug 'nvim-treesitter/nvim-treesitter', {'do':':TSUpdate'}

" nvim-compe
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'

" if has('nvim')
" 	Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
" else
" 	Plug 'Shougo/deoplete.nvim'
" 	Plug 'roxma/nvim-yarp'
" 	Plug 'roxma/vim-hug-neovim-rpc'
" endif
call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
            \ if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \| PlugInstall --sync | q
            \| endif

if has('termguicolors')
    set termguicolors
endif

let g:nightflyUnderlineMatchParen = 1
colorscheme nightfly

syntax enable
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL CONFIG
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set mouse=a

set ignorecase
set smartcase

set wrap linebreak nolist

" Turns off <c-h> auto pair delete
let g:AutoPairsMapCh = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keys
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:mapleader = "\<Space>"
let g:maplocalleader = ","

nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>

set timeoutlen=500

let g:which_key_disable_default_offset = 1
let g:which_key_use_floating_win = 1
let g:which_key_floating_relative_win = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Windowing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set splitbelow

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Makes highlight permanent until next yank / mode change
let g:highlightedyank_highlight_duration = -1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Line numbering
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number relativenumber

augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto compete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt=menuone,noselect

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup for Python
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Automatically close method preview window
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup for LaTeX
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if executable('texlab')
    au User lsp_setup call lsp#register_server({
                \ 'name': 'texlab',   
                \ 'cmd': {server_info->['texlab']},
                \ 'config': {
                \     'hover_conceal': 0,
                \ },
                \ 'whitelist': ['bib','tex'],
                \ })
endif
" This is new style
" call deoplete#custom#var('omni', 'input_patterns', {
"       \ 'tex': g:vimtex#re#deoplete
"       \})

let g:tex_flavour='latex'
let g:tex_conceal=''
let g:vimtex_fold_manual=1
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_compiler_engine='latexmk'
let g:vimtex_view_method = "skim"
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'

let g:vimtex_compiler_latexmk = {
            \ 'background' : 0,
            \ 'continuous' : 0,
            \ }

augroup vimtex_mac
    autocmd!
    autocmd User VimtexEventCompileSuccess call UpdateSkim()
augroup END

function! UpdateSkim() abort
    let l:out = b:vimtex.out()
    let l:src_file_path = expand('%:p')
    let l:cmd = [g:vimtex_view_general_viewer, '-r']

    if !empty(system('pgrep Skim'))
    call extend(l:cmd, ['-g'])
    endif

    call jobstart(l:cmd + [line('.'), l:out, l:src_file_path])
endfunction

function! SetServerName()
  if has('win32')
    let nvim_server_file = $TEMP . "/curnvimserver.txt"
  else
    let nvim_server_file = "/tmp/curnvimserver.txt"
  endif
  let cmd = printf("echo %s > %s", v:servername, nvim_server_file)
  call system(cmd)
endfunction

augroup vimtex_common
    autocmd!
    autocmd FileType tex call SetServerName()
augroup END
