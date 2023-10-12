local config = require("plugins.tools.config")

return {
    "nvim-lua/plenary.nvim",
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup {}
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        opts = {},
        cmd = "Telescope",
        init = function ()
            require('core.helper').load_keymap('telescope')
        end,
        config = config.telescope,
        dependencies = {
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-fzy-native.nvim"
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
    }
}
