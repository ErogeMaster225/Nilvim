return {
    settings = {
        Lua = {
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = 2,
                },
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
                    "missing-fields",
                },
            },
        },
    },
}
