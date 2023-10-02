local keymap = {}

keymap.general = {
    n = {
        [" "] = { "", "Disable default space" },
        [";"] = { ":", "Enter command mode", opts = { silent = false } },
        [":"] = { ";", "Repeat f/t motion", opts = { silent = false } },
        ["<Esc>"] = { ":noh <CR>", "Clear highlights" },
        -- switch between windows
        ["<C-h>"] = { "<C-w>h", "Window left" },
        ["<C-l>"] = { "<C-w>l", "Window right" },
        ["<C-j>"] = { "<C-w>j", "Window down" },
        ["<C-k>"] = { "<C-w>k", "Window up" },
        -- move current line in normal mode
        ["<A-j>"] = { ":m .+1<CR>==", "Move current line down" },
        ["<A-k>"] = { ":m .-2<CR>==", "Move current line up" },
        -- save
        ["<C-s>"] = { "<cmd> w <CR>", "Save file" },
        -- Select all
        ["<C-a>"] = { "ggVG", "Select whole file" },
        -- Copy all
        ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },
        -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
        -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
        -- empty mode is same as using <cmd> :map
        -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
        --[[  ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down" },
        ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up" },
        ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up" },
        ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down" }, ]]
        -- d is for delete
        ["x"] = { "\"_x", "Delete character" },
        ["X"] = { "\"_X", "Delete character before" },
        ["d"] = { "\"_d", "Delete with motion" },
        ["D"] = { "\"_D", "Delete till end of line" },
        ["<leader>d"] = { "\"*d", "Cut with motion" },
        ["<leader>D"] = { "\"*D", "Cut till end of line" },
    },
    i = {
        -- navigate within insert mode
        ["<C-h>"] = { "<Left>", "Move left" },
        ["<C-l>"] = { "<Right>", "Move right" },
        ["<C-j>"] = { "<Down>", "Move down" },
        ["<C-k>"] = { "<Up>", "Move up" },
        -- move current line in insert mode
        ["<A-j>"] = { "<Esc>:m .+1<CR>==gi", "Move current line down" },
        ["<A-k>"] = { "<Esc>:m .-2<CR>==gi", "Move current line up" },
    },
    x = {
        [" "] = { "", "Disable default space" },
        -- move multiple lines in visual mode
        ["<a-j>"] = { function()
            local line = math.max(vim.fn.line "v", vim.fn.line ".") + vim.v.count1
            line = math.min(line, vim.fn.line "$")
            return "<esc><cmd>'<,'>move" .. line .. "<cr>gv"
        end, "Move multiple lines down", opts = { expr = true } },

        ["<a-k>"] = { function()
            local line = math.min(vim.fn.line "v", vim.fn.line ".") - vim.v.count1
            line = math.max(line - 1, 0)
            return "<esc><cmd>'<,'>move" .. line .. "<cr>gv"
        end, "Move multiple lines up", opts = { expr = true } },
    },
    v = {
        ["d"] = { "\"_d", "Delete selected" },
        ["<leader>d"] = { "\"*d", "Cut selected" }
    }
}
return keymap
