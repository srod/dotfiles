
######################################################################
# ZSH aliases and helper functions for working with Git              #
#                                                                    #
# Licensed under MIT (C) Alicia Sykes 2022 <https://aliciasykes.com> #
######################################################################

# Basics
alias gg="git grep"
alias ga="git add"
alias gd="git diff"
alias gds="git diff --staged"
alias gc="git commit --verbose"
alias gs="git status -sb"
alias gco="git checkout"
alias gpr="git pull --rebase"
alias git_conflicts="git diff --name-only --diff-filter=U"

# Prompt for main SSH key passphrase, so u don't need to enter it again until session killed
alias add-key='eval "$(ssh-agent)" && ssh-add ~/.ssh/id_ed25519'
