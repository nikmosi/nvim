; Work around a Neovim 0.12 markdown injection crash.
; See :help treesitter-language-injections and :help ft-query-plugin:
; placing an empty injections query on runtimepath disables injections.
;
; This avoids parser crashes on fenced code blocks triggered by markdown
; injections in core Tree-sitter users such as render-markdown.nvim and
; snacks.nvim image docs.
