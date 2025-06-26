return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        { "3rd/image.nvim", opts = {} }, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    lazy = false,                  -- neo-tree will lazily load itself
    config = function()
        require("neo-tree").setup({ window = { position = "right" } })
        vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>")
    end,
}
