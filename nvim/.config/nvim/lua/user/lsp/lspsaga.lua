local status_ok, lspsaga = pcall(require, "lspsaga")
if not status_ok then 
  return 
end

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

lspsaga.init_lsp_saga({ code_action_prompt = { virtual_text = false } })
