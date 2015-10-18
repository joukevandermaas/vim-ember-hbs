if exists("b:current_syntax")
  finish
endif

runtime! syntax/html.vim
syn cluster htmlPreproc add=hbsMustache,hbsUnescaped,hbsMustacheBlock,hbsComment

syntax region hbsMustache matchgroup=hbsHandles start="\v\{\{" end="\v\}\}" keepend containedin=@htmlHbsContainer
syntax region hbsUnescaped matchgroup=hbsHandles start="\v\{\{\{" end="\v\}\}\}" keepend containedin=@htmlHbsContainer
syntax region hbsMustacheBlock matchgroup=hbsHandles start="\v\{\{[#/]" end="\v\}\}" keepend containedin=@htmlHbsContainer
syntax region hbsHelper matchgroup=hbsOperator start="\v\=\("ms=s+1 end="\v\)" keepend containedin=hbsMustache,hbsMustacheBlock

syntax match hbsIdentifier "\v(\{\{[#/]?|\()@<=<\S+>" contained containedin=hbsMustache,hbsMustacheBlock,hbsHelper
syntax match hbsUnescapedIdentifier "\v(\{\{\{)@<=<\S+>" contained containedin=hbsUnescaped

syntax match hbsKeyword "\v(\{\{|\()@<=<(if|action|link-to|unless|else\ if|else|input|unbound|yield|outlet)>" contained containedin=hbsMustache,hbsHelper
syntax match hbsKeyword "\v(\{\{[#/])@<=<(if|each|each-in|link-to|unless)>" contained containedin=hbsMustacheBlock
syntax match hbsKeyword "\v\s+as\s+" contained containedin=hbsMustacheBlock
syntax region hbsStatement matchgroup=hbsOperator start="\v\|" end="\v\|" contained containedin=hbsMustacheBlock

syntax region hbsString matchgroup=hbsString start=/\v\"/ skip=/\v\\\"/ end=/\v\"/ contained containedin=hbsMustache,hbsMustacheBlock,hbsHelper
syntax region hbsString matchgroup=hbsString start=/\v\'/ skip=/\v\\\'/ end=/\v\'/ contained containedin=hbsMustache,hbsMustacheBlock,hbsHelper
syntax match hbsNumber "\v<\d+>" contained containedin=hbsMustache,hbsMustacheBlock,hbsHelper

syntax region hbsComment start="\v\{\{\!" end="\v\}\}" containedin=@htmlHbsContainer
syntax region hbsComment start="\v\{\{\!\-\-" end="\v\-\-\}\}" containedin=@htmlHbsContainer

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
