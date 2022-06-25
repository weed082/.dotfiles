local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup({
  open_mapping = [[<c-\>]],
  shading_factor = 2,
  direction = "float",
  float_opts = { winblend = 0 },
})

function _G.set_terminal_keymaps()
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { noremap = true })
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local M = {}
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

M.lazygit = function()
  lazygit:toggle()
end

return M
