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

            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({ capabilities = capabilities })
            lspconfig.omnisharp.setup({

                cmd = { "omnisharp" }, -- Mason installs OmniSharp with this name by default
                root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj"),
                on_attach = function(client, bufnr)
                    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
                    buf_set_option("omnisharp", "omnisharp")

                    -- Optional: Custom keybindings for LSP commands
                    -- local opts = { noremap = true, silent = true }
                    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
                    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
                    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
                    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
                end,
                capabilities = capabilities
            })

            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
}
