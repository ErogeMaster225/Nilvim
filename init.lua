-- Compile lua to bytecode if the nvim version supports it.
if vim.loader and vim.fn.has("nvim-0.9.1") == 1 then vim.loader.enable() end

if vim.g.neovide then
    vim.o.guifont = "0xProto,termicons,JetBrainsMono Nerd Font Propo:h14"
    --[[ vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            vim.cmd("cd $HOME")
        end,
    }) ]]
end

require("core")
