local plugins = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-tree.lua",
    { 'Everblush/nvim', name = 'everblush' }
}
require('lazy').setup(plugins, lazy_config)
