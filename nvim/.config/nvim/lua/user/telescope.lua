local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"
vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", { noremap = true, silent = true })

telescope.setup {
  defaults = {
    file_ignore_patterns = {"node_modules"},
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
  },
}
