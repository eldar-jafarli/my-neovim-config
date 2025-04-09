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
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      config = function()
        require("nvim-tree").setup {}
        vim.keymap.set('n', '<C-h>', ':NvimTreeToggle<CR>')
        vim.keymap.set('n', '<C-w>w', ':wincmd w<CR>')
      end,
    },
    {
      "ThePrimeagen/harpoon",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local harpoon = require("harpoon")
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")
        
        harpoon.setup {}
        vim.keymap.set("n", "<leader>a", mark.add_file)
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
        vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
        vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
        vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
        vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)
      end,
    },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

-- Telescope keymaps
local builtin = require("telescope.builtin") 
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

-- Set colorscheme
vim.cmd "colorscheme habamax"

