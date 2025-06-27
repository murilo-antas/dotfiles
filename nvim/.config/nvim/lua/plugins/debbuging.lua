return {
    { "nvim-neotest/nvim-nio" },
    { "rcarriga/nvim-dap-ui" },
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")

            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            vim.keymap.set("n", "<F5>", function()
                dap.continue()
            end)
            vim.keymap.set("n", "<F10>", function()
                dap.step_over()
            end)
            vim.keymap.set("n", "<F11>", function()
                dap.step_into()
            end)
            vim.keymap.set("n", "<F12>", function()
                dap.step_out()
            end)
            vim.keymap.set("n", "<Leader>db", function()
                dap.toggle_breakpoint()
            end)
            vim.keymap.set("n", "<Leader>dB", function()
                dap.set_breakpoint()
            end)
            vim.keymap.set("n", "<Leader>lp", function()
                dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
            end)
            vim.keymap.set("n", "<Leader>dr", function()
                dap.repl.open()
            end)
            vim.keymap.set("n", "<Leader>dl", function()
                dap.run_last()
            end)
            vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
                require("dap.ui.widgets").hover()
            end)
            vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
                require("dap.ui.widgets").preview()
            end)
            vim.keymap.set("n", "<Leader>df", function()
                local widgets = require("dap.ui.widgets")
                widgets.centered_float(widgets.frames)
            end)
            vim.keymap.set("n", "<Leader>ds", function()
                local widgets = require("dap.ui.widgets")
                widgets.centered_float(widgets.scopes)
            end)

            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
                    end,
                },
            }
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
            local masondap = require("mason-nvim-dap")
            masondap.setup({
                ensure_installed = { "coreclr" },
                automatic_installation = true,
                handlers = {
                    function(config)
                        masondap.default_setup(config)
                    end,
                },
            })
        end,
    },
}
