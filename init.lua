-- Compile lua to bytecode if the nvim version supports it.
if vim.loader and vim.fn.has("nvim-0.9.1") == 1 then vim.loader.enable() end

local function setup_fnm_env()
    -- Execute fnm env for PowerShell and capture output
    local handle = io.popen("fnm env --shell powershell 2>nul")

    if not handle then return end

    local fnm_env_output = handle:read("*a")
    handle:close()

    if fnm_env_output == "" then return end

    -- Parse the output to extract environment variables
    for line in fnm_env_output:gmatch("[^\r\n]+") do
        -- Look for PowerShell env statements like: $env:PATH = "C:\path\to\fnm;$env:PATH"
        local key, value = line:match('%$env:([%w_]+)%s*=%s*"([^"]+)"')

        if key and value then
            -- Handle PATH specially - expand $env:PATH
            if key == "PATH" then value = value:gsub("%$env:PATH", vim.env.PATH or "") end

            -- Set the environment variable in Neovim
            vim.env[key] = value
        end
    end
end
if vim.g.neovide then
    vim.o.guifont = "0xProto,termicons,JetBrainsMono Nerd Font Propo:h14"
    -- Run the setup
    setup_fnm_env()
    vim.keymap.set({ 'n' }, '<F11>',
        function()
            if vim.g.neovide_fullscreen == false then
                vim.g.neovide_fullscreen = true
            else
                vim.g.neovide_fullscreen = false
            end
        end,
        { silent = true }
    )
end

require("core")
