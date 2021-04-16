vim.g.tex_flavour='latex'
vim.g.tex_conceal=''
vim.g.vimtex_fold_manual=1
vim.g.vimtex_compiler_progname = 'nvr'
vim.g.vimtex_compiler_engine='latexmk'
vim.g.vimtex_view_method = "skim"
vim.g.vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
vim.g.vimtex_view_general_options = '-r @line @pdf @tex'
vim.g.vimtex_compiler_latexmk = [[{'background' : 0, 'continuous' : 0}]]

if vim.fn.executable('texlab') == 1 then
	vim.api.nvim_exec([[
    		au User lsp_setup call lsp#register_server({'name': 'texlab', 'cmd': {server_info->['texlab']}, 'config': {'hover_conceal': 0,}, 'whitelist': ['bib','tex'],})
	]], {silent=true})
end

function SetServerName ()
	nvim_server_file = "/tmp/curnvimserver.txt"
	os.execute('echo ' .. vim.v.servername .. '>' .. nvim_server_file)
end

vim.api.nvim_exec([[
augroup vimtex_common
    autocmd!
    autocmd FileType tex call SetServerName()
augroup END
]], {silent=true})

vim.api.nvim_exec([[
function! UpdateSkim() abort
    let l:out = b:vimtex.out()
    let l:src_file_path = expand('%:p')
    let l:cmd = [g:vimtex_view_general_viewer, '-r']

    if !empty(system('pgrep Skim'))
    call extend(l:cmd, ['-g'])
    endif

    call jobstart(l:cmd + [line('.'), l:out, l:src_file_path])
endfunction
]], {silent=true})

vim.api.nvim_exec([[
augroup vimtex_mac
    autocmd!
    autocmd User VimtexEventCompileSuccess call UpdateSkim()
augroup END
]], {silent=true})

