local config = require("plugins.ui.config")
return {
    "nvim-tree/nvim-web-devicons",
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            {
                "tiagovla/scope.nvim",
                config = function()
                    require("scope").setup()
                end,
            },
        },
        event = "UIEnter",
        config = config.bufferline,
    },
    {
        "AlexvZyl/nordic.nvim",
        lazy = false,
        priority = 1000,
        config = config.nordic,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        config = config.gitsigns,
    },
    {
        "adpce/feline.nvim",
        event = "UIEnter",
        config = config.feline,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        config = config.indent_blankline,
        dependencies = "HiPhish/rainbow-delimiters.nvim",
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = config.noice,
    },
    {
        "folke/twilight.nvim",
        event = "VeryLazy",
        opts = {
            expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
                "function",
                "method",
                "table",
                "if_statement",
                "field",
            },
        },
    },
    {
        "stevearc/oil.nvim",
        event = "VeryLazy",
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "stevearc/aerial.nvim",
        opts = {},
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
    },
    {
        "folke/edgy.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>ue",
                function()
                    require("edgy").toggle()
                end,
                desc = "Edgy Toggle",
            },
            -- stylua: ignore
            { "<leader>uE", function() require("edgy").select() end, desc = "Edgy Select Window" },
        },
        config = config.edgy,
    },
}
