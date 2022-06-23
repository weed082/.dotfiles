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

local function lsp_keymaps(bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local keymap = vim.keymap.set
  keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
  keymap("n", "gd", vim.lsp.buf.definition, bufopts)
  keymap("n", "K", vim.lsp.buf.hover, bufopts)
  keymap("n", "gi", vim.lsp.buf.implementation, bufopts)
  keymap("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  keymap("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  keymap("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  keymap("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  keymap("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  keymap("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  keymap("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  keymap("n", "gr", vim.lsp.buf.references, bufopts)
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
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

return M
