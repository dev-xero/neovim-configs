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
                "emmet-ls",
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
    },
    {
        "kamykn/spelunker.vim",
        lazy = false,
        config = function()
            vim.g.spelunker_check_type = 2
            vim.g.spelunker_spell_auto_enable = 1
        end,
    },
    {
        'sbdchd/neoformat',
        lazy = false,
        cmd = 'Neoformat',
        config = function()
            vim.g.neoformat_enabled_javascript = {'prettier'}
            vim.g.neoformat_enabled_typescript = {'prettier'}
            vim.g.neoformat_enabled_css = {'prettier'}
            vim.g.neoformat_enabled_json = {'prettier'}
            vim.g.neoformat_enabled_html = {'prettier'}
            vim.g.neoformat_enabled_markdown = {'prettier'}
            vim.g.neoformat_enabled_yaml = {'prettier'}

            vim.cmd([[
                augroup fmt
                    autocmd!
                    autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.scss,*.json,*.html,*.md,*.yaml,*.yml Neoformat
                augroup END
            ]])
        end,
    },
}

return plugins
