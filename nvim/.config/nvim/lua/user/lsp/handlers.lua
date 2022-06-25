local M = {}
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "ﮖ" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end
end

local augroup = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
M.lsp_highlight_document = function(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = augroup })
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = augroup,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = augroup,
    })
  end
end

M.on_attach = function(client, bufnr)
  require("user.keymaps").lsp_keymaps(bufnr)
  M.capabilities.textDocument.completion.completionItem.snippetSupport = true
  M.capabilities = require("cmp_nvim_lsp").update_capabilities(M.capabilities)
  M.lsp_highlight_document(client, bufnr)
end

return M
