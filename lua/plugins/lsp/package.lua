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
        dependencies = {
            "nvimtools/none-ls.nvim",
            { "folke/neodev.nvim", opts = {} },
        }
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        config = config.mason,
        dependencies = "nvim-telescope/telescope.nvim"
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
        config = config.mason_tool_installer
    },
    {
        "folke/trouble.nvim",
        init = function()
            require("core.helper").load_keymap("trouble")
        end,
        cmd = { "TroubleToggle", "Trouble" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {}
    },
    {
        "nvimtools/none-ls.nvim",
        config = config.none_ls
    },
    {
        'stevearc/conform.nvim',
        config = config.conform,
    },
    {
        'mfussenegger/nvim-lint',
        config = config.lint,
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    },
}
