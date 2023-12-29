local config = {}

function config.telescope()
	require("telescope").setup {
		defaults = {
			vimgrep_arguments = {
				"rg",
				"-L",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--trim"
			},
			prompt_prefix = "   ",
			selection_caret = "  ",
			entry_prefix = "  ",
			initial_mode = "insert",
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120,
			},
			file_sorter = require("telescope.sorters").get_fuzzy_file,
			file_ignore_patterns = { "node_modules" },
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			path_display = { "truncate" },
			winblend = 0,
			border = {},
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			color_devicons = true,
			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
			-- Developer configurations: Not meant for general override
			buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
			mappings = {
				n = { ["q"] = require("telescope.actions").close },
			},
		},
		pickers = {
			find_files = {
				find_command = { "rg", "--files", "-uu", "--glob", "!**/.git/*" }
			}
		},
		extensions = {
			file_browser = {
				hijack_netrw = true,
			},
		},
	}
	require("telescope").load_extension "file_browser"
	require('telescope').load_extension "fzy_native"
	require("telescope").load_extension "notify"
	require("telescope").load_extension "ui-select"
end

function config.neoscroll()
	require('neoscroll').setup()
	local t    = {}
	-- Syntax: t[keys] = {function, {function arguments}}
	t['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '250' } }
	t['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '250' } }
	t['<C-b>'] = { 'scroll', { '-vim.api.nvim_win_get_height(0)', 'true', '450' } }
	t['<C-f>'] = { 'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '450' } }
	t['<C-y>'] = { 'scroll', { '-0.10', 'false', '100' } }
	t['<C-e>'] = { 'scroll', { '0.10', 'false', '100' } }
	t['zt']    = { 'zt', { '250' } }
	t['zz']    = { 'zz', { '250' } }
	t['zb']    = { 'zb', { '250' } }
	t['gg']    = { 'scroll', { '-2*vim.api.nvim_buf_line_count(0)', 'true', '1', [['sine']] } }
	t['G']     = { 'scroll', { '2*vim.api.nvim_buf_line_count(0)', 'true', '1', [['sine']] } }
	require('neoscroll.config').set_mappings(t)
end

function config.which_key()
	require("which-key").setup {
		window = {
			border = { '', '▔', '', '', '', ' ', '', '' },
			margin = { 0, 0, 1, 0 },
			padding = { 0, 0, 0, 0 },
		},
	}
end

function config.toggleterm()
	require("toggleterm").setup {
		direction = 'float'
	}
end

function config.mini()
	require('mini.surround').setup()
end

function config.tree()
	local function root_label(path)
		path = path:gsub('/home/alex', ' ')
		path = path:gsub('/Users/alex', ' ')
		path = path .. '/'
		local path_len = path:len()
		local win_nr = require('nvim-tree.view').get_winnr()
		local win_width = vim.fn.winwidth(win_nr)
		if path_len > (win_width - 2) then
			local max_str = path:sub(path_len - win_width + 5)
			local pos = max_str:find '/'
			if pos then
				return '󰉒 ' .. max_str:sub(pos)
			else
				return '󰉒 ' .. max_str
			end
		end
		return path
	end

	local icons = {
		git_placement = 'after',
		modified_placement = 'after',
		padding = ' ',
		glyphs = {
			default = '󰈔',
			folder = {
				arrow_closed = '',
				arrow_open = '',
				default = ' ',
				open = ' ',
				empty = ' ',
				empty_open = ' ',
				symlink = '󰉒 ',
				symlink_open = '󰉒 ',
			},
			git = {
				deleted = '',
				unstaged = '',
				untracked = '',
				staged = '',
				unmerged = '',
			},
		},
	}

	local renderer = {
		root_folder_label = root_label,
		indent_width = 2,
		indent_markers = {
			enable = true,
			inline_arrows = true,
			icons = { corner = '╰' },
		},
		icons = icons,
	}


	local view = {
		cursorline = false,
		relativenumber = true,
		signcolumn = 'no',
		width = { max = 38, min = 38 },
	}

	local function on_attach(bufnr)
		local api = require 'nvim-tree.api'
		local function opts(desc)
			return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end
		vim.keymap.set('n', '<C-k>', '', { buffer = bufnr })
		vim.keymap.set('n', 'i', api.node.show_info_popup, opts 'Info')
		vim.keymap.set('n', '[', api.tree.change_root_to_parent, opts 'Up')
		vim.keymap.set('n', ']', api.tree.change_root_to_node, opts 'CD')
		vim.keymap.set('n', '<Tab>', api.node.open.edit, opts 'Open')
		vim.keymap.set('n', 'o', api.node.run.system, opts 'Run System')
		vim.keymap.set('n', 'a', api.fs.create, { buffer = bufnr })
		vim.keymap.set('n', 'd', api.fs.remove, { buffer = bufnr })
		vim.keymap.set('n', 'x', api.fs.cut, opts 'Cut')
		vim.keymap.set('n', 'y', api.fs.copy.filename, opts 'Copy Name')
		vim.keymap.set('n', 'p', api.fs.paste, opts 'Paste')
		vim.keymap.set('n', 'c', api.fs.copy.node, opts 'Copy')
		vim.keymap.set('n', 'r', api.fs.rename, opts 'Rename')
		vim.keymap.set('n', 'W', api.tree.collapse_all, opts 'Collapse')
		vim.keymap.set('n', 'E', api.tree.expand_all, opts 'Expand All')
	end

	require('nvim-tree').setup {
		hijack_cursor = true,
		sync_root_with_cwd = true,
		view = view,
		renderer = renderer,
		git = { ignore = false },
		diagnostics = { enable = true },
		on_attach = on_attach,
	}

	-- Set window local options.
	-- local api = require 'nvim-tree.api'
	-- local Event = api.events.Event
	-- api.events.subscribe(Event.TreeOpen, function(_)
	-- 	vim.cmd [[setlocal statuscolumn=\ ]]
	-- 	vim.cmd [[setlocal cursorlineopt=number]]
	-- 	vim.cmd [[setlocal fillchars+=vert:🮇]]
	-- 	vim.cmd [[setlocal fillchars+=horizup:🮇]]
	-- 	vim.cmd [[setlocal fillchars+=vertright:🮇]]
	-- end)
end

return config
