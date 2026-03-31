local autocmd = vim.api.nvim_create_autocmd

-- Set current directory to file's directory
autocmd("VimEnter", {
  callback = function()
    local path = vim.fn.expand("%:p:h")
    if path ~= "" then
      vim.fn.chdir(path)
    end
  end,
})

-- Highlight yanked text
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 250, higroup = "Visual" })
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

-- Auto enter insert mode in terminal
autocmd("BufEnter", {
  pattern = "term://*",
  command = "startinsert",
})

-- Treat .mdx as markdown
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.mdx",
  command = "set ft=markdown",
})

-- Fix common typos
vim.cmd([[
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
cnoreabbrev <expr> WQ ((getcmdtype() is# ':' && getcmdline() is# 'WQ')?('wq'):('WQ'))
cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
]])
