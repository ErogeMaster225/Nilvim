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
            require("core.helper").load_keymap("telescope")
        end,
        config = config.telescope,
        dependencies = {
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-fzy-native.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
    },
    {
        "kevinhwang91/nvim-ufo",
        lazy = false,
        dependencies = "kevinhwang91/promise-async",
        config = function()
            require("ufo").setup()
            require("core.helper").load_keymap("ufo")
        end,
    },
    {
        "karb94/neoscroll.nvim",
        -- event = { "BufReadPre", "BufNewFile" },
        config = config.neoscroll,
    },
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("Comment").setup({})
        end,
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "x", "o" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Treesitter Search",
            },
            {
                "<c-s>",
                mode = { "c" },
                function()
                    require("flash").toggle()
                end,
                desc = "Toggle Flash Search",
            },
        },
    },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        init = function()
            require("core.helper").load_keymap("toggleterm")
        end,

        cmd = "ToggleTerm",
        config = config.toggleterm,
    },
    {
        "Darazaki/indent-o-matic",
        event = "VeryLazy",
        config = function()
            require("indent-o-matic").setup({
                max_lines = 2048,
                standard_widths = { 2, 4, 8 },
                skip_multiline = true,
            })
        end,
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({})
        end,
    },
    {
        "echasnovski/mini.nvim",
        event = "VeryLazy",
        config = config.mini,
    },
    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
        config = function()
            require("peek").setup({
                app = "broz",
            })
            -- refer to `configuration to change defaults`
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        init = function()
            require("core.helper").load_keymap("tree")
        end,
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            "saifulapm/neotree-file-nesting-config",
        },
        config = config.neotree,
    },
    {
        "ldelossa/nvim-ide",
        -- event = "VeryLazy",
        lazy = true,
        config = function()
            require("ide").setup({})
        end,
    },
    {
        "sindrets/diffview.nvim",
        lazy = false,
        config = function()
            require("diffview").setup({
                enhanced_diff_hl = true,
            })
        end,
    },
}
