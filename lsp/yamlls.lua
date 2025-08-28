return {
  settings = {
    yaml = {
      validate = true,
      format = { enable = true },
      -- Не ругаемся на порядок ключей внутри YAML
      keyOrdering = false,

      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },

      schemas = {
        -- GitHub Workflows
        ["https://json.schemastore.org/github-workflow.json"] = {
          ".github/workflows/*.{yml,yaml}",
        },
        -- Extra typing layer for workflow steps (строже, но не конфликтует)
        -- ["https://raw.githubusercontent.com/typesafegithub/github-actions-typing/refs/heads/schema-latest/github-actions-typing.schema.json"] = {
        --   ".github/workflows/*.{yml,yaml}",
        -- },

        -- GitHub Action definition (Только для action.yml, не для workflows!)
        ["https://json.schemastore.org/github-action.json"] = {
          "action.{yml,yaml}",
          ".github/actions/**/action.{yml,yaml}",
        },

        -- Dependabot
        ["https://json.schemastore.org/dependabot-2.0.json"] = ".github/dependabot.yml",

        -- Issue forms
        ["https://json.schemastore.org/github-issue-forms.json"] = ".github/ISSUE_TEMPLATE/*.yml",

        -- Docker Compose v2
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
          "docker-compose*.yml",
          "docker-compose*.yaml",
          "compose*.yml",
          "compose*.yaml",
          "**/compose.yml",
          "**/compose.yaml",
          "**/docker-compose.yml",
          "**/docker-compose.yaml",
        },

        -- GitLab CI
        ["https://json.schemastore.org/gitlab-ci.json"] = ".gitlab-ci.yml",

        -- Hadolint
        ["https://json.schemastore.org/hadolint.json"] = ".hadolint.yaml",

        -- Kubernetes (включай, только если реально есть манифесты)
        kubernetes = {
          "**/k8s/*.yml",
          "**/k8s/*.yaml",
          "**/*-k8s.yml",
          "**/*-k8s.yaml",
          "**/kubernetes/*.yml",
          "**/kubernetes/*.yaml",
        },
      },

      -- customTags = { "!Ref", "!Sub", "!GetAtt", "!Join", "!Select", "!FindInMap", "!Base64", "!If", "!Not", "!And", "!Equals", "!Or" },
    },
  },
}
