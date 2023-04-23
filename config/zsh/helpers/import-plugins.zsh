#!/usr/bin/env zsh

# Load the oh-my-zsh's library
antigen use oh-my-zsh

if [[ $OSTYPE == darwin* ]]; then
  antigen bundle osx
fi

# Bundles from the default repo (robbyrussell's oh-my-zsh)
antigen bundle git
antigen bundle git-extras
antigen bundle command-not-found
# antigen bundle history-substring-search
# antigen bundle jsontools
# antigen bundle sudo
# antigen bundle urltools
# antigen bundle web-search
antigen bundle brew
antigen bundle gpg-agent
antigen bundle ssh-agent
# antigen bundle sublime
# antigen bundle macos
antigen bundle node
antigen bundle npm
# antigen bundle vscode

# Syntax highlighting for commands
antigen bundle zsh-users/zsh-syntax-highlighting

# Make and cd into nested directories
# antigen bundle caarlos0/zsh-mkc

# Quickly jump into frequently used directories
# antigen bundle agkozak/zsh-z

# Extra zsh completions
antigen bundle zsh-users/zsh-completions

# Auto suggestions from history
antigen bundle zsh-users/zsh-autosuggestions

antigen bundle zsh-users/zsh-history-substring-search

# Pretty directory listings with git support
antigen bundle supercrabtree/k

# Quickly jump into fequently used directories
# antigen bundle autojump

# Syntax highlighting for cat
antigen bundle colorize

# Tell antigen that you're done
antigen apply