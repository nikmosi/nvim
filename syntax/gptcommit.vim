if exists("b:current_syntax")
  finish
endif

syn case match
syn spell toplevel

syn match gptcommitType "\<\%(feat\|fix\|docs\|build\|chore\|ci\|style\|refactor\|perf\|test\|revert\)\>" contained
syn match gptcommitScope "([^)]*)" contained
syn match gptcommitBreaking "!" contained
syn match gptcommitDelim ":" contained

syn match gptcommitHeader "^\%(feat\|fix\|docs\|build\|chore\|ci\|style\|refactor\|perf\|test\|revert\)\((.\{-})\)\=!\=:\s.*$" contains=gptcommitType,gptcommitScope,gptcommitBreaking,gptcommitDelim

syn match gptcommitFooter "^BREAKING CHANGE:.*$"
syn match gptcommitFooter "^BREAKING-CHANGE:.*$"
syn match gptcommitFooter "^\%(BREAKING CHANGE\|BREAKING-CHANGE\)\@!\w\+\(-\w\+\)*:.\+$"

syn match gptcommitComment "^#.*$"

hi def link gptcommitType Keyword
hi def link gptcommitScope Identifier
hi def link gptcommitBreaking WarningMsg
hi def link gptcommitDelim Delimiter
hi def link gptcommitHeader Title
hi def link gptcommitFooter Label
hi def link gptcommitComment Comment

let b:current_syntax = "gptcommit"
