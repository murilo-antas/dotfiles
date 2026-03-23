return {
    {
        "mason-org/mason.nvim",
        opts = {},
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local omnisharp_root_dir = function(fname)
                local root = vim.fs.root(fname, function(name)
                    return name:match("%.sln$") ~= nil or name:match("%.csproj$") ~= nil
                end)

                return root or vim.fs.root(fname, ".git")
            end

            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
            })
            vim.lsp.enable("lua_ls")

            vim.lsp.config("omnisharp", {
                cmd = { "omnisharp" }, -- Mason installs OmniSharp with this name by default
                root_dir = omnisharp_root_dir,
                capabilities = capabilities,
            })
            vim.lsp.enable("omnisharp")

            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
}
