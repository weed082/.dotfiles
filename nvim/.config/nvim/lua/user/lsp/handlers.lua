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

local function lsp_highlight_document(client)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]] ,
      false
    )
  end
end

M.on_attach = function(client, bufnr)
  if client.name == "jdt.ls" then
    require("jdtls").setup_dap({ hotcodereplace = "auto" })
    require("jdtls.dap").setup_dap_main_class_configs()
    M.capabilities.textDocument.completion.completionItem.snippetSupport = false
  else
    M.capabilities.textDocument.completion.completionItem.snippetSupport = true
    M.capabilities = require("cmp_nvim_lsp").update_capabilities(M.capabilities)
  end
  require("user.keymaps").lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

return M
