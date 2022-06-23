local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

telescope.setup({
  defaults = {
    file_ignore_patterns = { ".git", "node_modules", "bin" },
    prompt_prefix = " ",
    path_display = { "smart" },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      hidden = true,
    },
  },
})
