local config = require("plugins.ui.config")
return {
    "nvim-tree/nvim-web-devicons",
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            {
                "tiagovla/scope.nvim",
                config = function()
                    require("scope").setup()
                end
            }
        },
        event = "UIEnter",
        config = config.bufferline
    },
    {
        "AlexvZyl/nordic.nvim",
        lazy = false,
        priority = 1000,
        config = config.nordic
    },
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
            "MunifTanjim/nui.nvim",
            {
                "rcarriga/nvim-notify",
                config = config.notify
            }
        }
    }
}
