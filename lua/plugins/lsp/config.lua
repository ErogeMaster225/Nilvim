local config = {}

function config.mason()
    require("mason").setup({
        ui = {
            icons = {
                package_pending = " ",
                package_installed = " ",
                package_uninstalled = " ﮊ",
            }
        },

        max_concurrent_installers = 10,
    })
end

function config.mason_tool_installer()
    require('mason-tool-installer').setup {
        ensure_installed = {
            'css-lsp',
            'emmet-language-server',
            'eslint-lsp',
            'eslint_d',
            'html-lsp',
            'json-lsp',
            'lua-language-server',
            'prettier',
            'prettierd',
            'svelte-language-server',
            'typescript-language-server',
            'vue-language-server',
        }
    }
end

function config.treesitter()
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    require('nvim-treesitter.configs').setup({
        ensure_installed = {
            'astro',
            'bash',
            'css',
            'csv',
            'diff',
            'go',
            'gomod',
            'gosum',
            'gowork',
            'html',
            'javascript',
            'jsdoc',
            'json',
            'jsonc',
            'lua',
            'markdown',
            'markdown_inline',
            'python',
            'rust',
            'scss',
            'tsx',
            'typescript',
            'sql',
            'svelte',
            'vue',
            'zig',
        },
        highlight = {
            enable = true,
            disable = function(lang, buf)
                if vim.api.nvim_buf_line_count(buf) > 5000 then
                    return true
                end
            end,
        },
        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                },
            },
        },
    })

    --set indent for jsx tsx
    vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'javascriptreact', 'typescriptreact' },
        callback = function(opt)
            vim.bo[opt.buf].indentexpr = 'nvim_treesitter#indent()'
        end,
    })
end

function config.lspconfig()
    local lspconfig = require('lspconfig')
    local on_attach = function(client, bufnr)
        if client.name ~= 'lua_ls' then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end
        require("core.helper").load_keymap("lspconfig", { buffer = bufnr })
        --[[ if client.server_capabilities.signatureHelpProvider then
            require("erogemaster225.signature").setup(client)
        end ]]
    end
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    lspconfig.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                format = {
                    enable = true,
                    defaultConfig = {
                        indent_style = "space",
                        indent_size = 2,
                    }
                },
                workspace = {
                    checkThirdParty = false,
                },
                completion = {
                    callSnippet = "Replace",
                },
                diagnostics = {
                    disable = {
                        "undefined-global",
                        "missing-fields"
                    }
                }
            },
        },
    }
    lspconfig.emmet_language_server.setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
    lspconfig.svelte.setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
    require('typescript-tools').setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

function config.none_ls()
    local null_ls = require("null-ls")
    local b = null_ls.builtins
    local sources = {
        b.formatting.prettierd.with {
            filetypes = { "html", "markdown", "css", "svelte", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        },
        b.code_actions.eslint_d,
        b.formatting.eslint_d,
        b.diagnostics.eslint_d
    }
    null_ls.setup({
        sources = sources,
    })
end

function config.lint()
    local lint = require('lint')
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
    local conform = require('conform')
    conform.setup({
        formatters_by_ft = {
            javascript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescript = { "eslint_d" },
            typescriptreact = { "eslint_d" },
        },
        --[[ format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 5000,
            lsp_fallback = true,
        }, ]]
    })
end

return config
