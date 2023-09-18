local g = vim.g
local opt = vim.opt

opt.laststatus = 3
opt.showmode = false
opt.fsync = false
g.clipboard = {
    name = "win32yank",
    copy = {
        ["+"] = "win32yank -i --crlf",
        ["*"] = "win32yank -i --crlf"
    },
    paste = {
        ["+"] = "win32yank -o --lf",
        ["*"] = "win32yank -o --lf"
    },
    cache_enabled = 1
}
opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4

opt.fillchars = {
    eob = " "
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
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true
opt.cmdheight = 1
-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 1000

-- disable folding on startup
opt.foldenable = false

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- hide default colorschemes
opt.wildignore:append { vim.env.VIMRUNTIME .. '/colors/*.vim' }
