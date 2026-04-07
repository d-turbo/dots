local Hydra = require('hydra')

Hydra({
	name = 'Window management',

	mode = { 'n', 't' },

	body = '<leader>w',

	heads = {
		{ 'n', '<C-w>h', { desc = 'Move left', mode = 'n', exit = false } },
		{ 'e', '<C-w>j', { desc = 'Move down', mode = 'n', exit = false } },
		{ 'i', '<C-w>k', { desc = 'Move up', mode = 'n', exit = false } },
		{ 'o', '<C-w>l', { desc = 'Move right', mode = 'n', exit = false } },

		{ 'n', [[<C-\><C-n><C-w>h]], { desc = 'Terminal left', mode = 't', exit = false } },
		{ 'e', [[<C-\><C-n><C-w>j]], { desc = 'Terminal down', mode = 't', exit = false } },
		{ 'i', [[<C-\><C-n><C-w>k]], { desc = 'Terminal up', mode = 't', exit = false } },
		{ 'o', [[<C-\><C-n><C-w>l]], { desc = 'Terminal right', mode = 't', exit = false } },

        { 'N', ':vertical resize -2<CR>', { desc = 'Resize split to the left', mode = 'n', exit = false } },
        { 'E', ':resize +2<CR>', { desc = 'Resize split downwards', mode = 'n', exit = false } },
        { 'I', ':resize -2<CR>', { desc = 'Resize split upwards', mode = 'n', exit = false } },
        { 'O', ':vertical resize +2<CR>', { desc = 'Resize split to the right', mode = 'n', exit = false } },

        { 'N', [[<C-\><C-n>:vertical resize -2<CR>]], { desc = 'Resize terminal to the left', mode = 't', exit = false } },
        { 'E', [[<C-\><C-n>:resize +2<CR>]], { desc = 'Resize terminal downwards', mode = 't', exit = false } },
        { 'I', [[<C-\><C-n>:resize -2<CR>]], { desc = 'Resize terminal upwards', mode = 't', exit = false } },
        { 'O', [[<C-\><C-n>:vertical resize +2<CR>]], { desc = 'Resize terminal to the right', mode = 't', exit = false } },

        { 'S', ':vsplit<CR>', { desc = 'Duplicate buffer as a split vertically', exit = true } },
        { 's', ':split<CR>', { desc = 'Duplicate buffer as a split horizontally', exit = true } },
        { 'c', ':close<CR>', { desc = 'Close split', exit = true } },
        { 'r', '<C-w>r', { desc = 'Rotate splits', exit = false } },

        { 'V', ':vsplit | terminal<CR>', { desc = 'Create a terminal split vertically', exit = true } },
        { 'H', ':split | terminal<CR>', { desc = 'Create a terminal split horizontally', exit = true } },

        { 'v', ':Vexplore<CR>', { desc = 'Open netrw as a split vertically', exit = true } },
        { 'h', ':Sexplore<CR>', { desc = 'Open netrw as a split horizontally', exit = true } },
        { 'x', ':Explore<CR>', { desc = 'Open netrw', exit = true } },

        { '<ESC>', nil, { exit = true, desc = 'Exit' } },
    },
    config = {
	color = 'teal',
	invoke_on_body = true,
	hint = { position = 'bottom' },
    }
})

