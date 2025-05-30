return {
    'kdheepak/tabline.nvim',
    config = function()
        require'tabline'.setup {
            -- Defaults configuration options
            enable = true,
            options = {
                -- If lualine is installed tabline will use separators configured in lualine by default.
                -- These options can be used to override those settings.
                -- section_separators = {'', ''},
                section_separators = {'|', '|'},
                -- component_separators = {'', ''},
                component_separators = {'|', '|'},
                max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
                show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
                show_devicons = true, -- this shows devicons in buffer section
                show_bufnr = false, -- this appends [bufnr] to buffer section,
                show_filename_only = false, -- shows base filename only instead of relative path in filename
                modified_icon = "+ ", -- change the default modified icon
                modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
                show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
            }
        }
        vim.cmd[[
      set guioptions-=e " Use showtabline in gui vim
      set sessionoptions+=tabpages,globals " store tabpages and globals in session
      ]]
        vim.keymap.set('n', '<M-l>', ':TablineBufferNext<CR>', {})
        vim.keymap.set('n', '<M-h>', ':TablineBufferPrevious<CR>', {})
        --vim.keymap.set('n', '<M-d>', ':bdelete!<CR> | <CR>', {})

        vim.keymap.set("n", "<M-d>", function()
            local bufnr = vim.api.nvim_get_current_buf()
            local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufnr })

            if buftype == "terminal" then
                vim.cmd("bdelete! " .. bufnr) -- force delete terminal
            else
                vim.cmd("bnext")              -- go to the next buffer
                vim.cmd("bdelete " .. bufnr)  -- delete current one
            end
        end, { desc = "Close buffer safely (with terminal support)" })
    end,
    requires = { { 'hoob3rt/lualine.nvim', opt=true }, {'kyazdani42/nvim-web-devicons', opt = true} }
}
