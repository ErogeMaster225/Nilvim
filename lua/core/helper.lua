local helper = {}
local merge_tb = vim.tbl_deep_extend
helper.is_win = package.config:sub(1, 1) == "\\" and true or false
helper.path_sep = is_win and "\\" or "/"

function helper.path_join(...)
    return table.concat({ ... }, helper.path_sep)
end

function helper.data_path()
    return vim.fn.stdpath("data")
end

function helper.config_path()
    return vim.fn.stdpath("config")
end

local function exists(file)
    local ok, _, code = os.rename(file, file)
    if not ok then
        if code == 13 then return true end
    end
    return ok
end

--- Check if a directory exists in this path
function helper.isdir(path)
    return exists(path .. "/")
end

function helper.load_keymap(group, mapping_opts)
    vim.schedule(function()
        local mappings = require("core.keymap")[group]
        local default_opts =
            merge_tb("force", { silent = true, noremap = true }, mapping_opts or {})
        for mode, mode_values in pairs(mappings) do
            for keybind, mapping_info in pairs(mode_values) do
                local opts = merge_tb("force", default_opts, mapping_info.opts or {})
                opts.desc = mapping_info.desc or nil
                vim.keymap.set(mode, keybind, mapping_info[1], opts)
            end
        end
    end)
end

return helper
