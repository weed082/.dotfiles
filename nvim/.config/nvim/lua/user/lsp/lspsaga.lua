local status_ok, lspsaga = pcall(require, "lspsaga")
if not status_ok then 
  return 
end

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap('n', '<leader>ca', ':Lspsaga code_action<CR>', opts)
keymap('v', '<leader>ca', ':<C-U>Lspsaga range_code_action<CR>', opts)
keymap('n', 'K', ':Lspsaga hover_doc<CR>', opts)
keymap('n', '<C-d>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
keymap('n', '<C-u>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)
keymap('n', '<C-k>', ":Lspsaga signature_help<CR>", opts)
keymap('n', '<leader>rn', ":Lspsaga rename<CR>", opts)
keymap('n', 'gD', ":Lspsaga preview_definition<CR>", opts)
keymap('n', 'gl', "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", opts)
keymap('n', '[d', ':Lspsaga diagnostic_jump_next<CR>', opts)
keymap('n', ']d', ':Lspsaga diagnostic_jump_prev<CR>', opts)
-- keymap('n', '<C-\\>', ":Lspsaga open_floaterm<CR>", opts)
-- keymap('t', '<c-\\>', "<C-\\><C-n>:Lspsaga close_floaterm<CR>", opts)
-- keymap('n', '<leader>g', "<cmd>lua require('lspsaga.floaterm').open_float_terminal('lazygit')<CR>", opts)
-- keymap('t', '<leader>g', "<C-\\><C-n><cmd>lua require('lspsaga.floaterm').close_float_terminal('lazygit')<CR>", opts)

lspsaga.init_lsp_saga()

