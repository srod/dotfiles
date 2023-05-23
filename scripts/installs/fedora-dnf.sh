#!/usr/bin/env bash

################################################################
# 📜 Fedora, dnf Package Install / Update Script       #
################################################################

# Apps to be installed via dnf
fedora_apps=(
  # Essentials
  'git'           # Version controll
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
  # 'exa'           # Listing files with info (better ls)
  # 'fzf'           # Fuzzy file finder and filtering
  # 'hyperfine'     # Benchmarking for arbitrary commands
  # 'just'          # Powerful command runner (better make)
  # 'jq'            # JSON parser, output and query files
  # 'most'          # Multi-window scroll pager (better less)
  'ngrep'
  # 'procs'         # Advanced process viewer (better ps)
  # 'ripgrep'       # Searching within files (better grep)
  # 'scrot'         # Screenshots programmatically via CLI
  # 'sd'            # RegEx find and replace (better sed)
  # 'thefuck'       # Auto-correct miss-typed commands
  # 'tealdeer'      # Reader for command docs (better man)
  # 'tree'          # Directory listings as tree structure
  # 'tokei'         # Count lines of code (better cloc)
  # 'trash-cli'     # Record and restore removed files
  'util-linux-user'
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

  'java-latest-openjdk-headless'   # Java Runtime Environment

  # Apps
  'gnome-tweaks'  # Gnome settings manager
  'meld'          # File comparison tool
  'unrar'         # Unpack rar archives
  'pdfarranger'   # Merge and rearrange PDF files
  'gimp'          # Image editor
  'vlc'           # Video player

  # Fonts
  'mscore-fonts-all' # Microsoft fonts
  'fira-code-fonts' # Fira Code font
  'powerline-fonts' # Powerline fonts
  # 'ttf-mscorefonts-installer' # Microsoft fonts
)

# General Setup
# sudo sh -c 'echo "fastestmirror=true" >> /etc/dnf/dnf.conf'
sudo sh -c 'echo "deltarpm=true" >> /etc/dnf/dnf.conf'
sudo sh -c 'echo "defaultyes=true" >> /etc/dnf/dnf.conf'
sudo sh -c 'echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf'
sudo dnf install -y fedora-workstation-repositories
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf upgrade -y --refresh
sudo dnf distro-sync -y
sudo dnf groupupdate -y core
sudo dnf install -y rpmfusion-free-release-tainted
sudo dnf install -y dnf-plugins-core

# Extras
sudo dnf groupupdate -y sound-and-video
# sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,ugly-\*,base} gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
sudo dnf install -y lame\* --exclude=lame-devel
sudo dnf group upgrade -y --with-optional Multimedia

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
echo -e "${PURPLE}Starting Fedora package install & update script"
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

# Check dnf actually installed
if ! hash dnf 2> /dev/null; then
  echo "${YELLOW_B}dnf doesn't seem to be present on your system. Exiting...${RESET}"
  exit 1
fi

# Prompt user to update package database
echo -e "${CYAN_B}Would you like to update package database? (y/N)${RESET}\n"
read -t $PROMPT_TIMEOUT -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo -e "${PURPLE}Updating database...${RESET}"
  sudo dnf update
fi

# Prompt user to upgrade currently installed packages
echo -e "${CYAN_B}Would you like to upgrade currently installed packages? (y/N)${RESET}\n"
read -t $PROMPT_TIMEOUT -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo -e "${PURPLE}Upgrading installed packages...${RESET}"
  sudo dnf upgrade
fi

# Prompt user to clear old package caches
echo -e "${CYAN_B}Would you like to clear unused package caches? (y/N)${RESET}\n"
read -t $PROMPT_TIMEOUT -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo -e "${PURPLE}Freeing up disk space...${RESET}"
  sudo dnf clean all
fi

# Prompt user to install all listed apps
echo -e "${CYAN_B}Would you like to install listed apps? (y/N)${RESET}\n"
read -t $PROMPT_TIMEOUT -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo -e "${PURPLE}Starting install...${RESET}"
  for app in ${fedora_apps[@]}; do
    if hash "${app}" 2> /dev/null; then
      echo -e "${YELLOW}[Skipping]${LIGHT} ${app} is already installed${RESET}"
    elif hash flatpak 2> /dev/null && [[ ! -z $(echo $(flatpak list --columns=ref | grep $app)) ]]; then
      echo -e "${YELLOW}[Skipping]${LIGHT} ${app} is already installed via Flatpak${RESET}"
    else
      echo -e "${PURPLE}[Installing]${LIGHT} Downloading ${app}...${RESET}"
      sudo dnf install ${app} -y
    fi
  done
fi

# Fonts
echo -e "${PURPLE}Installing Meslo font${RESET}"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d ~/.fonts
fc-cache -fv
rm -f Meslo.zip

sudo dnf copr enable hyperreal/better_fonts -y
sudo dnf install fontconfig-font-replacements -y
sudo dnf install fontconfig-enhanced-defaults -y

# Brave
sudo dnf install dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install -y brave-browser

# Google Chrome
sudo dnf config-manager --set-enabled google-chrome
sudo dnf install -y google-chrome-stable

# Visual Studio Code
if hash "code" 2> /dev/null; then
  echo -e "${YELLOW}[Skipping]${LIGHT} Visual Studio Code is already installed${RESET}"
else
  echo -e "${PURPLE}Visual Studio Code${RESET}"
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
  sudo dnf check-update
  sudo dnf install -y code
fi

# Insync
if hash "insync" 2> /dev/null; then
  echo -e "${YELLOW}[Skipping]${LIGHT} Insync is already installed${RESET}"
else
  echo -e "${PURPLE}Installing Insync${RESET}"
  sudo rpm --import https://d2t3ff60b2tol4.cloudfront.net/repomd.xml.key
  sudo sh -c 'echo -e "[insync]\nname=insync repo\nbaseurl=http://yum.insync.io/fedora/\$releasever/\ngpgkey=https://d2t3ff60b2tol4.cloudfront.net/repomd.xml.key" > /etc/yum.repos.d/insync.repo'
  sudo dnf install -y insync
fi

# Firewall
sudo dnf install -y firewalld
sudo systemctl unmask firewalld
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --set-default-zone=home
sudo firewall-cmd --remove-service=ssh --permanent --zone=home
sudo firewall-cmd --reload
sudo dnf install -y firewall-config

echo -e "${PURPLE}Freeing up disk space...${RESET}"
sudo dnf clean all

echo -e "${PURPLE}Finished installing / updating Fedora packages.${RESET}"

# EOF
