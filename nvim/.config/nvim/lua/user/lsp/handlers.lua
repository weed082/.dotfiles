local M = {}

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- lsp saga
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', ':Lspsaga code_action<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', ':<C-U>Lspsaga range_code_action<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', ':Lspsaga hover_doc<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-d>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-u>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', ":Lspsaga signature_help<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', ":Lspsaga rename<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', ":Lspsaga preview_definition<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gl', "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', ':Lspsaga diagnostic_jump_next<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', ':Lspsaga diagnostic_jump_prev<CR>', opts)
end

local function lsp_highlight_document(client)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec( [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

M.on_attach = function(client, bufnr)
  local clients = { "tsserver", "gopls", "jdtls" }
  for _, target in ipairs(clients) do
    if client.name == target then
      client.resolved_capabilities.document_formatting = false
    end
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
