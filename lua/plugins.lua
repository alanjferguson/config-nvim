-- Bootstrap Paq

local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

require "paq" {
	-- let paq manage itself
	{"savq/paq-nvim"};

	--Sensible defaults
	{'tpope/vim-sensible'};

	--Color schemes
	{'bluz71/vim-nightfly-guicolors'};
	{'challenger-deep-theme/vim', as='challenger_deep'};

	--VimTeX
	{'lervag/vimtex'};

	--Vim airline
	{'vim-airline/vim-airline'};
	{'vim-airline/vim-airline-themes'};

	--Auto-pairs
	{'jiangmiao/auto-pairs'};

	--Nerd commenter
	{'scrooloose/nerdcommenter'};

	--Neoformatter
	{'sbdchd/neoformat'};

	--Highlight yanked text
	{'machakann/vim-highlightedyank'};

	--vim-which-key
	{'liuchengxu/vim-which-key', as='WhichKey'};

	{'nvim-treesitter/nvim-treesitter', run='TSUpdate'};
}
