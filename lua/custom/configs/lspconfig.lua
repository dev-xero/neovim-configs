local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")
local util = require "lspconfig/util"
local null_ls = require("null-ls")

local servers = { "html", "cssls", "tsserver", "clangd", "tailwindcss" }


for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end


lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {"rust"},
    root_dir = util.root_pattern("Cargo.toml"),
    settings = {
        ['rust_analyzer'] = {
            cargo = {
                allFeatures = true
            }
        }
    }
})

lspconfig.emmet_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "css", "typescriptreact", "javascriptreact", "javascript", "typescript" },
    init_options = {
        html = {
            options = {
                ["bem.enabled"] = true,
            },
        },
    },
})

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

