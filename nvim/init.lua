local globals = {
	mapleader = ' ',
	maplocalleader = '\\',

	netrw_banner = 0,
	netrw_liststyle = 3,
	netrw_browse_split = 0,
	netrw_altv = 1
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
	scrolloff = 8,
	sidescrolloff = 8,
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

	completeopt = {'menu', 'menuone', 'noselect', 'fuzzy' },
	
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

for k, v in pairs(options) do
	vim.opt[k] = v
end

for k, v in pairs(globals) do
	vim.g[k] = v
end

require('lazy.config')
require('hydras.window')

