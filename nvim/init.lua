vim.g.mapleader = ' '
vim.g.maplocalleader = "\\"

require('lazy.config')

vim.g.termguicolors = true
vim.o.autoread = true
vim.o.clipboard = 'unnamedplus'
vim.o.completeopt = 'menu,fuzzy,menuone,noselect'
vim.o.mouse = 'a'
vim.o.fileencoding = 'utf-8'
vim.o.autochdir = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false
vim.o.smartindent = true
vim.o.autoindent = true

vim.o.wrap = true
vim.o.wrapmargin = 0
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.signcolumn = 'yes'
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.showmode = true
vim.o.matchtime = 2

vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split'

vim.o.cedit = "^F"
vim.o.shortmess = "filnxtToOF"

vim.o.lazyredraw = true
vim.o.list = true
vim.o.listchars = "tab:│ ,trail:~,extends:>,precedes:<,nbsp:."

require('hydras.window')

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 0
vim.g.netrw_altv = 1
