require("core.options")
require("core.clipboard")
require("core.helper").load_keymap("general")
require("core.plugins")
vim.api.nvim_create_user_command("LuaBuf", function(opts)
    -- Run the Lua code the user typed
    local chunk, err = load("return " .. opts.args)
    local ok, result
    if chunk then
        ok, result = pcall(chunk)
    else
        -- If adding "return" failed (e.g. statement not expression), try plain code
        chunk, err = load(opts.args)
        if chunk then
            ok, result = pcall(chunk)
        end
    end

    local output
    if not ok then
        output = "Error: " .. (result or err)
    else
        output = vim.pretty_print(result)
    end

    -- Create scratch buffer
    local buf = vim.api.nvim_create_buf(true, true)
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].swapfile = false

    local lines = vim.split(output, "\n", { plain = true })

    vim.cmd("split") -- open in horizontal split
    vim.api.nvim_win_set_buf(0, buf)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end, {
    nargs = "+",
    complete = "lua",
})
local telescope = require("telescope.builtin")

-- Define a custom command to search Neovim config folder
vim.api.nvim_create_user_command("FindConfigFiles", function()
    telescope.find_files({
        prompt_title = "< Neovim Config Files >",
        cwd = vim.fn.stdpath("config"), -- This is the Neovim config folder
    })
end, {})
