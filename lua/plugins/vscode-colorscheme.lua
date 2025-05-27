return {
  "Mofiqul/vscode.nvim",
  lazy = false, -- Load it immediately (important for colorschemes)
  priority = 1000, -- Make sure it loads before other UI plugins
  config = function()
    -- Set up the colorscheme with transparent background
    require("vscode").setup({
      style = "dark",
      transparent = true,
      italic_comments = true,
      italic_keywords = true,
      disable_nvimtree_bg = true,
    })

    -- Load the colorscheme
    require("vscode").load()
  end,
}

