local plugins = {
      {
        "Pocco81/auto-save.nvim",
        lazy = false,
        config = function()
          require("auto-save").setup({
            enabled = true,
            execution_message = {
              message = function()
                return "autosaved at: " .. os.date("%Y-%m-%d %H:%M:%S")
              end,
            },
            events = {"InsertLeave", "TextChanged"},
            conditions = {
              exists = true,
              filename_is_not = {},
              filetype_is_not = {},
              modifiable = true,
            },
            write_all_buffers = false,
            debounce_delay = 135,
          })
        end
      },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "rust-analyzer",
                "codespell",
                "tailwindcss-language-server",
                "typescript-language-server",
            }
        }
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end
    },
    {
        "rust-lang/rust.vim",
        ft = "rust",
        init = function()
            vim.g.rustfmt_autosave = 1
        end
    }
}

return plugins
