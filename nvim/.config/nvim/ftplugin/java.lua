local status, jdtls = pcall(require, "jdtls")
if not status then
  return
end
local lsp_handlers = require("user.lsp.handlers")
local home = os.getenv("HOME")
if vim.fn.has("mac") == 1 then
  CONFIG = "mac"
elseif vim.fn.has("unix") == 1 then
  CONFIG = "linux"
else
  print("Unsupported system")
end

-- capabilities
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- java debug plugin
local bundles = {
  vim.fn.glob(
    home .. "/.config/nvim/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
  ),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.config/nvim/vscode-java-test/server/*.jar"), "\n"))

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. home .. "/.local/share/nvim/lsp_servers/jdtls/lombok.jar",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    vim.fn.glob(home .. "/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    home .. "/.local/share/nvim/lsp_servers/jdtls/config_" .. CONFIG,
    "-data",
    home .. "/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"), -- project name
  },
  on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    local keymap = vim.keymap.set
    keymap("n", "<leader>df", jdtls.test_class, bufopts)
    keymap("n", "<leader>dn", jdtls.test_nearest_method, bufopts)
    keymap("n", "<leader>ji", jdtls.organize_imports, bufopts)
    keymap("n", "<leader>jv", jdtls.extract_variable, bufopts)
    keymap("n", "<leader>jc", jdtls.extract_constant, bufopts)
    keymap("v", "<leader>jm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", bufopts)
    keymap("v", "<leader>jv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", bufopts)
    keymap("v", "<leader>jc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", bufopts)
    lsp_handlers.capabilities.textDocument.completion.completionItem.snippetSupport = false
    lsp_handlers.lsp_highlight_document(client, bufnr)
    jdtls.setup_dap({ hotcodereplace = "auto" })
    require("jdtls.dap").setup_dap_main_class_configs()
    require("user.keymaps").lsp_keymaps(bufnr)
  end,
  capabilities = lsp_handlers.capabilities,
  root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
  settings = {
    java = {
      eclipse = { downloadSources = true },
      configuration = { updateBuildConfiguration = "interactive" },
      maven = { downloadSources = true },
      implementationsCodeLens = { enabled = true },
      references = { includeDecompiledSources = true },
      signatureHelp = { enabled = true },
      format = { enabled = false },
      extendedClientCapabilities = extendedClientCapabilities,
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
      },
    },
  },
  init_options = { bundles = bundles },
}
jdtls.start_or_attach(config)

-- command
vim.cmd([[
command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)
command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)
command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
command! -buffer JdtJol lua require('jdtls').jol()
command! -buffer JdtBytecode lua require('jdtls').javap()
command! -buffer JdtJshell lua require('jdtls').jshell()
]])

-- java keymaps
