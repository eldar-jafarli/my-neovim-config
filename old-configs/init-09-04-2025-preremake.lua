--------------------------------------------------
-- Vim Settings
--------------------------------------------------
vim.opt.clipboard = "unnamedplus"
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.opt.showtabline = 2  -- Always show the tabline

-- Set colorscheme
vim.cmd "colorscheme habamax"

--------------------------------------------------
-- Plugin Configuration (lazy.nvim)
--------------------------------------------------
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

-- Setup leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { 'wakatime/vim-wakatime', lazy = false },
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      config = function()
        require("nvim-tree").setup {
          view = {
            width = 35,
          },
        }
      end,
    },
    {
      "ThePrimeagen/harpoon",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("harpoon").setup {}
      end,
    },
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

-- Fix: Move selection actions should be inside Telescope setup
local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
      },
      n = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
      },
    },
  },
})

--------------------------------------------------
-- Keybindings
--------------------------------------------------
local builtin = require("telescope.builtin")
--local mark = require("harpoon.mark")
--local ui = require("harpoon.ui")

-- Telescope
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

-- NvimTree
vim.keymap.set('n', '<C-h>', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<C-w>w', ':wincmd w<CR>')

-- Harpoon
vim.keymap.set("n", "<C-a>", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
vim.keymap.set("n", "<C-d>", mark.rm_file)
vim.keymap.set("n", "<M-1>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<M-2>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<M-3>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<M-4>", function() ui.nav_file(4) end)
