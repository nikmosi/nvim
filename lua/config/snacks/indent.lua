return {
  enabled = true,
  animate = {
    enabled = vim.fn.has "nvim-0.10" == 1,
    style = "out",
    easing = "linear",
    duration = {
      step = 40, -- ms per step
      total = 200, -- maximum duration
    },
  },
}
