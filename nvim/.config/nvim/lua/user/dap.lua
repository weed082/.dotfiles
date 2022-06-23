local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  print("dap bad status")
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  print("dap ui bad status")
  return
end

local status_ok, dap_install = pcall(require, "dap-install")
if not status_ok then
  print("dap install bad status")
  return
end
-- dap_install.setup({ installation_path = vim.fn.stdpath("data") .. "/dapinstall/" })
dap_install.config("python", {})

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    sidebar = {
      elements = {
        {
          id = "scopes",
          size = 0.25, -- Can be float or integer > 1
        },
        { id = "breakpoints", size = 0.25 },
        -- { id = "stacks", size = 0.25 },
        -- { id = "watches", size = 00.25 },
      },
      size = 40,
      position = "right", -- Can be "left", "right", "top", "bottom"
    },
    tray = { elements = {} },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "rounded", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
