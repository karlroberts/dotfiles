if exists("b:current_syntax")
  finish
endif

syntax keyword potionKeyword to times
syntax keyword potionKeyword if else elsif
syntax keyword potionKeyword class return

syntax keyword potionFunction print join string

syntax match potionComment "\v#.*$"

syntax match potionOperator "\v\*"
syntax match potionOperator "\v/"
syntax match potionOperator "\v\+"
syntax match potionOperator "\v-"
syntax match potionOperator "\v\?"
syntax match potionOperator "\v\="
syntax match potionOperator "\v\*\="
syntax match potionOperator "\v/\="
syntax match potionOperator "\v\+\="
syntax match potionOperator "\v-\="

syntax region potionString start=/\v"/ skip=/\v\\./ end=/\v"/

highlight link potionKeyword Keyword
highlight link potionFunction Function
highlight link potionComment Function
highlight link potionOperator Operator
highlight link potionString String

let b:current_syntax = "potion"

