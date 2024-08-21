local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

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
