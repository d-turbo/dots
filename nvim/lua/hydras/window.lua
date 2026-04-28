local Hydra = require('hydra')

Hydra({
	name = 'Window management',

	mode = { 'n', 't' },

	body = '<leader>z',

	heads = {
		{ 'h', '<C-w>h', { desc = 'Move left', mode = 'n', exit = false } },
		{ 'j', '<C-w>j', { desc = 'Move down', mode = 'n', exit = false } },
		{ 'k', '<C-w>k', { desc = 'Move up', mode = 'n', exit = false } },
		{ 'l', '<C-w>l', { desc = 'Move right', mode = 'n', exit = false } },
		{ '<left>', '<C-w>h', { desc = 'Move left', mode = 'n', exit = false } },
		{ '<down>', '<C-w>j', { desc = 'Move down', mode = 'n', exit = false } },
		{ '<up>', '<C-w>k', { desc = 'Move up', mode = 'n', exit = false } },
		{ '<right>', '<C-w>l', { desc = 'Move right', mode = 'n', exit = false } },

		{ 'h', [[<C-\><C-n><C-w>h]], { desc = 'Terminal left', mode = 't', exit = false } },
		{ 'j', [[<C-\><C-n><C-w>j]], { desc = 'Terminal down', mode = 't', exit = false } },
		{ 'k', [[<C-\><C-n><C-w>k]], { desc = 'Terminal up', mode = 't', exit = false } },
		{ 'l', [[<C-\><C-n><C-w>l]], { desc = 'Terminal right', mode = 't', exit = false } },
		{ '<left>', [[<C-\><C-n><C-w>h]], { desc = 'Terminal left', mode = 't', exit = false } },
		{ '<down>', [[<C-\><C-n><C-w>j]], { desc = 'Terminal down', mode = 't', exit = false } },
		{ '<up>', [[<C-\><C-n><C-w>k]], { desc = 'Terminal up', mode = 't', exit = false } },
		{ '<right>', [[<C-\><C-n><C-w>l]], { desc = 'Terminal right', mode = 't', exit = false } },

        { 'H', ':vertical resize -5<CR>', { desc = 'Resize split to the left', mode = 'n', exit = false } },
        { 'J', ':resize +5<CR>', { desc = 'Resize split downwards', mode = 'n', exit = false } },
        { 'K', ':resize -5<CR>', { desc = 'Resize split upwards', mode = 'n', exit = false } },
        { 'L', ':vertical resize +5<CR>', { desc = 'Resize split to the right', mode = 'n', exit = false } },
		{ '<C- left>', ':vertical resize -5<CR>', { desc = 'Resize split to the left', mode = 'n', exit = false } },
        { '<C- down>', ':resize +5<CR>', { desc = 'Resize split downwards', mode = 'n', exit = false } },
        { '<C- up>', ':resize -5<CR>', { desc = 'Resize split upwards', mode = 'n', exit = false } },
        { '<C- right>', ':vertical resize +5<CR>', { desc = 'Resize split to the right', mode = 'n', exit = false } },

        { 'H', [[<C-\><C-n>:vertical resize -5<CR>]], { desc = 'Resize terminal to the left', mode = 't', exit = false } },
        { 'J', [[<C-\><C-n>:resize +5<CR>]], { desc = 'Resize terminal downwards', mode = 't', exit = false } },
        { 'K', [[<C-\><C-n>:resize -5<CR>]], { desc = 'Resize terminal upwards', mode = 't', exit = false } },
        { 'L', [[<C-\><C-n>:vertical resize +5<CR>]], { desc = 'Resize terminal to the right', mode = 't', exit = false } },
        { '<C- left>', [[<C-\><C-n>:vertical resize -5<CR>]], { desc = 'Resize terminal to the left', mode = 't', exit = false } },
        { '<C- down>', [[<C-\><C-n>:resize +5<CR>]], { desc = 'Resize terminal downwards', mode = 't', exit = false } },
        { '<C- up>', [[<C-\><C-n>:resize -5<CR>]], { desc = 'Resize terminal upwards', mode = 't', exit = false } },
        { '<C- right>', [[<C-\><C-n>:vertical resize +5<CR>]], { desc = 'Resize terminal to the right', mode = 't', exit = false } },

        { '<ESC>', nil, { exit = true, desc = 'Exit' } },
    },
    config = {
	color = 'teal',
	invoke_on_body = true,
	hint = { position = 'bottom' },
    }
})

