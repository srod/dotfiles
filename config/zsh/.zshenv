#  ~/.zshenv
# Core environmental variables
# Locations configured here are required for all other files to be correctly imported

# Set XDG directories
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_BIN_HOME="${HOME}/.local/bin"
export XDG_LIB_HOME="${HOME}/.local/lib"
export XDG_CACHE_HOME="${HOME}/.cache"

# Set default applications
export EDITOR="vim"
export TERMINAL="wezterm"
export BROWSER="open"
export PAGER="less"
export VISUAL="vim"
export DOTFILES=$HOME/.dotfiles

# Respect XDG directories
export ADOTDIR="${XDG_CACHE_HOME}/zsh/antigen"
export _ANTIGEN_INSTALL_DIR="${ADOTDIR}"
export OPENSSL_DIR="/usr/local/ssl"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export CURL_HOME="${XDG_CONFIG_HOME}/curl"
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
# export GIT_CONFIG="${XDG_CONFIG_HOME}/git/.gitconfig"
export KDEHOME="${XDG_CONFIG_HOME}/kde"
export LESSHISTFILE="-" # Disable less history.
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/pass"
export PIP_CONFIG_FILE="${XDG_CONFIG_HOME}/pip/pip.conf"
export PIP_LOG_FILE="${XDG_DATA_HOME}/pip/log"
export TMUX_PLUGIN_MANAGER_PATH="${XDG_DATA_HOME}/tmux/plugins"
# export VIMINIT=":source $XDG_CONFIG_HOME/vim/vimrc"
export WGETRC="${XDG_CONFIG_HOME}/wget/.wgetrc"
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
export XSERVERRC="${XDG_CONFIG_HOME}/X11/xserverrc"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export ZLIB="${ZDOTDIR}/lib"
# export MYVIMRC="${XDG_CONFIG_HOME}/vim/vimrc"

# Encodings, languages and misc settings
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';
export PYTHONIOENCODING='UTF-8';
