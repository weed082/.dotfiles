local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  autotag = { 
    enable = true
  },
  ignore_install = { "" }, 
  autopairs = {
    enable = true,
  },
  highlight = {
    disable = { "" }, 
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
