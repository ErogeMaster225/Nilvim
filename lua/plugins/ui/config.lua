local config = {}

function config.nordic()
    local palette = require("nordic.colors")
    local nordic = require("nordic")
    nordic.setup({
        cursorline = {
            bold = true,
        },
        on_highlight = function(highlights, palette)
            highlights.TelescopePromptNormal = {
                bg = palette.black0,
            }
            highlights.TelescopePromptBorder = {
                bg = palette.black0,
                fg = palette.black0,
            }
            highlights.TelescopePromptPrefix = {
                bg = palette.black0,
            }
            highlights.TelescopeResultsBorder = {
                bg = palette.black1,
                fg = palette.black1,
            }
            highlights.TelescopeResultsTitle = {
                bg = palette.green.base,
            }
            highlights.TelescopeResultsNormal = {
                bg = palette.black1,
            }
            highlights.TelescopePreviewBorder = {
                bg = palette.black1,
                fg = palette.black1,
            }
            highlights.TelescopePreviewNormal = {
                bg = palette.black1,
            }
            highlights.NoiceCmdlinePopupTitle = {
                bg = palette.blue2,
                fg = palette.black0,
            }
            highlights.NoicePopupBorder = {
                bg = palette.black1,
                fg = palette.black1,
            }
            highlights.NoicePopupmenu = {
                bg = palette.black0,
            }
            highlights.NoicePopupmenuBorder = {
                bg = palette.black0,
            }
            highlights.NoiceScrollbar = {
                bg = palette.black0,
            }
            highlights.NoicePopupmenuSelected = {
                fg = palette.yellow.base,
                bg = palette.gray0,
            }
            highlights.DiagnosticUnderlineError = {
                undercurl = false,
            }
            highlights.DiagnosticUnderlineWarn = {
                undercurl = false,
            }
            highlights.DiagnosticUnderlineInfo = {
                undercurl = false,
            }
            highlights.DiagnosticUnderlineHint = {
                undercurl = false,
            }
        end,
    })
    nordic.load()
end

function config.indent_blankline()
    local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
    }
    local hooks = require("ibl.hooks")
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)
    local rainbow_delimiters = require("rainbow-delimiters")
    vim.g.rainbow_delimiters = {
        query = {
            [""] = "rainbow-delimiters",
            lua = "rainbow-blocks",
        },
        highlight = highlight,
    }
    require("ibl").setup({ indent = { highlight = highlight }, scope = { enabled = false } })

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

function config.gitsigns()
    local opts = {
        signs = {
            add = { text = "│" },
            change = { text = "│" },
            delete = { text = "󰍵" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "│" },
        },
        current_line_blame = true,
        current_line_blame_opts = {
            delay = 500,
        },
        on_attach = function(bufnr)
            require("core.helper").load_keymap("gitsigns", { buffer = bufnr })
        end,
    }
    require("gitsigns").setup(opts)
end

