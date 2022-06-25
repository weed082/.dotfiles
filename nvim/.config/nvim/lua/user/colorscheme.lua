local status, theme = pcall(require, "nightfox")
if not status then
  print("nightfox bad status")
  return
end

theme.setup({
  options = {
    dim_inactive = true,
    styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold",
    },
  },
})
vim.cmd([[ colorscheme nightfox ]])
