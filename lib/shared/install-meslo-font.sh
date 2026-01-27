# Meslo Nerd Font installer (Linux only)
install_meslo_font() {
  echo -e "${PURPLE}Installing Meslo font${RESET}"
  mkdir -p ~/.fonts
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Meslo.zip
  unzip Meslo.zip -d ~/.fonts
  fc-cache -fv
  rm -f Meslo.zip
}
