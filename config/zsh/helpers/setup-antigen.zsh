#zsh_dir=${XDG_CONFIG_HOME:-$HOME/.config}/zsh
antigen_dir=${ADOTDIR:-$XDG_CACHE_HOME/zsh/antigen}
antigen_git="https://raw.githubusercontent.com/zsh-users/antigen/master/bin/antigen.zsh"

antigen_bin="${ADOTDIR}/antigen.zsh"

# Pin the cache-invalidation watchlist to the files that actually define our
# plugin set. Left unset, antigen defaults to ~/.zshrc (antigen.zsh:1895) —
# which ZDOTDIR makes dead code here, yet CLI installers keep re-creating it.
# Every such write then invalidated the cache and regenerated it *without* the
# theme, silently dropping us to the default prompt.
ANTIGEN_CHECK_FILES=(
  ${ZDOTDIR:-$HOME/.config/zsh}/.zshrc
  ${ZDOTDIR:-$HOME/.config/zsh}/helpers/import-plugins.zsh
  ${ZDOTDIR:-$HOME/.config/zsh}/helpers/setup-antigen.zsh
)

# Import antigen if present, or prompt to install if missing
if [[ -f $antigen_bin ]]; then
  source $antigen_bin
else
  if read -q "choice?Would you like to install Antigen now? (y/N)"; then
    echo
    mkdir -p $antigen_dir
    curl -L $antigen_git > $antigen_bin
    source $antigen_bin
  fi
fi

# Set the ZSH prompt
antigen theme romkatv/powerlevel10k
