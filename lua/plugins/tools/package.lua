local config = require("plugins.tools.config")

return {
    "nvim-lua/plenary.nvim",
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = config.which_key,
    },
    {
        "nvim-telescope/telescope.nvim",
        opts = {},
        cmd = "Telescope",
        init = function()
            require('core.helper').load_keymap('telescope')
        end,
        config = config.telescope,
        dependencies = {
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-fzy-native.nvim",
            "nvim-telescope/telescope-ui-select.nvim"
        }
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async"
    },
    {
        "karb94/neoscroll.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = config.neoscroll,
    },
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('Comment').setup {}
        end
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            {
                "S",
                mode = { "n", "x", "o" },
                function() require("flash").treesitter() end,
                desc =
                "Flash Treesitter"
            },
            {
                "r",
                mode = "o",
                function() require("flash").remote() end,
                desc =
                "Remote Flash"
            },
            {
                "R",
                mode = { "o", "x" },
                function() require("flash").treesitter_search() end,
                desc =
                "Treesitter Search"
            },
            {
                "<c-s>",
                mode = { "c" },
                function() require("flash").toggle() end,
                desc =
                "Toggle Flash Search"
            },
        },
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = config.toggleterm
    }
}
