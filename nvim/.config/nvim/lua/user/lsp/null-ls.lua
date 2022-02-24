local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- spell
local completion = null_ls.builtins.completion

null_ls.setup({
	debug = true,
	sources = {
    diagnostics.eslint,
		formatting.prettier.with({ extra_args = { "--single-quote", "--jsx-single-quote" }}),
		formatting.stylua,
    completion.spell,
	},
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
      augroup LspFormatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()
      augroup END
      ]])
    end
  end,
})
