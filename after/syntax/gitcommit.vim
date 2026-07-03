hi! link gitcommitSummary Title
hi! link gitcommitFirstLine Title

hi! link gitcommitOverflow WarningMsg
hi! link gitcommitTrailers NonText

hi! link gptcommitType Statement
hi! link gptcommitScope Identifier
hi! link gptcommitBreaking WarningMsg
hi! link gptcommitDelim Delimiter

syn match gptcommitIssueRef "#\d\+"
hi! link gptcommitIssueRef WarningMsg

syn match gptcommitBreakingFooter "^BREAKING CHANGE:.*$"
syn match gptcommitBreakingFooter "^BREAKING-CHANGE:.*$"
hi! link gptcommitBreakingFooter WarningMsg

syn clear gitcommitBlank
syn match gitcommitBlank "^\n\@<=[^#].*" contains=@Spell,gptcommitIssueRef,gptcommitBreakingFooter,gitcommitAddedLine,gitcommitRemovedLine,gitcommitDiffHeader,gitcommitDiffOldPath,gitcommitDiffNewPath,gitcommitDiffIndexLine,gitcommitDiffOldLine,gitcommitDiffNewLine,gitcommitDiffHunk
hi! link gitcommitBlank Normal

syn match gitcommitAddedLine "^+\(+\)\@!.*" contained
syn match gitcommitRemovedLine "^-\(-\)\@!.*" contained
hi! link gitcommitAddedLine diffAdded
hi! link gitcommitRemovedLine diffRemoved

syn match gitcommitDiffHeader     "^diff --git " contained
syn match gitcommitDiffOldPath    " a/\S\+" contained
syn match gitcommitDiffNewPath    " b/\S\+" contained
hi! link gitcommitDiffHeader     diffFile
hi! link gitcommitDiffOldPath    Special
hi! link gitcommitDiffNewPath    Constant

syn match gitcommitDiffIndexLine  "^index \x\+\.\.\x\+ \d\+" contained
hi! link gitcommitDiffIndexLine  diffIndexLine

syn match gitcommitDiffOldLine    "^--- .*" contains=gitcommitDiffOldFilePath contained
syn match gitcommitDiffOldFilePath "\S\+$" contained
hi! link gitcommitDiffOldLine    diffFile
hi! link gitcommitDiffOldFilePath Special

syn match gitcommitDiffNewLine    "^+++ .*" contains=gitcommitDiffNewFilePath contained
syn match gitcommitDiffNewFilePath "\S\+$" contained
hi! link gitcommitDiffNewLine    diffFile
hi! link gitcommitDiffNewFilePath Constant

syn match gitcommitDiffHunk       "^@@.*" contained
hi! link gitcommitDiffHunk       diffLine

if exists('g:loaded_gitcommit_highlight')
  for s:m in filter(getmatches(), {i, v -> v.group =~# '^gptcommit'})
    silent! call matchdelete(s:m.id)
  endfor
  unlet! s:m
endif
let g:loaded_gitcommit_highlight = 1

augroup gitcommit_highlight
  au!
  au BufLeave <buffer> call s:gitcommit_cleanup()
augroup END

fun! s:gitcommit_cleanup()
  for s:m in filter(getmatches(), {i, v -> v.group =~# '^gptcommit'})
    silent! call matchdelete(s:m.id)
  endfor
  unlet! s:m
endfun

for s:entry in [
      \ ['gptcommitType',     '\%1l^\w\+',   10],
      \ ['gptcommitScope',    '\%1l([^)]*)', 11],
      \ ['gptcommitBreaking', '\%1l!',       12],
      \ ['gptcommitDelim',    '\%1l:',       13],
      \ ]
  silent! call matchadd(s:entry[0], s:entry[1], s:entry[2])
endfor
unlet! s:entry
