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
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.diagnostics.eslint_d.with({
                        condition = function(utils)
                            return utils.root_has_file(".eslintrc.json") or utils.root_has_file(".eslintrc.js")
                        end,
                    }),
                    null_ls.builtins.code_actions.eslint_d,
                    null_ls.builtins.formatting.eslint_d,
                },
                on_attach = function(client, bufnr)
                    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
                    local opts = { noremap=true, silent=true }

                    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
                    buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
                    buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
                    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
                    buf_set_keymap('n', '<leader>lf', '<Cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)

                    if client.server_capabilities.documentFormattingProvider then
                        vim.cmd([[
                            augroup LspFormatting
                                autocmd! * <buffer>
                                autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ timeout_ms = 2000 })
                            augroup END
                        ]])
                    end
                end,
            })
        end
    },
    {
        'sbdchd/neoformat',
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
    {
        
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },
    {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
}

return plugins
