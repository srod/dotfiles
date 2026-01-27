# Shared utility functions for srod/dotfiles
command_exists() { hash "$1" 2>/dev/null; }
