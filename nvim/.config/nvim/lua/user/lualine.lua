local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  print("lualine bad status")
  return
end

lualine.setup({
  options = {
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
  },
})
