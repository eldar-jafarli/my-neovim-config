vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set number")
vim.cmd("set relativenumber")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    --{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  --dependencies = {
    --"nvim-tree/nvim-web-devicons",
  --},
  config = function()
    require("nvim-tree").setup {
      --open_on_setup = true,
    }
    vim.keymap.set('n', '<C-h>', ':NvimTreeToggle<CR>')
    vim.keymap.set('n', '<C-w>w', ':wincmd w<CR>')
  end,
  },
    {"nvim-lua/plenary.nvim"},
    {
        "ThePrimeagen/harpoon",
}
  },

  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})
local builtin = require("telescope.builtin") 
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {}) --to find the file searching by keywords, shortcut is Space + f + g

vim.cmd "colorscheme habamax"
--require("catppuccin").setup()
--vim.cmd.colorscheme "catppuccin"

