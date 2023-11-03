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

return config
