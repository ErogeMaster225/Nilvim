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

return config
