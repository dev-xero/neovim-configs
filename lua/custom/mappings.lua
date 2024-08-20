local M = {}

M.general = {
    n = {
        ["<leader>d"] = {
            function()
                require("telescope.builtin").diagnostics()
            end,
            "View diagnostics with Telescope",
        },
    },
}

return M
