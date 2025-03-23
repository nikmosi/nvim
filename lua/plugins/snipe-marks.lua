return {
  "nicholasxjy/snipe-marks.nvim",
  dependencies = { "leath-dub/snipe.nvim" },
  keys = {
    { "<leader>ml", function() require("snipe-marks").open_marks_menu() end, desc = "Find local marks" },
    { "<leader>ma", function() require("snipe-marks").open_marks_menu "all" end, desc = "Find all marks" },
  },
}
