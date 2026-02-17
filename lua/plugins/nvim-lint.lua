return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require "lint"
    local linters_by_ft = {
      bash = { "shellcheck", "bash" },
      sh = { "shellcheck", "bash" },
      zsh = { "shellcheck", "zsh" },
      fish = { "fish" },
      make = { "checkmake" },
      dockerfile = { "hadolint" },
      yaml = { "yamllint" },
      ["yaml.github"] = { "actionlint", "yamllint" },
      ["yaml.ansible"] = { "ansible_lint", "yamllint" },
      ["yaml.docker-compose"] = { "yamllint" },
      ["yaml.kubernetes"] = { "kubeconform", "kubeval", "yamllint" },
      ["yaml.kustomize"] = { "yamllint" },
      json = { "jsonlint", "jq" },
      jsonc = { "jsonlint", "jq" },
      markdown = { "markdownlint-cli2", "markdownlint", "vale", "proselint", "write_good" },
      vim = { "vint" },
      lua = { "luacheck", "selene" },
      python = { "ruff", "mypy", "pylint", "flake8", "pycodestyle", "pydocstyle", "bandit", "vulture" },
      nix = { "deadnix", "statix" },
      terraform = { "tflint", "tfsec", "terraform_validate", "tofu" },
      ["terraform-vars"] = { "tflint", "tfsec", "terraform_validate", "tofu" },
      toml = { "tombi" },
      html = { "htmlhint", "markuplint" },
      css = { "stylelint" },
      scss = { "stylelint" },
      less = { "stylelint" },
      javascript = {
        "biomejs",
        "eslint_d",
        "eslint",
        "standardjs",
        "ts-standard",
        "deno",
        "quick-lint-js",
        "oxlint",
      },
      javascriptreact = {
        "biomejs",
        "eslint_d",
        "eslint",
        "standardjs",
        "ts-standard",
        "deno",
        "quick-lint-js",
        "oxlint",
      },
      typescript = {
        "biomejs",
        "eslint_d",
        "eslint",
        "ts-standard",
        "deno",
        "oxlint",
      },
      typescriptreact = {
        "biomejs",
        "eslint_d",
        "eslint",
        "ts-standard",
        "deno",
        "oxlint",
      },
      kotlin = { "ktlint" },
      sql = { "sqruff", "sqlfluff" },
      proto = { "protolint" },
      gitcommit = { "gitlint" },
      gitrebase = { "gitlint" },
    }

    local function resolve_cmd(linter)
      if type(linter) == "function" then
        local ok, res = pcall(linter)
        if ok then
          linter = res
        else
          return nil
        end
      end
      if type(linter) ~= "table" then
        return nil
      end
      local cmd = linter.cmd
      if type(cmd) == "function" then
        local ok, res = pcall(cmd)
        if ok then
          cmd = res
        else
          cmd = nil
        end
      end
      if type(cmd) == "table" then
        cmd = cmd[1]
      end
      return cmd
    end

    local function linter_available(name)
      local linter = lint.linters[name]
      if not linter then
        return false
      end
      local cmd = resolve_cmd(linter)
      if not cmd then
        return false
      end
      return vim.fn.executable(cmd) == 1
    end

    local function filter_linters(map)
      local filtered = {}
      for ft, names in pairs(map) do
        local available = {}
        for _, name in ipairs(names) do
          if linter_available(name) then
            table.insert(available, name)
          end
        end
        if #available > 0 then
          filtered[ft] = available
        end
      end
      return filtered
    end

    lint.linters_by_ft = filter_linters(linters_by_ft)

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function() lint.try_lint() end,
    })
  end,
}
