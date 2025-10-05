local config = {}

function config.mason()
    require("mason").setup({
        ui = {
            icons = {
                package_pending = " ",
                package_installed = " ",
                package_uninstalled = " ﮊ",
            },
        },

        max_concurrent_installers = 10,
    })
end

function config.mason_tool_installer()
    require("mason-tool-installer").setup({
        ensure_installed = {
            "css-lsp",
            "emmet-language-server",
            "eslint-lsp",
            "eslint_d",
            "html-lsp",
            "json-lsp",
            "lua-language-server",
            "prettier",
            "prettierd",
            "svelte-language-server",
            "typescript-language-server",
            "vue-language-server",
        },
    })
end

function config.treesitter()
    require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "astro",
            "bash",
            "css",
            "csv",
            "diff",
            "go",
            "gomod",
            "gosum",
            "gowork",
            "html",
            "javascript",
            "jsdoc",
            "json",
            "jsonc",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "regex",
            "rust",
            "scss",
            "tsx",
            "typescript",
            "sql",
            "svelte",
            "vue",
            "zig",
        },
        highlight = {
            enable = true,
            disable = function(lang, buf)
                if vim.api.nvim_buf_line_count(buf) > 5000 then return true end
            end,
        },
        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                },
            },
        },
    })

    --set indent for jsx tsx
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "javascriptreact", "typescriptreact" },
        callback = function(opt)
            vim.bo[opt.buf].indentexpr = "nvim_treesitter#indent()"
        end,
    })
end

function config.lspconfig()
    local lspconfig = require("lspconfig")
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            require("core.helper").load_keymap("lspconfig", { buffer = args.buf })
        end,
    })
    --[[local on_attach = function(client, bufnr)
        if client.name ~= "lua_ls" then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end
        require("core.helper").load_keymap("lspconfig", { buffer = bufnr })
        if client.server_capabilities.signatureHelpProvider then
            require("erogemaster225.signature").setup(client)
        end
    end ]]
    local caps = vim.lsp.protocol.make_client_capabilities()
    local capabilities = require("blink.cmp").get_lsp_capabilities(caps)
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }
    capabilities.textDocument = {
        semanticTokens = {
            multilineTokenSupport = true,
        },
    }
    vim.lsp.config("*", { capabilities = capabilities })
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("eslint")
    vim.lsp.enable("vtsls")
    vim.diagnostic.config({ virtual_text = true })
end

function config.none_ls()
    local null_ls = require("null-ls")
    local b = null_ls.builtins
    local sources = {
        b.formatting.prettierd.with({
            filetypes = {
                "html",
                "markdown",
                "css",
                "svelte",
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
            },
        }),
        b.formatting.stylua,
        require("none-ls.code_actions.eslint_d"),
        require("none-ls.formatting.eslint_d"),
        require("none-ls.diagnostics.eslint_d"),
    }
    null_ls.setup({
        sources = sources,
    })
end

function config.lint()
    local lint = require("lint")
    lint.linters_by_ft = {
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
    }
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
            lint.try_lint()
        end,
    })
end

function config.conform()
    local conform = require("conform")
    conform.setup({
        formatters_by_ft = {
            javascript = { "eslint", "prettier" },
            javascriptreact = { "eslint", "prettier" },
            typescript = { "eslint", "prettier" },
            typescriptreact = { "eslint", "prettier" },
        },
        formatters = {
            prettier = {
                -- This will make prettier only run if a config file is found
                condition = function(ctx)
                    return vim.fs.find({
                        ".prettierrc",
                        ".prettierrc.json",
                        ".prettierrc.js",
                        "prettier.config.js",
                        "prettier.config.cjs",
                    }, { upward = true, path = ctx.filename })[1]
                end,
            },
        },
        format_on_save = function(bufnr)
            -- Disable with a global or buffer-local variable
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            return { timeout_ms = 500, lsp_format = "fallback" }
        end,
    })
    vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
            -- FormatDisable! will disable formatting just for this buffer
            vim.b.disable_autoformat = true
        else
            vim.g.disable_autoformat = true
        end
    end, {
        desc = "Disable autoformat-on-save",
        bang = true,
    })
    vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
    end, {
        desc = "Re-enable autoformat-on-save",
    })
end

return config
