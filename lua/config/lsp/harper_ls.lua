return {
  settings = {
    ["harper-ls"] = {
      linters = {
        SentenceCapitalization = {
          enabled = false,
        },
      },
      diagnostics = {
        disabled = { "SentenceCapitalization" },
      },
    },
  },
}
