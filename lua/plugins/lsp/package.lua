local config = require("plugins.lsp.config")

return {
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
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
        config = config.none_ls,
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
        }
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
