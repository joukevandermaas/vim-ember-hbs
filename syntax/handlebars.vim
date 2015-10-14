if exists("b:current_syntax")
  finish
endif

" Because of vim's syntax rules, our syntax definitions
" can get overwritten by e.g. the <a href>underlined</a>
" styling, so we need to turn that off.
if exists("html_no_rendering")
  let save_no_rendering = html_no_rendering
endif
let html_no_rendering = 1
runtime! syntax/html.vim
if exists("save_no_rendering")
  let html_no_rendering = test
endif

syntax region hbsMustache matchgroup=hbsHandles start="\v\{\{" end="\v\}\}" contains=hbsKeyword,hbsIdentifier,hbsString,hbsHash,hbsNumber keepend
syntax region hbsUnescaped matchgroup=hbsHandles start="\v\{\{\{" end="\v\}\}\}" contains=hbsUnescapedIdentifier keepend
syntax region hbsMustacheBlock matchgroup=hbsHandles start="\v\{\{[#/]" end="\v\}\}" contains=hbsBlockKeyword,hbsIdentifier,hbsString,hbsHash,hbsNumber keepend

syntax match hbsIdentifier "\v(\s|\=|\.)@<!<\S+>" contained
syntax match hbsUnescapedIdentifier "\v(\s|\=|\.)@<!<\S+>" contained

syntax match hbsKeyword "\v(\s|\=|\.)@<!<(if|action|link-to|unless|else|input|unbound)>" contained
syntax match hbsBlockKeyword "\v(\s|\=|\.)@<!<(if|each|each-in|link-to|unless)>" contained

syntax region hbsString matchgroup=hbsString start=/\v\"/ skip=/\v\\\"/ end=/\v\"/ contained
syntax match hbsNumber "\v<\d+>" contained

syntax region hbsComment start="\v\{\{\!" end="\v\}\}"
syntax region hbsComment start="\v\{\{\!\-\-" end="\v\-\-\}\}"

highlight link hbsKeyword Keyword
highlight link hbsBlockKeyword Keyword
highlight link hbsIdentifier Identifier
highlight link hbsUnescapedIdentifier Keyword
highlight link hbsString String
highlight link hbsNumber Number
highlight link hbsHandles Define
highlight link hbsComment Comment

let b:current_syntax = "handlebars"
