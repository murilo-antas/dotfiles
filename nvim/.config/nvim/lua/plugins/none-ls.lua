return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- Lua
				null_ls.builtins.formatting.stylua,

				-- C#
				null_ls.builtins.formatting.csharpier,

				-- Go
				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.diagnostics.golangci_lint,

				-- Javascript
				null_ls.builtins.formatting.prettier,
				-- null_ls.builtins.diagnostics.eslint_d,
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
