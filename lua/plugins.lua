------------------------------------------------------------
-- Packages
------------------------------------------------------------

vim.cmd 'packadd paq-nvim'   -- loads the package manager
local paq = require('paq-nvim').paq -- convient alias
paq {'savq/paq-nvim', opt=true} -- paq-nvim manages itself

--Sensible defaults
paq {'tpope/vim-sensible'}

--Color schemes
paq {'bluz71/vim-nightfly-guicolors'}

--VimTeX
paq {'lervag/vimtex'}

--Vim airline
paq {'vim-airline/vim-airline'}
paq {'vim-airline/vim-airline-themes'}

--Auto-pairs
paq {'jiangmiao/auto-pairs'}

--Nerd commenter
paq {'scrooloose/nerdcommenter'}

--Neoformatter
paq {'sbdchd/neoformat'}

--Highlight yanked text
paq {'machakann/vim-highlightedyank'}

--vim-which-key
paq {'liuchengxu/vim-which-key', as='WhichKey'}

paq {'nvim-treesitter/nvim-treesitter', run='TSUpdate'}

--nvim-compe
paq {'hrsh7th/nvim-compe'}
paq {'hrsh7th/vim-vsnip'}
