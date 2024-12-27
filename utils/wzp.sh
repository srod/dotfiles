#!/usr/bin/env bash

# Wezterm Project - Start a new wezterm project
# https://cosimomatteini.com/blog/terminal-configurations-with-wezterm
# https://github.com/devmatteini/dotfiles/blob/b7ed3facec837421b10bc772fdc54de006d2b4a6/scripts/wzp

# Colors and re-used string components
pre_general='\033[1;96m'
pre_success='  \033[1;92m✔'
pre_failure='  \033[1;91m✗'
post_string='\x1b[0m'

PROJECTS_DIR="$HOME/.config/wezterm/projects"

project=""

function aio_wzp_help() {
  echo -e "Wezterm Project - Start a new wezterm project\n"
  echo -e "Usage: wzp [PROJECT]\n"
  echo -e "Options:"
  echo "  -h, --help    Show this help message"
}

# Runs everything, prints output
function aio_wzp_start() {
  if [[ "$@" == *"--help"* ]] || [[ "$@" == *"-h"* ]]; then
    aio_wzp_help
    return
  fi;

  project=""

  if [[ -z "$@" ]]; then
      # List all files in projects directory. Only keep the file name without the extension
      project=$(find "$PROJECTS_DIR" -maxdepth 1 -type "f,l" -name "*.lua" -printf '%f\n' | sed "s/\.lua//" | fzf --cycle --layout=reverse)
  else
      if [[ ! -e "$PROJECTS_DIR/$@.lua" ]]; then
          echo "The project file '$PROJECTS_DIR/$@.lua' not exists"
          exit 1
      fi
      project="$@"
  fi

  if [[ -z $project ]]; then
      echo "No project selected"
      exit 1
  fi

  WZ_PROJECT="$project" wezterm start --always-new-process &!
}

# Determine if file is being run directly or sourced
([[ -n $ZSH_EVAL_CONTEXT && $ZSH_EVAL_CONTEXT =~ :file$ ]] ||
  [[ -n $KSH_VERSION && $(cd "$(dirname -- "$0")" &&
    printf '%s' "${PWD%/}/")$(basename -- "$0") != "${.sh.file}" ]] ||
  [[ -n $BASH_VERSION ]] && (return 0 2>/dev/null)) && sourced=1 || sourced=0

# If script being called directly run immediately, otherwise register aliases
if [ $sourced -eq 0 ]; then
  aio_wzp_start "$@"
else
  alias wzp=aio_wzp_start "$@"
fi
