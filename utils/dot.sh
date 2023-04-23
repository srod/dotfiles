#!/usr/bin/env bash

BIN_NAME=$(basename "$0")
COMMAND_NAME=$1
SUB_COMMAND_NAME=$2

sub_help () {
  echo "Usage: $BIN_NAME <command>"
  echo
  echo "Commands:"
  echo "   clean            Clean up caches (brew, gem)"
  echo "   edit             Open dotfiles in IDE ($EDITOR)"
  echo "   help             This help message"
  echo "   macos            Apply macOS system defaults"
  echo "   update           Update packages and pkg managers (OS, brew, npm)"
}

sub_edit () {
  sh -c "$EDITOR $DOTFILES"
}

sub_update () {
  sudo softwareupdate -i -a
  brew update
  brew upgrade
  brew cleanup
  pnpm install npm -g
  pnpm update -g
}

sub_clean () {
  brew cleanup
}

sub_macos () {
  . "${DOTFILES}/setup/macos/main.sh"
  echo "Done. Some changes may require a logout/restart to take effect."
}

case $COMMAND_NAME in
  "" | "-h" | "--help")
    sub_help
    ;;
  *)
    shift
    sub_${COMMAND_NAME} $@
    if [ $? = 127 ]; then
      echo "'$COMMAND_NAME' is not a known command or has errors." >&2
      sub_help
      exit 1
    fi
    ;;
esac
