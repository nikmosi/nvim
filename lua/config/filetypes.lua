vim.filetype.add {
  pattern = {
    ["docker%-compose%.%w+%.ya?ml"] = "yaml.docker-compose",
    ["compose%.ya?ml"] = "yaml.docker-compose",
  },
}
