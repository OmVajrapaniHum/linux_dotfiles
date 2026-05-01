-------------------------------------------------------------------------------
-- NEOVIM CONFIGURATION
-- Author: Jakob Janzen
-- Last Modified: 2026-05-01
--
-- ~/.config/nvim/init.lua
-------------------------------------------------------------------------------


-- [[ General Settings ]]

-- Misc
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.undofile = true
vim.opt.laststatus = 2
vim.opt.showcmd = true

-- Encoding
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Formatting/Indentation
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Windows/Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- UI/Visuals
vim.opt.colorcolumn = "80,100,120"
vim.cmd("highlight ColorColumn gui=reverse cterm=reverse guibg=NONE ctermbg=NONE")
vim.opt.statusline = " %f %m %r %=%{&fileformat} [%Y] %l/%L:%c (%P) "


-- [[ Terminal ]]

-- Automatically start insert mode when entering a terminal
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  pattern = "term://*",
  callback = function()
    vim.cmd("startinsert")
  end,
})
-- Clean UI for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})


-- [[ Colorscheme ]]

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd("colorscheme quiet")


-- [[ Keymapping ]]

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
-- Open a terminal at the bottom with 15 lines of height
vim.keymap.set('n', '<leader>t', ':botright split | term<CR>:resize 15<CR>', { desc = "Open Terminal" })
-- Escape terminal mode easily
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = "Exit terminal mode" })
-- Kill/Close the terminal buffer immediately
-- We use :bd! to force-delete the buffer and kill the process
vim.keymap.set('t', '<C-q>', [[<C-\><C-n>:bd!<CR>]], { desc = "Kill Terminal" })
-- Window Resizing
local keymap = vim.keymap.set
-- Vertical resizing (Width)
keymap("n", "<C-S-LEFT>", "5<C-w><", { desc = "Resize Width -" })
keymap("n", "<C-S-RIGHT>", "5<C-w>>", { desc = "Resize Width +" })
-- Horizontal resizing (Height)
keymap("n", "<C-S-UP>", "5<C-w>+", { desc = "Resize Height +" })
keymap("n", "<C-S-DOWN>", "5<C-w>-", { desc = "Resize Height -" })


-- [[ Shell Script Specific Settings ]]

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sh", "bash", "zsh" },
  callback = function()
    -- Standard Shell indentation (usually 2 spaces)
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
    -- Add a vertical ruler at 80 characters
    vim.opt_local.colorcolumn = "80"
  end,
})


-- [[ CMake Specific Settings ]]

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cmake",
  callback = function()
    -- CMake standard indentation is typically 2 spaces
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
    -- Commenting in CMake uses '#'
    vim.opt_local.commentstring = "# %s"
  end,
})


-- [[ C / C++ Specific Settings ]]

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "h", "hpp" },
  callback = function()
    -- Common C/C++ indentation (usually 2 or 4 spaces)
    -- Change to 2 if that is your preference
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
    -- Add a vertical ruler at 80 (Classic C standard)
    vim.opt_local.colorcolumn = "80"
    -- Enable "smartindent" for C-style languages
    -- This makes Neovim better at predicting indentation after { or cases
    vim.opt_local.smartindent = true
  end,
})


-- [[ Python Specific Settings ]]

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    -- Standard Python indentation (4 spaces)
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    -- Set a vertical ruler at 88 chars (Modern Python/Black standard)
    -- This adds to your existing 80, 100, 120 lines
    vim.opt_local.colorcolumn = "88"
    -- Disable automatic wrapping of long lines
    vim.opt_local.wrap = false
  end,
})


-- [[ Lua Specific Settings ]]

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    -- Standard Lua indentation (typically 2 spaces)
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    -- Set a vertical ruler at 100 or 120 (Common for Lua/Neovim configs)
    -- This overrides your global 80/100/120 to highlight just the limit
    vim.opt_local.colorcolumn = "100"
    -- Disable automatic wrapping of long lines
    vim.opt_local.wrap = false
    -- Recognition of Neovim globals (stops "undefined global 'vim'" warnings)
    -- This is helpful if you use a Language Server later
    vim.opt_local.comments = "s1:--,mb:--,ex:-- "
  end,
})


-- [[ Markdown Specific Settings ]]

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Enable spell checking (English)
    -- Use ]s to jump to next error, z= to see suggestions
    vim.opt_local.spell = true
    -- Wrap lines visually, but don't break the actual text
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    -- Indentation
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
  end,
})


-- [[ Markdown Specific Settings ]]

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Standard Markdown indentation (2 spaces)
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    -- Enable spell checking for documentation
    vim.opt_local.spell = true
    -- Enable "soft" wrapping for prose
    -- linebreak ensures words aren't cut in half at the screen edge
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    -- Clear colorcolumns to make writing cleaner
    vim.opt_local.colorcolumn = ""
  end,
})

