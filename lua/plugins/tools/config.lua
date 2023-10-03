local config = {}

function config.telescope()
	require("telescope").setup {
		extensions = {
			file_browser = {
				hijack_netrw = true,
			},
		},
	}
	require("telescope").load_extension "file_browser"
end

return config
