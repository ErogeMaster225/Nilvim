local config = {}

function config.telescope()
    require("telescope").setup({
        defaults = {
            vimgrep_arguments = {
                "rg",
                "-L",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--trim",
                "--fixed-strings",
            },
            prompt_prefix = "   ",
            selection_caret = "  ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.55,
                    results_width = 0.8,
                },
                vertical = {
                    mirror = false,
                },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
            },
            file_ignore_patterns = { "node_modules" },
            path_display = { "truncate" },
            winblend = 0,
            border = {},
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            color_devicons = true,
            set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
            file_previewer = require("telescope.previewers").vim_buffer_cat.new,
            grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
            qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
            -- Developer configurations: Not meant for general override
            buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
            mappings = {
                n = { ["q"] = require("telescope.actions").close },
            },
        },
        pickers = {
            find_files = {
                find_command = {
                    "rg",
                    "--files",
                    "--hidden",
                    "--path-separator",
                    "/",
                    "--glob",
                    "!**/.git/*",
                },
            },
        },
        extensions = {
            file_browser = {
                hijack_netrw = true,
            },
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
        },
    })
    require("telescope").load_extension("file_browser")
    require("telescope").load_extension("persisted")
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
end

function config.which_key()
    require("which-key").setup({
        win = {
            border = { "", "▔", "", "", "", " ", "", "" },
            padding = { 0, 0, 0, 0 },
        },
    })
end

function config.toggleterm()
    require("toggleterm").setup({
        direction = "float",
    })
end

function config.mini()
    require("mini.surround").setup()
end

function config.neotree()
    require("neo-tree").setup({
        hide_root_node = true,
        retain_hidden_root_indent = true,
        filesystem = {
            filtered_items = {
                show_hidden_count = false,
                hide_dotfiles = false,
                never_show = {
                    ".DS_Store",
                },
            },
            follow_current_file = {
                enabled = true,
            },
        },
        default_component_configs = {
            indent = {
                with_expanders = true,
                expander_collapsed = "",
                expander_expanded = "",
            },
        },
        window = {
            mappings = {
                ["<space>"] = {
                    "toggle_node",
                    nowait = true, -- disable `nowait` if you have existing combos starting with this char that you want to use
                },
            },
        },
        nesting_rules = require("neotree-file-nesting-config").nesting_rules,
    })
end

return config
