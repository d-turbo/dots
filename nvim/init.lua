local globals = {
	mapleader = ' ',
	maplocalleader = '\\',

	netrw_banner = 0,
	netrw_liststyle = 1,
	netrw_browse_split = 0,
	netrw_altv = 1,
	netrw_sizestyle = 'h',
	netrw_winsize = 25,
	netrw_fastbrowse = 1,
}

local options = {
	termguicolors = true,
	number = true,
	relativenumber = true,
	cursorline = true,
	signcolumn = 'yes',
	wrap = true,
	wrapmargin = 0,
	breakindent = true,
	scrollback = 300,
	scrolloff = 999,
	sidescrolloff = 16,
	showmode = true,
	smoothscroll = true,
	lazyredraw = true,

	splitbelow = true,
	splitright = true,
	equalalways = true,

	tabstop = 4,
	softtabstop = 4,
	shiftwidth = 4,
	expandtab = false,
	smartindent = true,
	autoindent = true,

	autoread = true,
	autochdir = true,
	mouse = 'a',
	clipboard = 'unnamedplus',
	fileencoding = 'utf-8',

	incsearch = true,
	hlsearch = true,
	ignorecase = true,
	smartcase = true,
	inccommand = 'split',

	completeopt = {'menu', 'menuone', 'noselect'},
	
	cedit = '<C-F>',

	shortmess = "filnxtToOFI",

	list = true,
	listchars = {
		tab = "│ ",
		trail = "~",
		extends = ">",
		precedes = "<",
		nbsp = "_"
	},
	
	matchtime = 2,

	swapfile = false,
	backup = false,
	writebackup = false,

}

local keymaps = {
	t = {
		{ "<C-\\>", [[<C-\><C-n>]] },
	},
	
	n = {
		{ "<leader>vd", ":vsplit<CR>" },
		{ "<leader>vn", ":vnew<CR>" },
		{ "<leader>vx", ":Vexplore<CR>" },
		{ "<leader>vt", ":vsplit | terminal<CR>" },

		{ "<leader>hd", ":split<CR>" },
		{ "<leader>hn", ":new<CR>" },
		{ "<leader>hx", ":Explore<CR>" },
		{ "<leader>ht", ":split | terminal<CR>" },

		{ "<leader>td", ":tab split<CR>" },
		{ "<leader>tn", ":tabnew<CR>" },
		{ "<leader>tx", ":Texplore<CR>" },
		{ "<leader>tt", ":tab split | terminal<CR>" },

		{ "<leader>n", ":enew<CR>" },
		{ "<leader>N", ":enew!<CR>" },
		{ "<leader>x", ":Explore<CR>" },
		{ "<leader>X", ":Explore!<CR>" },
		{ "<leader>t", ":terminal<CR>" },
		{ "<leader>T", ":terminal!<CR>" },

		{ "<leader>bc", ":bdelete<CR>" },
		{ "<leader>tc", ":tabclose<CR>" },

		{ "<leader>/", ":nohlsearch<CR>" },
	}
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

for k, v in pairs(globals) do
	vim.g[k] = v
end

for mode, maps in pairs(keymaps) do
	for _, m in ipairs(maps) do
		vim.keymap.set(mode, m[1], m[2], { noremap = true, silent =true })
	end
end

require('lazy.config')
require('hydras.window')
