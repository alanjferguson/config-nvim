-- Automatically close method preview window
vim.api.nvim_exec([[
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
]], {silent=false})
