local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local augroup = vim.api.nvim_create_augroup("lsp_format", { clear = true })

null_ls.setup({
  sources = {
    diagnostics.eslint,
    formatting.prettier,
    formatting.google_java_format,
    formatting.gofmt,
    formatting.black,
    formatting.stylua,
  },
  on_attach = function(client, bufnr)
    if client.resolved_capabilities.document_formatting then
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = augroup })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = vim.lsp.buf.formatting_seq_sync,
      })
    end
  end,
})
