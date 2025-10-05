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
            "nvim-telescope/telescope-ui-select.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
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
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
            opts = { enable_autocmd = false }
        },
        config = function()
            require("Comment").setup({
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
            })
        end,
    },
    { "nvzone/showkeys", cmd = "ShowkeysToggle" },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            dim = { enabled = true },
            -- indent = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true, layout = {
                reverse = true,
                layout = {
                  box = "horizontal",
                  backdrop = false,
                  width = 0.8,
                  height = 0.9,
                  border = "none",
                  {
                    box = "vertical",
                    { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
                    { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
                  },
                  {
                    win = "preview",
                    title = "{preview:Preview}",
                    width = 0.45,
                    border = "rounded",
                    title_pos = "center",
                  },
                },
            } },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scroll = {
                enabled = true,
                animate = {
                    duration = {
                        step = 15,
                        total = 500,
                    },
                    easing = "outCirc",
                },
            },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    -- stylua: ignore start
                    Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
                    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                    Snacks.toggle.option("cursorline", { name = "Cursorline" }):map("<leader>uC")
                    Snacks.toggle.diagnostics():map("<leader>ud")
                    Snacks.toggle.option("conceallevel",
                        { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
                    Snacks.toggle.inlay_hints():map("<leader>uh")
                    Snacks.toggle.dim():map("<leader>uD")
                    -- stylua: ignore end
                end,
            })
            require("core.helper").load_keymap("snacks")
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
    {
        "olimorris/persisted.nvim",
        event = "BufReadPre", -- Ensure the plugin loads only when a buffer has been loaded
        opts = {},
    },
    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = {},
    },
    {
        "stevearc/overseer.nvim",
        opts = {},
    },
    {
        'MagicDuck/grug-far.nvim',
        config = function()
            -- optional setup call to override plugin options
            -- alternatively you can set options with vim.g.grug_far = { ... }
            require('grug-far').setup({
                -- options, see Configuration section below
                -- there are no required options atm
            });
        end
    },
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        dependencies = {
            "saghen/blink.cmp"
        },
    },
}
