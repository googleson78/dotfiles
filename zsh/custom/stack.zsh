alias se="stack exec"
alias sb="stack build"
alias st="stack test"

alias sghci="stack ghci"
alias sghc="stack ghc"
alias srunghc="stack runghc"

alias swatch="stack build --file-watch --fast --test"
alias spretty="stack ghci --ghci-options "-interactive-print=Text.Pretty.Simple.pPrint" --package pretty-simple"

# autocomplete
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
eval "$(stack --bash-completion-script stack)"
