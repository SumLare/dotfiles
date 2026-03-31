-- Plugin declarations using vim.pack (Neovim 0.12+)
vim.pack.add({
  -- Colorscheme
  { src = "https://github.com/folke/tokyonight.nvim", version = "stable" },

  -- Treesitter
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/folke/ts-comments.nvim" },

  -- LSP
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/williamboman/mason.nvim" },
  { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
  { src = "https://github.com/pmizio/typescript-tools.nvim" },

  -- Completion
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") },
  { src = "https://github.com/rafamadriz/friendly-snippets" },

  -- Formatting & Linting
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/mfussenegger/nvim-lint" },

  -- Navigation & Search
  { src = "https://github.com/folke/flash.nvim" },
  { src = "https://github.com/MagicDuck/grug-far.nvim" },
  { src = "https://github.com/folke/trouble.nvim" },
  { src = "https://github.com/folke/todo-comments.nvim" },

  -- Git
  { src = "https://github.com/lewis6991/gitsigns.nvim" },

  -- UI
  { src = "https://github.com/folke/noice.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/rcarriga/nvim-notify" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/akinsho/bufferline.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },

  -- Mini
  { src = "https://github.com/echasnovski/mini.icons" },
  { src = "https://github.com/echasnovski/mini.pairs" },
  { src = "https://github.com/echasnovski/mini.ai" },

  -- Utilities
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/folke/persistence.nvim" },
  { src = "https://github.com/folke/lazydev.nvim" },
})

-- Hook: run TSUpdate after treesitter installs/updates
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

-- Colorscheme
vim.cmd.colorscheme("tokyonight")

-- Treesitter (highlight & indent are built-in in Neovim 0.12)
require("nvim-treesitter").setup({
  ensure_installed = {
    "lua", "python", "go", "gomod", "gosum",
    "typescript", "tsx", "javascript",
    "html", "css", "json", "yaml", "toml",
    "markdown", "markdown_inline",
    "bash", "fish", "vim", "vimdoc",
    "zig", "rust",
  },
})

-- Textobjects
require("nvim-treesitter-textobjects").setup({
  select = {
    enable = true,
    lookahead = true,
    keymaps = {
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
      ["aa"] = "@parameter.outer",
      ["ia"] = "@parameter.inner",
    },
  },
  move = {
    enable = true,
    goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
    goto_prev_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
  },
})

require("nvim-ts-autotag").setup()
require("ts-comments").setup()

-- Completion (blink.cmp)
require("blink.cmp").setup({
  keymap = { preset = "default" },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },
  signature = { enabled = true },
})

-- Formatting
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format" },
    go = { "gofumpt" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
  },
  format_on_save = {
    timeout_ms = 3000,
    lsp_format = "fallback",
  },
})

-- Git
require("gitsigns").setup()

-- Flash
require("flash").setup()
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })

-- Trouble
require("trouble").setup()
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics" })

-- Todo Comments
require("todo-comments").setup()

-- Grug-far
require("grug-far").setup()
vim.keymap.set("n", "<leader>sr", function() require("grug-far").open() end, { desc = "Search and replace" })

-- Which-key
require("which-key").setup()

-- Noice
require("noice").setup({
  presets = {
    bottom_search = false,
    command_palette = {
      views = {
        cmdline_popup = {
          position = { row = "50%", col = "50%" },
          size = { min_width = 60, width = "auto", height = "auto" },
        },
      },
    },
  },
})

-- Lualine
require("lualine").setup({
  options = {
    theme = "tokyonight",
    globalstatus = true,
  },
})

-- Bufferline
require("bufferline").setup({
  options = {
    diagnostics = "nvim_lsp",
    always_show_bufferline = false,
  },
})

-- Mini
require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.ai").setup()

-- Telescope
require("telescope").setup()

-- Persistence (sessions)
require("persistence").setup()
vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end, { desc = "Restore session" })
vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "Restore last session" })

-- Lazydev (Lua LSP helpers)
require("lazydev").setup()
