# macOS compatibility check. Source at top of macOS-only scripts.
# Expects semantic color vars: PRIMARY_COLOR, ACCENT_COLOR, RESET_COLOR.
macos_only() {
  if [ ! "$(uname -s)" = "Darwin" ]; then
    echo -e "${PRIMARY_COLOR}Incompatible System${RESET_COLOR}"
    echo -e "${ACCENT_COLOR}This script is specific to Mac OS,\
 and only intended to be run on Darwin-based systems${RESET_COLOR}"
    echo -e "${ACCENT_COLOR}Exiting...${RESET_COLOR}"
    exit 1
  fi
}
