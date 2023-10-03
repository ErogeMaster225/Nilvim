local config = require("plugins.ui.config")
return {
	"nvim-tree/nvim-web-devicons",
	{
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		event = "UIEnter",
		config = config.bufferline
	},
	{ "Everblush/nvim", name = "everblush" },
	{
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		config = config.gitsigns
	},
	{
		"freddiehaddad/feline.nvim",
		event = "UIEnter",
		config = config.feline
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		config = config.indent_blankline,
		dependencies = "HiPhish/rainbow-delimiters.nvim"
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = config.noice,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify"
		}
	}
}
