local config = require("plugins.ui.config")
return {
	"nvim-tree/nvim-web-devicons",
	{ "Everblush/nvim", name = "everblush" },
	{
		"lewis6991/gitsigns.nvim"
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
	}
}
