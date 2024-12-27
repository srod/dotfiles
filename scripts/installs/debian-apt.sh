#!/usr/bin/env bash

################################################################
# 📜 Debian/ Ubuntu, apt Package Install / Update Script       #
################################################################
# Installs listed packages on Debian-based systems via apt-get #
# Also updates the cache database and existing applications    #
# Confirms apps aren't installed via different package manager #
# Doesn't include desktop apps, that'd managed via Flatpak    #
# Apps are sorted by category, and arranged alphabetically     #
# Be sure to delete / comment out anything you do not need     #
# For more info, see: https://wiki.debian.org/Apt              #
################################################################
# MIT Licensed (C) Alicia Sykes 2023 <https://aliciasykes.com> #
################################################################

# Apps to be installed via apt-get
debian_apps=(
  # Essentials
  'git'           # Version control
  'git-lfs'
  # 'neovim'        # Text editor
  # 'ranger'        # Directory browser
  # 'tmux'          # Term multiplexer
  'vim'           # Text editor
  'wget'          # Download files

  # CLI Power Basics
  # 'aria2'         # Resuming download util (better wget)
  'bat'           # Output highlighting (better cat)
  # 'broot'         # Interactive directory navigation
  # 'ctags'         # Indexing of file info + headers
  # 'diff-so-fancy' # Readable file compares (better diff)
  # 'duf'           # Get info on mounted disks (better df)
  'eza'           # Listing files with info (better ls)
  'fzf'           # Fuzzy file finder and filtering
  # 'hyperfine'     # Benchmarking for arbitrary commands
  # 'just'          # Powerful command runner (better make)
  # 'jq'            # JSON parser, output and query files
  # 'most'          # Multi-window scroll pager (better less)
  'ngrep'
  # 'procs'         # Advanced process viewer (better ps)
  'ripgrep'       # Searching within files (better grep)
  # 'scrot'         # Screenshots programmatically via CLI
  # 'sd'            # RegEx find and replace (better sed)
  # 'thefuck'       # Auto-correct miss-typed commands
  # 'tealdeer'      # Reader for command docs (better man)
  # 'tree'          # Directory listings as tree structure
  # 'tokei'         # Count lines of code (better cloc)
  # 'trash-cli'     # Record and restore removed files
  # 'xsel'          # Copy paste access to the X clipboard
  'xclip'
  # 'zoxide'        # Auto-learning navigation (better cd)

  # Security Utilities
  # 'clamav'        # Open source virus scanning suite
  # 'cryptsetup'    # Reading / writing encrypted volumes
  'gnupg'         # PGP encryption, signing and verifying
  # 'git-crypt'     # Transparent encryption for git repos
  # 'lynis'         # Scan system for common security issues
  'openssl'       # Cryptography and SSL/TLS Toolkit
  # 'rkhunter'      # Search / detect potential root kits

  # Monitoring, management and stats
  # 'btop'          # Live system resource monitoring
  # 'bmon'          # Bandwidth utilization monitor
  # 'ctop'          # Container metrics and monitoring
  # 'gping'         # Interactive ping tool, with graph
  # 'glances'       # Resource monitor + web and API
  # 'goaccess'      # Web log analyzer and viewer
  'htop'          # Interactive process viewer
  'speedtest-cli' # Command line speed test utility

  # CLI Fun
  # 'cowsay'        # Outputs message with ASCII art cow
  'figlet'        # Outputs text as 3D ASCII word art
  # 'lolcat'        # Rainbow colored terminal output
  'neofetch'      # Show off distro and system info

  'default-jre'   # Java Runtime Environment

  # Apps
  'meld'          # File comparison tool
  'unrar'         # Unpack rar archives
  'pdfarranger'   # Merge and rearrange PDF files
  'gimp'          # Image editor
  'vlc'           # Video player

  # Fonts
  'fonts-firacode' # Fira Code font
  'fonts-powerline' # Powerline fonts
  'ttf-mscorefonts-installer' # Microsoft fonts
)

ubuntu_repos=(
  'main'
  'universe'
  'restricted'
  'multiverse'
)

debian_repos=(
  'main'
  'contrib'
)

# Following packages not found by apt, need to fix:
# aria2, bat, broot, diff-so-fancy, duf, hyperfine,
# just, procs, ripgrep, sd, tealdeer, tokei, trash-cli,
# zoxide, clamav, cryptsetup, gnupg, lynis, btop, gping.


# Colors
PURPLE='\033[0;35m'
YELLOW='\033[0;93m'
CYAN_B='\033[1;96m'
LIGHT='\x1b[2m'
RESET='\033[0m'

PROMPT_TIMEOUT=15 # When user is prompted for input, skip after x seconds

# If set to auto-yes - then don't wait for user reply
if [[ $* == *"--auto-yes"* ]]; then
  PROMPT_TIMEOUT=0
  REPLY='Y'
fi

