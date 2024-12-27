#!/usr/bin/env bash

# Colors and re-used string components
pre_general='\033[1;96m'
pre_success='  \033[1;92m✔'
pre_failure='  \033[1;91m✗'
post_string='\x1b[0m'

function aio_check_updates() {
  line="${pre_general}─────────────────────────${post_string}"
  aio_check_system

  if hash flatpak 2> /dev/null; then
    aio_check_flatpack
  fi

  if hash pnpm 2> /dev/null; then
    aio_check_pnpm
  fi

  if hash bun 2> /dev/null; then
    aio_check_bun
  fi
  echo -e ${line}
}

function aio_check_system() {
  echo -e ${line}
  echo -e "${pre_general}📶 Checking system updates...${post_string}"
  echo -e ${line}
  if [ "$(uname -s)" = "Darwin" ]; then
    if hash brew 2> /dev/null; then
      topgrade
    fi
    # sudo softwareupdate -i -a
    # if hash brew 2> /dev/null; then
    #   brew update
    #   brew upgrade
    #   brew cleanup
    # fi
  elif [ -f "/etc/arch-release" ] && hash pacman 2> /dev/null; then
    sudo pacman -Syu
  elif [ -f "/etc/debian_version" ] && hash apt 2> /dev/null; then
    sudo apt update && sudo apt upgrade
  elif [ -f "/etc/fedora-release" ]; then
    sudo dnf update && sudo dnf upgrade
  else
    echo -e "${pre_general}Skipping, as couldn't detect system type ${post_string}"
  fi
  echo -e ${line}
}

function aio_check_flatpack() {
  echo -e "${pre_general}📶 Checking flatpack...${post_string}"
  echo -e ${line}
  flatpak update
  flatpak uninstall --unused
}

function aio_check_pnpm() {
  echo -e "${pre_general}📶 Checking PNPM...${post_string}"
  echo -e ${line}
  pnpm -g update; pnpm install -g npm
}

function aio_check_bun() {
  echo -e ${line}
  echo -e "${pre_general}📶 Checking Bun...${post_string}"
  echo -e ${line}
  bun upgrade
}

function aio_dots_edit() {
  sh -c "$DOTFILES_IDE $DOTFILES"
}

function aio_dots_help() {
  echo -e "Utility for checking updates and edit dotfiles\n"
  echo -e "Usage: dot [OPTION]\n"
  echo -e "Options:"
  echo "  -h, --help    Show this help message"
  echo "  -u, --update  Run updates"
  echo "  -e, --edit    Edit dotfiles in IDE (${DOTFILES_IDE})"
}

# Runs everything, prints output
function aio_dots_start() {
  if [[ "$@" == *"--help"* ]] || [[ "$@" == *"-h"* ]]; then
    aio_dots_help
    return
  fi;

  if [[ "$@" == *"--edit"* ]] || [[ "$@" == *"-e"* ]]; then
    aio_dots_edit
  elif [ -z "$@" ] || [[ "$@" == *"--update"* ]] || [[ "$@" == *"-u"* ]]; then
    aio_check_updates
  fi
}

# Determine if file is being run directly or sourced
([[ -n $ZSH_EVAL_CONTEXT && $ZSH_EVAL_CONTEXT =~ :file$ ]] ||
  [[ -n $KSH_VERSION && $(cd "$(dirname -- "$0")" &&
    printf '%s' "${PWD%/}/")$(basename -- "$0") != "${.sh.file}" ]] ||
  [[ -n $BASH_VERSION ]] && (return 0 2>/dev/null)) && sourced=1 || sourced=0

# If script being called directly run immediately, otherwise register aliases
if [ $sourced -eq 0 ]; then
  aio_dots_start "$@"
else
  alias dot=aio_dots_start "$@"
fi
