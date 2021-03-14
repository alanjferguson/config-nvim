" vim: set expandtab tabstop=4 shiftwidth=4:

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
call plug#begin(expand('~/.vim/plugged'))

" Solarized 8 ColorScheme
Plug 'lifepillar/vim-solarized8'

" VimTeX
Plug 'lervag/vimtex'

" Jedi
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'

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

if has('nvim')
	Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
else
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL CONFIG
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set mouse=a

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Windowing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set splitbelow

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors
syntax on
set background=dark
colorscheme solarized8
let g:airline_theme="solarized"

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
let g:deoplete#enable_at_startup = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup for Python
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Automatically close method preview window
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup for LaTeX
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This is new style
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})

" let g:vimtex_view_method = "skim"
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'

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
