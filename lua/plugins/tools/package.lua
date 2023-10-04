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
        config = config.telescope,
        dependencies = {
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-fzy-native.nvim"
        }
    },
    { "folke/neodev.nvim", opts = {} },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async"
    }
}
