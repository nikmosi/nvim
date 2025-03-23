return {
  "lukas-reineke/virt-column.nvim",
  event = "BufRead",
  opts = {
    enabled = true,
    exclude = { filetypes = { "gitcommit" } },
    virtcolumn = "+1,120",
  },
}
