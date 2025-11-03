-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("catppuccin").setup({
  flavour = "macchiato", -- latte, frappe, macchiato, mocha
})

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")
