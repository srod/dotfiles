# if hash thefuck 2> /dev/null; then;
#   eval $(thefuck --alias)
# fi

# # Fix default editor, for systems without nvim installed
# if ! hash nvim 2> /dev/null; then
#   alias nvim='vim'
# fi

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# Bun completions
[ -s "/Users/rodolphe/.bun/_bun" ] && source "/Users/rodolphe/.bun/_bun"
