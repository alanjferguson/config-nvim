vim.api.nvim_set_keymap('n', '<leader>', [[:<c-u>WhichKey '<Space>'<CR>]], {silent=true})
vim.api.nvim_set_keymap('n', '<localleader>', [[:<c-u>WhichKey ','<CR>]], {silent=true})

vim.g.which_key_disable_default_offset = 1
vim.g.which_key_use_floating_win = 1
vim.g.which_key_floating_relative_win = 1
