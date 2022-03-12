local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"
vim.api.nvim_set_keymap("n", "<leader>f", ":Telescope find_files<CR>", { noremap = true, silent = true })

telescope.setup {
  defaults = {
    file_ignore_patterns = { ".git", "node_modules", "build", "bin", "gradle", ".gradle" },
    prompt_prefix = " ",
    path_display = { "smart" },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      no_ignore = true,
      hidden = true,
    }
  }
}
