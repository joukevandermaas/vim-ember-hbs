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
syntax region hbsHelper matchgroup=hbsOperator start="\v\(" end="\v\)" contained containedin=hbsMustache,hbsMustacheBlock,hbsElseBlock,hbsHelper

syntax match hbsIdentifier "\v(\{\{([#/]|else\ )?|\()@<=<\S+>" contained containedin=hbsMustache,hbsMustacheBlock,hbsHelper,hbsElseBlock
syntax match hbsUnescapedIdentifier "\v(\{\{\{)@<=<\S+>" contained containedin=hbsUnescaped

syntax match hbsKeyword "\v(\{\{)@<=<else>" contained containedin=hbsElseBlock
syntax match hbsKeyword "\v\(@<=<(query-params|mut|get|if|action|unless|unbound|concat)>" contained containedin=hbsHelper
syntax match hbsKeyword "\v(\{\{)@<=<(textarea|mut|input|get|debugger|if|action|link\-to|unless|input|unbound|yield|outlet|else|component)>" contained containedin=hbsMustache
syntax match hbsKeyword "\v(\{\{([#/]|else\ ))@<=<(with|if|each\-in|each|link\-to|unless)>" contained containedin=hbsMustacheBlock,hbsElseBlock
syntax match hbsKeyword "\v\s+as\s+" contained containedin=hbsMustacheBlock,hbsElseBlock
syntax region hbsStatement matchgroup=hbsOperator start="\v\|" end="\v\|" contained containedin=hbsMustacheBlock,hbsElseBlock

syntax region hbsString matchgroup=hbsString start=/\v\"/ skip=/\v\\\"/ end=/\v\"/ contained containedin=hbsMustache,hbsMustacheBlock,hbsHelper,hbsElseBlock
syntax region hbsString matchgroup=hbsString start=/\v\'/ skip=/\v\\\'/ end=/\v\'/ contained containedin=hbsMustache,hbsMustacheBlock,hbsHelper,hbsElseBlock
syntax match hbsNumber "\v<\d+>" contained containedin=hbsMustache,hbsMustacheBlock,hbsHelper,hbsElseBlock

syntax region hbsComment start="\v\{\{\!" end="\v\}\}" keepend
syntax region hbsComment start="\v\{\{\!\-\-" end="\v\-\-\}\}" keepend

highlight link hbsKeyword Keyword
highlight link hbsOperator Define
highlight link hbsIdentifier Function
highlight link hbsProperty Type
highlight link hbsUnescapedIdentifier Keyword
highlight link hbsString String
highlight link hbsNumber Number
highlight link hbsHandles Define
highlight link hbsComment Comment

let b:current_syntax = "handlebars"
