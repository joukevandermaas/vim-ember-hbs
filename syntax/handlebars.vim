if exists("b:current_syntax")
  finish
endif

runtime! syntax/html.vim
syntax cluster htmlPreproc add=hbsMustache,hbsUnescaped,hbsMustacheBlock,hbsComment,hbsElseBlock,hbsEscapedMustache

syntax match hbsEscapedMustache "\v\\\{\{"

syntax region hbsMustache matchgroup=hbsHandles start="\v\{\{" skip="\v\\\}\}" end="\v\}\}" keepend
syntax region hbsUnescaped matchgroup=hbsHandles start="\v\{\{\{" skip="\v\\\}\}\}" end="\v\}\}\}" keepend
syntax region hbsMustacheBlock matchgroup=hbsHandles start="\v\{\{[#/]" skip="\v\\\}\}" end="\v\}\}" keepend
" modern hbs supports {{else <block>}} where <block> starts a new block
syntax region hbsElseBlock matchgroup=hbsHandles start="\v\{\{else\ "rs=e-5 skip="\v\\\}\}" end="\v\}\}" keepend

syntax region hbsPencil matchgroup=hbsOperator start="\v\(" end="\v\)" contained containedin=hbsMustache,hbsMustacheBlock,hbsElseBlock,hbsPencil

syntax match hbsIdentifier "\v\(@<!<\S+>" contained containedin=hbsMustache,hbsMustacheBlock,hbsPencil,hbsElseBlock,hbsStatement
syntax match hbsIdentifier "\v(\{\{)@<=<\S+>@>(\}\})" contained containedin=hbsMustache,hbsMustacheBlock,hbsPencil,hbsElseBlock
syntax match hbsUnescapedIdentifier "\v(\{\{\{)@<=<\S+>" contained containedin=hbsUnescaped

syntax match hbsMustacheName "\v(\{\{)@<=<\S+>" contained containedin=hbsMustache,hbsMustacheBlock,hbsPencil
syntax match hbsPencilName "\v(\()@<=<\S+>" contained containedin=hbsMustache,hbsMustacheBlock,hbsPencil
syntax match hbsBuiltInHelper "\v(\{\{)@<=<else>" contained containedin=hbsElseBlock
syntax match hbsBuiltInHelper "\v\(@<=<(query-params|mut|get|if|action|unless|unbound|concat)>" contained containedin=hbsPencil
syntax match hbsBuiltInHelper "\v(\{\{)@<=<(textarea|mut|input|get|debugger|if|action|link\-to|unless|input|unbound|yield|outlet|else|component)>" contained containedin=hbsMustache
syntax match hbsBuiltInHelper "\v(\{\{([#/]|else\ ))@<=<(with|if|each\-in|each|link\-to|unless)>" contained containedin=hbsMustacheBlock,hbsElseBlock
syntax match hbsKeyword "\v\s+as\s+" contained containedin=hbsMustacheBlock,hbsElseBlock
syntax region hbsStatement matchgroup=hbsDelimiter start="\v\|" end="\v\|" contained containedin=hbsMustacheBlock,hbsElseBlock

syntax region hbsString matchgroup=hbsString start=/\v\"/ skip=/\v\\\"/ end=/\v\"/ contained containedin=hbsMustache,hbsMustacheBlock,hbsPencil,hbsElseBlock
syntax region hbsString matchgroup=hbsString start=/\v\'/ skip=/\v\\\'/ end=/\v\'/ contained containedin=hbsMustache,hbsMustacheBlock,hbsPencil,hbsElseBlock
syntax match hbsNumber "\v<\d+>" contained containedin=hbsMustache,hbsMustacheBlock,hbsPencil,hbsElseBlock
syntax match hbsArg "\v[a-z]+\="me=e-1 contained containedin=hbsMustache,hbsMustacheBlock,hbsPencil,hbsElseBlock

syntax region hbsComment start="\v\{\{\!" end="\v\}\}" keepend
syntax region hbsComment start="\v\{\{\!\-\-" end="\v\-\-\}\}" keepend

highlight link hbsBuiltInHelper Function
highlight link hbsKeyword Keyword
highlight link hbsOperator Operator
highlight link hbsDelimiter Delimiter
highlight link hbsMustacheName Statement
highlight link hbsPencilName Statement
highlight link hbsIdentifier Identifier
highlight link hbsUnescapedIdentifier Identifier
highlight link hbsProperty Type
highlight link hbsString String
highlight link hbsNumber Number
highlight link hbsHandles Define
highlight link hbsComment Comment
highlight link hbsArg Type
highlight link hbsStatement Statement

let b:current_syntax = "handlebars"
