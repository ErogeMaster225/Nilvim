local helper = require("core.helper")
-- lazy.nvim config
local lazy_config = {
    defaults = {
        lazy = true
    },
    ui = {
        icons = {
            ft = "",
            lazy = "鈴 ",
            loaded = "",
            not_loaded = ""
        }
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "2html_plugin",
                "tohtml",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logipat",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "matchit",
                "tar",
                "tarPlugin",
                "rrhelper",
                "spellfile_plugin",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
                "tutor",
                "rplugin",
                "syntax",
                "synmenu",
                "optwin",
                "compiler",
                "bugreport",
                "ftplugin"
            }
        }
    }
}
-- Bootstrap lazy.nvim
local lazypath = helper.data_path() .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath
        }
    )
end
vim.opt.rtp:prepend(lazypath)
-- Load plugins spec from modules
local modules_list = vim.fs.find("package.lua",
    { path = helper.path_join(helper.config_path(), "lua", "plugins"), type = "file", limit = 10 })
local modules = {}
for _, module in ipairs(modules_list) do
    local module_name = module:match("plugins/(.*)/package.lua")
    modules[_] = { import = "plugins." .. module_name .. ".package" }
end
require("lazy").setup(modules, lazy_config)
