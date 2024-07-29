local g = vim.g
local opt = vim.opt
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

opt.laststatus = 3
opt.showmode = false
opt.fsync = false
opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.numberwidth = 6
opt.statuscolumn = " %s%=%{v:relnum?v:relnum:v:lnum}%= ▎ "
-- Use space as leader key
g.mapleader = " "

-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4

opt.fillchars = {
    eob = " ",
    fold = " ",
    diff = "╱",
}
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

opt.signcolumn = "yes"
opt.splitkeep = "screen"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true
opt.cmdheight = 1
-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 1000

-- disable folding on startup
opt.foldenable = true
opt.foldcolumn = "1" -- '0' is not bad
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

-- disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

local group = augroup("TabWidth", { clear = false })
autocmd({ "BufRead", "BufNewFile" }, {
    group = group,
    pattern = "~/workspace/*",
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.tabstop = 2
        vim.bo.softtabstop = 2
    end,
})
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end
-- Add binaries from mason.nvim to path
vim.env.PATH = vim.fn.stdpath("data")
    .. "/mason/bin"
    .. (require("core.helper").is_win and ";" or ":")
    .. vim.env.PATH
-- hide default colorschemes
opt.wildignore:append({ vim.env.VIMRUNTIME .. "/colors/*.vim" })
