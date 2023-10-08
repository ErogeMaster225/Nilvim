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
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
		require("core.helper").load_keymap("lspconfig", { buffer = bufnr })
		if client.server_capabilities.signatureHelpProvider then
			require("erogemaster225.signature").setup(client)
		end
	end
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem = {
		documentationFormat = { "markdown", "plaintext" },
		snippetSupport = true,
		preselectSupport = true,
		insertReplaceSupport = true,
		labelDetailsSupport = true,
		deprecatedSupport = true,
		commitCharactersSupport = true,
		tagSupport = { valueSet = { 1 } },
		resolveSupport = {
			properties = {
				"documentation",
				"detail",
				"additionalTextEdits",
			},
		},
	}
	lspconfig.lua_ls.setup {
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			Lua = {
				workspace = {
					checkThirdParty = false,
				},
				completion = {
					callSnippet = "Replace",
				},
			},
		},
	}
	lspconfig.emmet_language_server.setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end

function config.none_ls()
	local null_ls = require("null-ls")
	local b = null_ls.builtins
	local sources = {
		b.formatting.stylua,
		b.formatting.prettier.with {
			filetypes = { "html", "markdown", "css" },
		},
		b.formatting.deno_fmt,
	}
	null_ls.setup({
		sources = sources,
	})
end

return config
