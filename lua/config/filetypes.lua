vim.filetype.add {
  pattern = {
    ["docker%-compose%.%w+%.ya?ml"] = "yaml.docker-compose",
    ["compose%.ya?ml"] = "yaml.docker-compose",
    ["docker-compose%.ya?ml"] = "yaml.docker-compose",
    [".*/%.github[%w/]+workflows[%w/]+.*%.ya?ml"] = "yaml.github",
  },
}
