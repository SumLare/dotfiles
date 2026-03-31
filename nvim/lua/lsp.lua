-- Mason (LSP/tool installer)
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "basedpyright",
    "gopls",
    "lua_ls",
  },
})

-- Global capabilities (blink.cmp)
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- LSP keymaps on attach
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
    end

    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gD", vim.lsp.buf.declaration, "Go to declaration")
    map("gr", vim.lsp.buf.references, "References")
    map("gi", vim.lsp.buf.implementation, "Go to implementation")
    map("K", vim.lsp.buf.hover, "Hover")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>cr", vim.lsp.buf.rename, "Rename")
    map("<leader>cf", function() require("conform").format({ async = true }) end, "Format")
  end,
})

-- Lua
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

-- Python
vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      analysis = {
        ignorePatterns = { "*.pyi" },
        diagnosticSeverityOverrides = {
          reportCallIssue = "warning",
          reportUnreachable = "warning",
          reportUnusedImport = "none",
          reportUnusedCoroutine = "warning",
        },
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "basic",
        disableOrganizeImports = true,
      },
    },
  },
})

-- Go
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      analyses = { unusedparams = true },
      staticcheck = true,
      usePlaceholders = true,
      completeUnimported = true,
      gofumpt = true,
    },
  },
})

-- Enable servers
vim.lsp.enable({ "lua_ls", "basedpyright", "gopls" })

-- TypeScript
require("typescript-tools").setup({
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})
