local keymap = require('core.keymap')
local nmap, imap, cmap, xmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

-- Use space as leader key
vim.g.mapleader = ' '

-- leaderkey
nmap({ ' ', '', opts(noremap) })
xmap({ ' ', '', opts(noremap) })

-- usage example
nmap({
	-- noremal remap
	-- close buffer
	{ '<C-x>k', cmd('bdelete'), opts(noremap, silent) },
	-- save
	{ '<C-s>', cmd('write'), opts(noremap) },
	-- yank
	{ 'Y', 'y$', opts(noremap) },
	-- buffer jump
	{ ']b', cmd('bn'), opts(noremap) },
	{ '[b', cmd('bp'), opts(noremap) },
	-- remove trailing white space
	{ '<Leader>t', cmd('TrimTrailingWhitespace'), opts(noremap) },
	-- window jump
	{ '<C-h>', '<C-w>h', opts(noremap) },
	{ '<C-l>', '<C-w>l', opts(noremap) },
	{ '<C-j>', '<C-w>j', opts(noremap) },
	{ '<C-k>', '<C-w>k', opts(noremap) },
})

imap({
	-- insert mode
	{ '<C-h>', '<Bs>', opts(noremap) },
	{ '<C-e>', '<End>', opts(noremap) },
})

-- commandline remap
cmap({ '<C-b>', '<Left>', opts(noremap) })
-- usage of plugins
nmap({
	-- plugin manager: Lazy.nvim
	{ '<Leader>pu', cmd('Lazy update'), opts(noremap, silent) },
	{ '<Leader>pi', cmd('Lazy install'), opts(noremap, silent) },
})