local status_ok, lspsaga = pcall(require, "lspsaga")
if not status_ok then
  return
end

lspsaga.init_lsp_saga({ code_action_prompt = { virtual_text = false } })