function config.feline()
    local feline = require("feline")
    local theme = {
        aqua = "#7AB0DF",
        bg = "#1C212A",
        blue = "#5FB0FC",
        cyan = "#70C0BA",
        darkred = "#FB7373",
        fg = "#C7C7CA",
        gray = "#222730",
        green = "#79DCAA",
        lime = "#54CED6",
        orange = "#FFD064",
        pink = "#D997C8",
        purple = "#C397D8",
        red = "#F87070",
        yellow = "#FFE59E",
    }

    vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", fg = "#7AB0DF" })

    local mode_theme = {
        ["NORMAL"] = theme.green,
        ["OP"] = theme.cyan,
        ["INSERT"] = theme.aqua,
        ["VISUAL"] = theme.yellow,
        ["LINES"] = theme.darkred,
        ["BLOCK"] = theme.orange,
        ["REPLACE"] = theme.purple,
        ["V-REPLACE"] = theme.pink,
        ["ENTER"] = theme.pink,
        ["MORE"] = theme.pink,
        ["SELECT"] = theme.darkred,
        ["SHELL"] = theme.cyan,
        ["TERM"] = theme.lime,
        ["NONE"] = theme.gray,
        ["COMMAND"] = theme.blue,
    }

    local modes = setmetatable({
        ["n"] = "N",
        ["no"] = "N",
        ["v"] = "V",
        ["V"] = "VL",
        [""] = "VB",
        ["s"] = "S",
        ["S"] = "SL",
        [""] = "SB",
        ["i"] = "I",
        ["ic"] = "I",
        ["R"] = "R",
        ["Rv"] = "VR",
        ["c"] = "C",
        ["cv"] = "EX",
        ["ce"] = "X",
        ["r"] = "P",
        ["rm"] = "M",
        ["r?"] = "C",
        ["!"] = "SH",
        ["t"] = "T",
    }, {
        __index = function()
            return "-"
        end,
    })

    local component = {}

    component.vim_mode = {
        provider = function()
            return modes[vim.api.nvim_get_mode().mode]
        end,
        hl = function()
            return {
                fg = "bg",
                bg = require("feline.providers.vi_mode").get_mode_color(),
                style = "bold",
                name = "NeovimModeHLColor",
            }
        end,
        left_sep = "block",
        right_sep = "block",
    }

    component.git_branch = {
        provider = "git_branch",
        hl = {
            fg = "fg",
            bg = "bg",
            style = "bold",
        },
        left_sep = "block",
        right_sep = "",
    }

    component.git_add = {
        provider = "git_diff_added",
        hl = {
            fg = "green",
            bg = "bg",
        },
        left_sep = "",
        right_sep = "",
    }

    component.git_delete = {
        provider = "git_diff_removed",
        hl = {
            fg = "red",
            bg = "bg",
        },
        left_sep = "",
        right_sep = "",
    }

    component.git_change = {
        provider = "git_diff_changed",
        hl = {
            fg = "purple",
            bg = "bg",
        },
        left_sep = "",
        right_sep = "",
    }

    component.separator = {
        provider = "",
        hl = {
            fg = "bg",
            bg = "bg",
        },
    }

    component.diagnostic_errors = {
        provider = "diagnostic_errors",
        hl = {
            fg = "red",
        },
    }

    component.diagnostic_warnings = {
        provider = "diagnostic_warnings",
        hl = {
            fg = "yellow",
        },
    }

    component.diagnostic_hints = {
        provider = "diagnostic_hints",
        hl = {
            fg = "aqua",
        },
    }

    component.diagnostic_info = {
        provider = "diagnostic_info",
    }

    component.lsp = {
        provider = function()
            if not rawget(vim, "lsp") then return "" end

            local progress = vim.lsp.status()
            if vim.o.columns < 120 then return "" end

            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if #clients ~= 0 then
                if progress then
                    local spinners = {
                        "◜ ",
                        "◠ ",
                        "◝ ",
                        "◞ ",
                        "◡ ",
                        "◟ ",
                    }
                    local ms = vim.loop.hrtime() / 1000000
                    local frame = math.floor(ms / 120) % #spinners
                    local content = string.format("%%<%s", spinners[frame + 1])
                    return content or ""
                else
                    return "לּ LSP"
                end
            end
            return ""
        end,
        hl = function()
            local progress = vim.lsp.status()
            return {
                fg = progress and "yellow" or "green",
                bg = "gray",
                style = "bold",
            }
        end,
        left_sep = "",
        right_sep = "block",
    }

    component.file_type = {
        provider = {
            name = "file_type",
            opts = {
                filetype_icon = true,
            },
        },
        hl = {
            fg = "fg",
            bg = "gray",
        },
        left_sep = "block",
        right_sep = "block",
    }

    component.scroll_bar = {
        provider = function()
            local chars = setmetatable({
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
            }, {
                __index = function()
                    return " "
                end,
            })
            local line_ratio = vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0)
            local position = math.floor(line_ratio * 100)

            local icon = chars[math.floor(line_ratio * #chars)] .. position
            if position <= 5 then
                icon = " TOP"
            elseif position >= 95 then
                icon = " BOT"
            end
            return icon
        end,
        hl = function()
            local position =
                math.floor(vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0) * 100)
            local fg
            local style

            if position <= 5 then
                fg = "aqua"
                style = "bold"
            elseif position >= 95 then
                fg = "red"
                style = "bold"
            else
                fg = "purple"
                style = nil
            end
            return {
                fg = fg,
                style = style,
                bg = "bg",
            }
        end,
        left_sep = "block",
        right_sep = "block",
    }

    local left = {}
    local middle = {}
    local right = {
        component.vim_mode,
        component.file_type,
        component.lsp,
        component.git_branch,
        component.git_add,
        component.git_delete,
        component.git_change,
        component.separator,
        component.diagnostic_errors,
        component.diagnostic_warnings,
        component.diagnostic_info,
        component.diagnostic_hints,
        component.scroll_bar,
    }

    local components = {
        active = { left, middle, right },
    }

    feline.setup({
        components = components,
        theme = theme,
        vi_mode_colors = mode_theme,
    })
end

function config.bufferline()
    local Offset = require("bufferline.offset")
    if not Offset.edgy then
        local get = Offset.get
        Offset.get = function()
            if package.loaded.edgy then
                local layout = require("edgy.config").layout
                local ret = { left = "", left_size = 0, right = "", right_size = 0 }
                for _, pos in ipairs({ "left", "right" }) do
                    local sb = layout[pos]
                    if sb and #sb.wins > 0 then
                        local title = " Sidebar" .. string.rep(" ", sb.bounds.width - 8)
                        ret[pos] = "%#EdgyTitle#" .. title .. "%*" .. "%#WinSeparator#│%*"
                        ret[pos .. "_size"] = sb.bounds.width
                    end
                end
                ret.total_size = ret.left_size + ret.right_size
                if ret.total_size > 0 then
                    return ret
                end
            end
            return get()
        end
        Offset.edgy = true
    end
    require("bufferline").setup({
        options = {
            mode = "buffers",
            numbers = "ordinal",
            middle_mouse_command = nil,
            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local icon = level:match("error") and " " or " "
                return " " .. icon .. count
            end,
            separator_style = "thin",
            hover = {
                enabled = true,
                delay = 200,
                reveal = { "close" },
            },
        },
    })
end

function config.noice()
    require("noice").setup({
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = true,         -- use a classic bottom cmdline for search
            command_palette = true,       -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false,           -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
        views = {
            cmdline_popupmenu = {
                border = {
                    style = "none",
                    padding = { 1, 2 },
                },
                filter_options = {},
                win_options = {
                    winhighlight = {
                        NormalFloat = "NoicePopupmenu",
                        FloatBorder = "NoicePopupmenuBorder",
                        PmenuSel = "NoicePopupmenuSelected",
                    },
                },
                scrollbar = false,
            },
        },
        routes = {
            {
                view = "mini",
                filter = { event = "msg_showmode" },
            },
        },
    })
end

function config.notify()
    vim.notify = require("notify")
    vim.notify.setup({
        fps = 60,
    })
end

function config.edgy()
    require("edgy").setup({
        animate = {
            enabled = false
        },
        left = {
            {
                ft = "NvimTree",
                title = nil,
            }
        }
    })
end

return config
