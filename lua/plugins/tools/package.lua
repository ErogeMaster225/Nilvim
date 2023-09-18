return {
    "nvim-lua/plenary.nvim",
    {
        "nvim-tree/nvim-tree.lua",
        opts = {},
        cmd = "NvimTreeToggle",
        dependencies = "nvim-tree/nvim-web-devicons"
    },
    "folke/which-key.nvim",
    {
        "nvim-telescope/telescope.nvim",
        opts = {},
        cmd = "Telescope"
    },
    {"folke/neodev.nvim", opts = {}},
    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async"
    }
}
