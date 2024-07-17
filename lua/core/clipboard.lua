local g = vim.g
local is_linux = vim.fn.has("unix") == 1
local is_wsl = vim.fn.has("wsl") == 1
local is_mac = vim.fn.has("macunix") == 1
local is_wayland = os.getenv("WAYLAND_DISPLAY") ~= nil

if is_mac then
    g.clipboard = {
        name = "pbcopy",
        copy = {
            ["+"] = "pbcopy",
            ["*"] = "pbcopy",
        },
        paste = {
            ["+"] = "pbpaste",
            ["*"] = "pbpaste",
        },
        cache_enabled = 1,
    }
elseif is_wsl then
    g.clipboard = {
        name = "win32yank",
        copy = {
            ["+"] = "win32yank -i --crlf",
            ["*"] = "win32yank -i --crlf",
        },
        paste = {
            ["+"] = "win32yank -o --lf",
            ["*"] = "win32yank -o --lf",
        },
        cache_enabled = 1,
    }
elseif is_linux and is_wayland then
    g.clipboard = {
        name = "wl-clipboard",
        copy = {
            ["+"] = "wl-copy --type text/plain",
            ["*"] = "wl-copy --type text/plain",
        },
        paste = {
            ["+"] = "wl-paste --no-newline",
            ["*"] = "wl-paste --no-newline",
        },
        cache_enabled = 1,
    }
elseif is_linux then
    g.clipboard = {
        name = "xclip",
        copy = {
            ["+"] = "xclip -selection clipboard",
            ["*"] = "xclip -selection primary",
        },
        paste = {
            ["+"] = "xclip -selection clipboard -o",
            ["*"] = "xclip -selection primary -o",
        },
        cache_enabled = 1,
    }
end
