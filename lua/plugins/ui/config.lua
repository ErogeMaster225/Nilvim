local config = {}
function config.indent_blankline()
	local highlight = {
		"RainbowRed",
		"RainbowYellow",
		"RainbowBlue",
		"RainbowOrange",
		"RainbowGreen",
		"RainbowViolet",
		"RainbowCyan"
	}
	local hooks = require "ibl.hooks"
	-- create the highlight groups in the highlight setup hook, so they are reset
	-- every time the colorscheme changes
	hooks.register(
		hooks.type.HIGHLIGHT_SETUP,
		function()
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
		end
	)

	vim.g.rainbow_delimiters = { highlight = highlight }
	require("ibl").setup { indent = { highlight = highlight } }

	hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

function config.gitsigns()
	local opts = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "󰍵" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "│" }
		}
	}
	require("gitsigns").setup(opts)
end

function config.feline()
	local feline = require "feline"
	local theme = {
		aqua = "#7AB0DF",
		bg = "#1C212A",
		blue = "#5FB0FC",
		cyan = "#70C0BA",
		darkred = "#FB7373",
		fg = "#C7C7CA",
		gray = "#222730",
		green = "#79DCAA",
		lime = "#54CED6",
		orange = "#FFD064",
		pink = "#D997C8",
		purple = "#C397D8",
		red = "#F87070",
		yellow = "#FFE59E"
	}

	vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", fg = "#7AB0DF" })

	local mode_theme = {
		["NORMAL"] = theme.green,
		["OP"] = theme.cyan,
		["INSERT"] = theme.aqua,
		["VISUAL"] = theme.yellow,
		["LINES"] = theme.darkred,
		["BLOCK"] = theme.orange,
		["REPLACE"] = theme.purple,
		["V-REPLACE"] = theme.pink,
		["ENTER"] = theme.pink,
		["MORE"] = theme.pink,
		["SELECT"] = theme.darkred,
		["SHELL"] = theme.cyan,
		["TERM"] = theme.lime,
		["NONE"] = theme.gray,
		["COMMAND"] = theme.blue,
	}

	local modes = setmetatable({
		["n"] = "N",
		["no"] = "N",
		["v"] = "V",
		["V"] = "VL",
		[""] = "VB",
		["s"] = "S",
		["S"] = "SL",
		[""] = "SB",
		["i"] = "I",
		["ic"] = "I",
		["R"] = "R",
		["Rv"] = "VR",
		["c"] = "C",
		["cv"] = "EX",
		["ce"] = "X",
		["r"] = "P",
		["rm"] = "M",
		["r?"] = "C",
		["!"] = "SH",
		["t"] = "T",
	}, { __index = function() return "-" end })

	local component = {}

	component.vim_mode = {
		provider = function() return modes[vim.api.nvim_get_mode().mode] end,
		hl = function()
			return {
				fg = "bg",
				bg = require("feline.providers.vi_mode").get_mode_color(),
				style = "bold",
				name = "NeovimModeHLColor",
			}
		end,
		left_sep = "block",
		right_sep = "block",
	}

	component.git_branch = {
		provider = "git_branch",
		hl = {
			fg = "fg",
			bg = "bg",
			style = "bold",
		},
		left_sep = "block",
		right_sep = "",
	}

	component.git_add = {
		provider = "git_diff_added",
		hl = {
			fg = "green",
			bg = "bg",
		},
		left_sep = "",
		right_sep = "",
	}

	component.git_delete = {
		provider = "git_diff_removed",
		hl = {
			fg = "red",
			bg = "bg",
		},
		left_sep = "",
		right_sep = "",
	}

	component.git_change = {
		provider = "git_diff_changed",
		hl = {
			fg = "purple",
			bg = "bg",
		},
		left_sep = "",
		right_sep = "",
	}

	component.separator = {
		provider = "",
		hl = {
			fg = "bg",
			bg = "bg",
		},
	}

	component.diagnostic_errors = {
		provider = "diagnostic_errors",
		hl = {
			fg = "red",
		},
	}

	component.diagnostic_warnings = {
		provider = "diagnostic_warnings",
		hl = {
			fg = "yellow",
		},
	}

	component.diagnostic_hints = {
		provider = "diagnostic_hints",
		hl = {
			fg = "aqua",
		},
	}

	component.diagnostic_info = {
		provider = "diagnostic_info",
	}

	component.lsp = {
		provider = function()
			if not rawget(vim, "lsp") then
				return ""
			end

			local progress = vim.lsp.status()
			if vim.o.columns < 120 then
				return ""
			end

			local clients = vim.lsp.get_active_clients({ bufnr = 0 })
			if #clients ~= 0 then
				if progress then
					local spinners = {
						"◜ ",
						"◠ ",
						"◝ ",
						"◞ ",
						"◡ ",
						"◟ ",
					}
					local ms = vim.loop.hrtime() / 1000000
					local frame = math.floor(ms / 120) % #spinners
					local content = string.format("%%<%s", spinners[frame + 1])
					return content or ""
				else
					return "לּ LSP"
				end
			end
			return ""
		end,
		hl = function()
			local progress = vim.lsp.status()
			return {
				fg = progress and "yellow" or "green",
				bg = "gray",
				style = "bold",
			}
		end,
		left_sep = "",
		right_sep = "block",
	}

	component.file_type = {
		provider = {
			name = "file_type",
			opts = {
				filetype_icon = true,
			},
		},
		hl = {
			fg = "fg",
			bg = "gray",
		},
		left_sep = "block",
		right_sep = "block",
	}

	component.scroll_bar = {
		provider = function()
			local chars = setmetatable({
				" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ",
				" ",
				" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ",
				" ",
			}, { __index = function() return " " end })
			local line_ratio = vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0)
			local position = math.floor(line_ratio * 100)

			local icon = chars[math.floor(line_ratio * #chars)] .. position
			if position <= 5 then
				icon = " TOP"
			elseif position >= 95 then
				icon = " BOT"
			end
			return icon
		end,
		hl = function()
			local position = math.floor(vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0) * 100)
			local fg
			local style

			if position <= 5 then
				fg = "aqua"
				style = "bold"
			elseif position >= 95 then
				fg = "red"
				style = "bold"
			else
				fg = "purple"
				style = nil
			end
			return {
				fg = fg,
				style = style,
				bg = "bg",
			}
		end,
		left_sep = "block",
		right_sep = "block",
	}

	local left = {}
	local middle = {}
	local right = {
		component.vim_mode,
		component.file_type,
		component.lsp,
		component.git_branch,
		component.git_add,
		component.git_delete,
		component.git_change,
		component.separator,
		component.diagnostic_errors,
		component.diagnostic_warnings,
		component.diagnostic_info,
		component.diagnostic_hints,
		component.scroll_bar,
	}

	local components = {
		active = { left, middle, right },
	}

	feline.setup({
		components = components,
		theme = theme,
		vi_mode_colors = mode_theme,
	})
end

function config.bufferline()
	require("bufferline").setup()
end

function config.noice()
	require("noice").setup({
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false,  -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = false, -- add a border to hover docs and signature help
		},
	})
end

return config
