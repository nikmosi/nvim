vim.cmd "syntax on"
vim.opt.langremap = false
vim.opt.laststatus = 3
vim.opt.showtabline = 2
vim.opt.splitkeep = "screen"
vim.opt.autoread = true
vim.opt.cursorcolumn = false
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.list = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append "I"
vim.opt.showcmd = true
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.wildcharm = 26
vim.opt.wildignorecase = true
vim.opt.wildignore = "*.o,*.obj,*~,*.swp,*.git,*.hg,*.svn,*.DS_Store"
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildoptions = "pum"
vim.opt.scrolloff = 10 -- Always keep 10 lines below the cursor
vim.opt.wrap = true
vim.o.scl = "yes"
vim.opt.cmdheight = 0

vim.opt.shell = "bash"
vim.opt.shellcmdflag = "-c"
vim.opt.shellredir = ">%s 2>&1"
vim.opt.shellpipe = ">%s 2>&1"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

local shada_dir = vim.fn.stdpath "state" .. "/shada"
if vim.fn.filewritable(shada_dir) ~= 2 then
  vim.opt.shadafile = "/tmp/nvim.shada"
end

if vim.g.started_by_firenvim then
  vim.g.firenvim_config = {
    globalSettings = { alt = "all" },
    localSettings = {
      [".*"] = {
        selector = "textarea",
        takeover = "never",
      },
    },
  }
  local min_height = 10
  local function enforce_min_lines()
    if vim.o.lines < min_height then
      vim.o.lines = min_height
    end
  end

  vim.api.nvim_create_autocmd({ "UIEnter", "VimResized" }, {
    callback = function() vim.schedule(enforce_min_lines) end,
  })

  vim.api.nvim_create_autocmd("OptionSet", {
    pattern = "lines",
    callback = function() enforce_min_lines() end,
  })
end
