local config = require("plugins.lsp.config")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufRead",
		build = ":TSUpdate",
		config = config.treesitter,
		dependencies = "nvim-treesitter/nvim-treesitter-textobjects"
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = config.lspconfig,
		dependencies = "williamboman/mason.nvim"
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = config.mason
	},
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {}
	}
}
