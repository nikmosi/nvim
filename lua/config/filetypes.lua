vim.filetype.add({
  pattern = {
    ['docker%-compose%.%w+%.ya?ml'] = 'compose.yml', -- Matches files like `docker-compose.yaml` or `docker-compose.override.yml`
    ['compose%.ya?ml'] = 'compose.yml',              -- Matches `compose.yaml` or `compose.yml`
  }
})