# Print intro message
echo -e "${PURPLE}Starting Debian/ Ubuntu package install & update script"
echo -e "${YELLOW}Before proceeding, ensure your happy with all the packages listed in \e[4m${0##*/}"
echo -e "${RESET}"

# Check if running as root, and prompt for password if not
if [ "$EUID" -ne 0 ]; then
  echo -e "${PURPLE}Elevated permissions are required to adjust system settings."
  echo -e "${CYAN_B}Please enter your password...${RESET}"
  sudo -v
  if [ $? -eq 1 ]; then
    echo -e "${YELLOW}Exiting, as not being run as sudo${RESET}"
    exit 1
  fi
fi

# Check apt-get actually installed
if ! hash apt 2> /dev/null; then
  echo "${YELLOW_B}apt doesn't seem to be present on your system. Exiting...${RESET}"
  exit 1
fi

# Enable upstream package repositories
# echo -e "${CYAN_B}Would you like to enable listed repos? (y/N)${RESET}\n"
# read -t $PROMPT_TIMEOUT -n 1 -r
# echo
# if [[ $REPLY =~ ^[Yy]$ ]]; then
#   if ! hash add-apt-repository 2> /dev/null; then
#     sudo apt install --reinstall software-properties-common
#   fi
#   # If Ubuntu, add Ubuntu repos
#   if lsb_release -a 2>/dev/null | grep -q 'Ubuntu'; then
#     for repo in ${ubuntu_repos[@]}; do
#       echo -e "${PURPLE}Enabling ${repo} repo...${RESET}"
#       sudo add-apt-repository $repo
#     done
#   else
#     # Otherwise, add Debian repos
#     for repo in ${debian_repos[@]}; do
#       echo -e "${PURPLE}Enabling ${repo} repo...${RESET}"
#       sudo add-apt-repository $repo
#     done
#   fi
# fi

# Prompt user to update package database
echo -e "${CYAN_B}Would you like to update package database? (y/N)${RESET}\n"
read -t $PROMPT_TIMEOUT -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo -e "${PURPLE}Updating database...${RESET}"
  sudo apt update
fi

# Prompt user to upgrade currently installed packages
echo -e "${CYAN_B}Would you like to upgrade currently installed packages? (y/N)${RESET}\n"
read -t $PROMPT_TIMEOUT -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo -e "${PURPLE}Upgrading installed packages...${RESET}"
  sudo apt upgrade
fi

# Prompt user to clear old package caches
echo -e "${CYAN_B}Would you like to clear unused package caches? (y/N)${RESET}\n"
read -t $PROMPT_TIMEOUT -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo -e "${PURPLE}Freeing up disk space...${RESET}"
  sudo apt autoclean
fi

# Prompt user to install all listed apps
echo -e "${CYAN_B}Would you like to install listed apps? (y/N)${RESET}\n"
read -t $PROMPT_TIMEOUT -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo -e "${PURPLE}Starting install...${RESET}"
  for app in "${debian_apps[@]}"; do
    if hash "${app}" 2> /dev/null; then
      echo -e "${YELLOW}[Skipping]${LIGHT} ${app} is already installed${RESET}"
    elif hash flatpak 2> /dev/null && [[ ! -z $(echo $(flatpak list --columns=ref | grep $app)) ]]; then
      echo -e "${YELLOW}[Skipping]${LIGHT} ${app} is already installed via Flatpak${RESET}"
    else
      echo -e "${PURPLE}[Installing]${LIGHT} Downloading ${app}...${RESET}"
      sudo apt install ${app} --assume-yes
    fi
  done
fi

# Meslo font
echo -e "${PURPLE}Installing Meslo font${RESET}"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d ~/.fonts
fc-cache -fv
rm -f Meslo.zip

# Brave
sudo apt install -y curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install -y brave-browser

# Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64,arm64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update
sudo apt-get install -y google-chrome-stable

if hash "code" 2> /dev/null; then
  echo -e "${YELLOW}[Skipping]${LIGHT} Visual Studio Code is already installed${RESET}"
else
  echo -e "${PURPLE}Visual Studio Code${RESET}"
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  sudo apt update
  sudo apt install -y apt-transport-https code
  rm -f packages.microsoft.gpg
fi

# Insync
if hash "insync" 2> /dev/null; then
  echo -e "${YELLOW}[Skipping]${LIGHT} Insync is already installed${RESET}"
else
  echo -e "${PURPLE}Installing Insync${RESET}"
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
  sudo touch /etc/apt/sources.list.d/insync.list
  echo 'deb http://apt.insync.io/ubuntu jammy non-free contrib' | sudo tee -a /etc/apt/sources.list.d/insync.list
  sudo apt-get update
  sudo apt-get install -y insync
fi

echo -e "${PURPLE}Freeing up disk space...${RESET}"
sudo apt autoclean

echo -e "${PURPLE}Finished installing / updating Debian packages.${RESET}"

# EOF
