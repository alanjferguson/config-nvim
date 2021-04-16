vim.o.mouse = 'a'

vim.o.wrap = true
vim.o.linebreak = true

------------------------------------------------------------
-- Line Numbering
------------------------------------------------------------
vim.wo.number = true
vim.api.nvim_exec([[
augroup numbertoggle
autocmd!
autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END
]], {silent=true})


vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.splitbelow = true
vim.o.splitright = true
