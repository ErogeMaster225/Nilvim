local keymap = {}

keymap.general = {
    n = {
        [" "] = { "", desc = "Disable default space" },
        [";"] = { ":", desc = "Enter command mode", opts = { silent = false } },
        [":"] = { ";", desc = "Repeat f/t motion", opts = { silent = false } },
        ["<Esc>"] = { ":noh <CR><Esc>", desc = "Clear highlights" },
        -- switch between windows
        ["<C-h>"] = { "<C-w>h", desc = "Window left" },
        ["<C-l>"] = { "<C-w>l", desc = "Window right" },
        ["<C-j>"] = { "<C-w>j", desc = "Window down" },
        ["<C-k>"] = { "<C-w>k", desc = "Window up" },
        -- move current line in normal mode
        ["<A-j>"] = { ":m .+1<CR>==", desc = "Move current line down" },
        ["<A-k>"] = { ":m .-2<CR>==", desc = "Move current line up" },
        -- buffer jump
        ["<leader>["] = { "<cmd> bp <CR>", desc = "Jump to next buffer" },
        ["<leader>]"] = { "<cmd> bn <CR>", desc = "Jump to previous buffer" },
        -- save
        ["<C-s>"] = { "<cmd> w <CR>", desc = "Save file" },
        -- Select all
        ["<C-a>"] = { "ggVG", desc = "Select whole file" },
        -- Copy all
        ["<C-c>"] = { "<cmd> %y+ <CR>", desc = "Copy whole file" },
        -- Yank till end of line
        ["Y"] = { "y$", desc = "Yank till end of line" },
        -- close buffer
        ["<leader>q"] = { "<cmd> bd <CR>", desc = "Close buffer" },
        -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
        -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
        -- empty mode is same as using <cmd> :map
        -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
        --[[  ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down" },
        ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up" },
        ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up" },
        ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down" }, ]]
        -- d is for delete
        ["x"] = { "\"_x", desc = "Delete character" },
        ["X"] = { "\"_X", desc = "Delete character before" },
        ["d"] = { "\"_d", desc = "Delete with motion" },
        ["D"] = { "\"_D", desc = "Delete till end of line" },
        ["<leader>d"] = { "\"*d", desc = "Cut with motion" },
        ["<leader>D"] = { "\"*D", desc = "Cut till end of line" },
    },
    i = {
        -- navigate within insert mode
        ["<C-h>"] = { "<Left>", desc = "Move left" },
        ["<C-l>"] = { "<Right>", desc = "Move right" },
        ["<C-j>"] = { "<Down>", desc = "Move down" },
        ["<C-k>"] = { "<Up>", desc = "Move up" },
        -- move current line in insert mode
        ["<A-j>"] = { "<Esc>:m .+1<CR>==gi", desc = "Move current line down" },
        ["<A-k>"] = { "<Esc>:m .-2<CR>==gi", desc = "Move current line up" },
    },
    x = {
        [" "] = { "", "Disable default space" },
        -- move multiple lines in visual mode
        ["<a-j>"] = { function()
            local line = math.max(vim.fn.line "v", vim.fn.line ".") + vim.v.count1
            line = math.min(line, vim.fn.line "$")
            return "<esc><cmd>'<,'>move" .. line .. "<cr>gv"
        end, desc = "Move multiple lines down", opts = { expr = true } },

        ["<a-k>"] = { function()
            local line = math.min(vim.fn.line "v", vim.fn.line ".") - vim.v.count1
            line = math.max(line - 1, 0)
            return "<esc><cmd>'<,'>move" .. line .. "<cr>gv"
        end, desc = "Move multiple lines up", opts = { expr = true } },
    },
    v = {
        ["d"] = { "\"_d", desc = "Delete selected" },
        ["<leader>d"] = { "\"*d", desc = "Cut selected" }
    }
}
keymap.gitsigns = {
    n = {
        ['<leader>hs'] = { require("gitsigns").stage_hunk, desc = "Stage hunk" },
        ['<leader>hr'] = { require("gitsigns").reset_hunk, desc = "Reset hunk" },
        ['<leader>hS'] = { require("gitsigns").stage_buffer, desc = "Stage buffer" },
        ['<leader>hu'] = { require("gitsigns").undo_stage_hunk, desc = "Undo stage hunk" },
        ['<leader>hR'] = { require("gitsigns").reset_buffer, desc = "Reset buffer" },
        ['<leader>hp'] = { require("gitsigns").preview_hunk, desc = "Preview hunk" },
        ['<leader>hb'] = { function() require("gitsigns").blame_line { full = true } end,
            desc = "Show git blame in float window" },
        ['<leader>hd'] = { require("gitsigns").diffthis, desc = "Diff this" },
        ['<leader>hD'] = { function() require("gitsigns").diffthis('~1') end, desc = "Diff with last commit" },
        ['<leader>td'] = { require("gitsigns").toggle_deleted, desc = "Toggle deleted" },
        [']c'] = {
            function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() require("gitsigns").next_hunk() end)
                return '<Ignore>'
            end,
            desc = "Jump to next hunk",
            opts = { expr = true } },

        ['[c'] = {
            function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() require("gitsigns").prev_hunk() end)
                return '<Ignore>'
            end,
            desc = "Jump to previous hunk",
            opts = { expr = true } }
    },
    v = {
        ['<leader>hr'] = { function() require("gitsigns").reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            desc = "Reset selected hunk" },
        ['<leader>hs'] = { function() require("gitsigns").stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            desc = "Stage selected hunk" },
    }
}
keymap.lspconfig = {
    -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions
    n = {
        ["<leader>fm"] = {
            function()
                local clients = {}
                for _, tbl in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
                    local name = tbl.name
                    table.insert(clients, name)
                end
                vim.ui.select(clients, {
                    prompt = 'Choose a formatter:'
                }, function(choice)
                    vim.lsp.buf.format {
                        filter = function(client)
                            return client.name == choice
                        end,
                        async = true
                    }
                end)
            end,
            desc = "LSP format",
        },

        ["gD"] = {
            function()
                vim.lsp.buf.declaration()
            end,
            desc = "LSP declaration",
        },

        ["gd"] = {
            function()
                vim.lsp.buf.definition()
            end,
            desc = "LSP definition",
        },

        ["K"] = {
            function()
                vim.lsp.buf.hover()
            end,
            desc = "LSP hover",
        },

        ["gi"] = {
            function()
                vim.lsp.buf.implementation()
            end,
            desc = "LSP implementation",
        },

        ["<leader>ls"] = {
            function()
                vim.lsp.buf.signature_help()
            end,
            desc = "LSP signature help",
        },

        ["<leader>D"] = {
            function()
                vim.lsp.buf.type_definition()
            end,
            desc = "LSP definition type",
        },

        ["<leader>ca"] = {
            function()
                vim.lsp.buf.code_action()
            end,
            desc = "LSP code action",
        },

        ["gr"] = {
            function()
                vim.lsp.buf.references()
            end,
            desc = "LSP references",
        },

        ["<leader>fd"] = {
            function()
                vim.diagnostic.open_float { border = "rounded" }
            end,
            desc = "Floating diagnostic",
        },

        ["[d"] = {
            function()
                vim.diagnostic.goto_prev { float = { border = "rounded" } }
            end,
            desc = "Goto prev",
        },

        ["]d"] = {
            function()
                vim.diagnostic.goto_next { float = { border = "rounded" } }
            end,
            desc = "Goto next",
        },

        ["<leader>q"] = {
            function()
                vim.diagnostic.setloclist()
            end,
            desc = "Diagnostic setloclist",
        },

        ["<leader>wa"] = {
            function()
                vim.lsp.buf.add_workspace_folder()
            end,
            desc = "Add workspace folder",
        },

        ["<leader>wr"] = {
            function()
                vim.lsp.buf.remove_workspace_folder()
            end,
            desc = "Remove workspace folder",
        },

        ["<leader>wl"] = {
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            desc = "List workspace folders",
        },
    },

    v = {
        ["<leader>ca"] = {
            function()
                vim.lsp.buf.code_action()
            end,
            desc = "LSP code action",
        },
    },
}

keymap.telescope = {
    n = {
        ["<C-p>"] = { "<cmd>Telescope find_files<CR>", desc = "Telescope file search" },
        ["<leader>F"] = { "<cmd>Telescope live_grep<CR>", desc = "Telescope grep" },
        ["<F5>"] = { "<cmd>Telescope file_browser<CR>", desc = "Telescope file browser"}
    }
}

keymap.toggleterm = {
    n = {
        ["<leader>tt"] = {
            function()
                vim.cmd(":ToggleTerm " .. (vim.v.count > 0 and vim.v.count or ""))
            end,
            desc = "Toggle terminal" }
    }
}

keymap.trouble = {
    n = {
        ["<leader>tb"] = { "<cmd>TroubleToggle<CR>", desc = "Toggle Trouble" }
    }
}
return keymap
