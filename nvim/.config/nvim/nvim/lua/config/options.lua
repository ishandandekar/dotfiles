-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.g.lazyvim_python_lsp = "ty"
vim.g.lazyvim_python_lsp = "ty"
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"

-- provided by rust-analyzer.
-- vim.g.lazyvim_rust_diagnostics = "rust-analyzer"
vim.cmd("set completeopt+=noselect")

vim.lsp.config("ty", {
  settings = {
    ty = {
      inlayHints = {
        variableTypes = true,
      },
    },
  },
})

vim.opt.clipboard = "unnamedplus"

vim.opt.guicursor = {
  "n-v-c:block",
  "i:hor20",
}
