local status, theme = pcall(require, "nightfox")
if not status then
  return
end

theme.setup({
  options = {
    dim_inactive = true,
    transparent = true,
    styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold",
    },
  },
})
vim.cmd([[ colorscheme terafox ]])
