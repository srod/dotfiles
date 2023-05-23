#!/usr/bin/env bash

echo -e "${PURPLE}Generating an SSH key${RESET}"

read -r -p "Email: " email

ssh-keygen -t ed25519 -C $email -f ~/.ssh/id_ed25519
eval "$(ssh-agent -s)"
touch ~/.ssh/config
if [ "$(uname -s)" = "Darwin" ]; then
  echo "Host *\n AddKeysToAgent yes\n UseKeychain yes\n IdentityFile ~/.ssh/id_ed25519" | tee ~/.ssh/config
  ssh-add --apple-use-keychain ~/.ssh/id_ed25519
else
  echo "Host *\n AddKeysToAgent yes\n IdentityFile ~/.ssh/id_ed25519" | tee ~/.ssh/config
  ssh-add ~/.ssh/id_ed25519
fi
