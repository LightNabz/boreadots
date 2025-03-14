-- Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("config") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp" },
    { "kyazdani42/nvim-tree.lua" },
    { "nvim-lualine/lualine.nvim" }
})

-- Catppuccin Theme Setup
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        -- lualine = true,
    }
})

-- Set colorscheme
vim.cmd.colorscheme "catppuccin"

-- LSP basic setup
require("lspconfig").clangd.setup{}
require("lspconfig").pyright.setup{}

-- Treesitter setup
require("nvim-treesitter.configs").setup {
    highlight = { enable = true },
    ensure_installed = { "lua", "python", "c", "cpp", "javascript", "html", "css" }
}

-- Statusline setup
require("lualine").setup {
    options = { theme = "catppuccin" }
}

-- NvimTree setup
require("nvim-tree").setup{}

-- NvimSetNumber
vim.opt.number = true  -- Enable line numbers
vim.opt.relativenumber = true  -- Optional: Enables relative line numbers

