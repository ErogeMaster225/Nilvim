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
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
            { "folke/neodev.nvim", opts = {} },
        }
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
    },
    {
        "nvimtools/none-ls.nvim",
        config = config.none_ls
    },
    {
        "pmizio/typescript-tools.nvim",
        event = { "BufReadPre", "BufNewFile" },
        ft = { "typescript", "typescriptreact" },
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        config = function()
            require('typescript-tools').setup {}
        end
    },
}
