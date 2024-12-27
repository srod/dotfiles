# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

######################################################################
# ~/.config/zsh/.zshrc                                               #
######################################################################
# Instructions to be executed when a new ZSH session is launched     #
# Imports all plugins, aliases, helper functions, and configurations #
#                                                                    #
# After editing, re-source .zshrc for new changes to take effect     #
# For docs and more info, see: https://github.com/srod/dotfiles   #
######################################################################
# Licensed under MIT (C) Alicia Sykes 2022 <https://aliciasykes.com> #
######################################################################

# Directory for all-things ZSH config
zsh_dir=${${ZDOTDIR}:-$HOME/.config/zsh}
utils_dir="${XDG_CONFIG_HOME}/utils"

# If not running interactively, don't do anything
# [[ $- != *i* ]] && return

# Import utility functions
if [[ -d $utils_dir ]]; then
  source ${utils_dir}/transfer.sh
  source ${utils_dir}/matrix.sh
  source ${utils_dir}/hr.sh
  source ${utils_dir}/web-search.sh
  source ${utils_dir}/am-i-online.sh
  #source ${utils_dir}/welcome-banner.sh
  source ${utils_dir}/color-map.sh
  source ${utils_dir}/dot.sh
  source ${utils_dir}/wzp.sh
fi

# Import P10k config for command prompt, run `p10k configure` or edit
[[ ! -f ${zsh_dir}/.p10k.zsh ]] || source ${zsh_dir}/.p10k.zsh

# MacOS-specific services
if [ "$(uname -s)" = "Darwin" ]; then
  # Add Brew to path, if it's installed
  if [[ -d /opt/homebrew/bin ]]; then
    export PATH=/opt/homebrew/bin:$PATH
  fi

  # If using iTerm, import the shell integration if available
  if [[ -f "${XDG_CONFIG_HOME}/zsh/.iterm2_shell_integration.zsh" ]]; then
    source "${XDG_CONFIG_HOME}/zsh/.iterm2_shell_integration.zsh"
  fi
fi

# Source all ZSH config files (if present)
if [[ -d $zsh_dir ]]; then
  # Setup Antigen, and import plugins
  source ${zsh_dir}/helpers/setup-antigen.zsh
  source ${zsh_dir}/helpers/import-plugins.zsh
  source ${zsh_dir}/helpers/misc-stuff.zsh

  # Import alias files
  source ${zsh_dir}/aliases/general.zsh
  source ${zsh_dir}/aliases/git.zsh
  source ${zsh_dir}/aliases/node-js.zsh
  source ${zsh_dir}/aliases/alias-tips.zsh

  # Configure ZSH stuff
  source ${zsh_dir}/lib/colors.zsh
  source ${zsh_dir}/lib/cursor.zsh
  source ${zsh_dir}/lib/history.zsh
  source ${zsh_dir}/lib/surround.zsh
  source ${zsh_dir}/lib/completion.zsh
  source ${zsh_dir}/lib/term-title.zsh
  source ${zsh_dir}/lib/navigation.zsh
  source ${zsh_dir}/lib/expansions.zsh
  source ${zsh_dir}/lib/key-bindings.zsh
fi

# If not running in nested shell, then show welcome message :)
#if [[ "${SHLVL}" -lt 2 ]] && \
#  { [[ -z "$SKIP_WELCOME" ]] || [[ "$SKIP_WELCOME" == "false" ]]; }; then
#  welcome
#fi

# bun completions
[ -s "/Users/rodolphe/.bun/_bun" ] && source "/Users/rodolphe/.bun/_bun"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# FZF configurations
# export FZF_DEFAULT_OPTS='--layout=reverse --height 40%'
# export FZF_DEFAULT_COMMAND="rg --files --hidden --follow"
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_ALT_C_COMMAND="rg --hidden --sort-files --files --null 2> /dev/null | xargs -0 dirname | uniq"

# export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"
# export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
# export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# _fzf_compgen_path() {
#     fd --hidden --exclude .git . "$1"
# }

# _fzf_compgen_dir() {
#     fd --type=d --hidden --exclude .git . "$1"
# }

# Created by `pipx` on 2024-06-11 13:23:54
export PATH="$PATH:/Users/rodolphe/.local/bin"
