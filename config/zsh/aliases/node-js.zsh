######################################################################
# ZSH aliases and helper functions for Node.js / web development     #
# Includes aliases for yarn, npm, fnm, npx, node, react, etc         #
#                                                                    #
# Licensed under MIT (C) Alicia Sykes 2022 <https://aliciasykes.com> #
######################################################################

# Yarn - Project commands
# alias ys='yarn start'
# alias yt='yarn test'
# alias yb='yarn build'
# alias yl='yarn lint'
# alias yd='yarn dev'
# alias yp='yarn publish'
# alias yr='yarn run'

# # Yarn - Package management
# alias ya='yarn add'
# alias ye='yarn remove'
# alias yi='yarn install'
# alias yg='yarn upgrade'
# alias yu='yarn update'
# alias yf='yarn info'

# # Yarn - Misc
# alias yz='yarn audit'
# alias yc='yarn autoclean'
# alias yk='yarn check'
# alias yh='yarn help'

# Auto-Node version switching handled by fnm --use-on-cd (see misc-stuff.zsh)
autoload -U add-zsh-hook

# Nuke - Helper to remove node_modules and the lock file, then reinstall
reinstall_modules () {
  if read -q "choice?Remove and reinstall all node_modules? (y/N)"; then
    echo
    project_dir=$(pwd)
    # Check file exists, remove it and print message
    check-and-remove() {
      if [ -d "$project_dir/$1" ]; then
        echo -e "\e[35mRemoving $1...\e[0m"
        rm -rf "$project_dir/$1"
      fi
    }
    # Delete node_modules and lock files
    check-and-remove 'node_modules'
    check-and-remove 'yarn.lock'
    check-and-remove 'package-lock.json'
    # Reinstall with PNPM (or yarn or NPM)
    if hash 'pnpm' 2> /dev/null; then
      echo -e "\e[35mReinstalling with pnpm...\e[0m"
      pnpm install
    elif hash 'yarn' 2> /dev/null; then
      echo -e "\e[35mReinstalling with yarn...\e[0m"
      yarn
      echo -e "\e[35mCleaning Up...\e[0m"
      yarn autoclean
    elif hash 'npm' 2> /dev/null; then
      echo -e "\e[35mReinstalling with NPM...\e[0m"
      npm install
    else
      echo -e "🚫\033[0;91m Unable to proceed, pnpm/ yarn/ npm not installed\e[0m"
    fi
  else
    # Cancelled by user
    echo -e "\n\033[0;91mAborting...\e[0m"
  fi
}

alias node-nuke='reinstall_modules'

# Prints out versions of core Node.js packages
print_node_versions () {
  versions=''
  format_version_number () {
    echo "$($1 --version 2>&1 | head -n 1 | sed 's/[^0-9.]*//g')"
  }

  get_version () {
    if hash $1 2> /dev/null || command -v $1 >/dev/null; then
      versions="$versions\e[36m\e[1m $2: \033[0m$(format_version_number $1) \n\033[0m"
    else
      versions="$versions\e[33m\e[1m $2: \033[0m\033[3m Not installed\n\033[0m"
    fi
  }
  # Print versions of core Node things
  get_version 'node' 'Node.js'
  get_version 'npm' 'NPM'
  get_version 'corepack' 'Corepack'
  get_version 'yarn' 'Yarn'
  get_version 'fnm' 'fnm'
  get_version 'ni' 'ni'
  get_version 'pnpm' 'pnpm'
  get_version 'tsc' 'TypeScript'
  get_version 'bun' 'Bun'
  get_version 'deno' 'Deno'
  get_version 'git' 'Git'
  echo -e $versions
}

alias node-versions='print_node_versions'

# Legacy support for NPM
# alias npmi='npm install'
# alias npmu='npm uninstall'
# alias npmr='npm run'
# alias npms='npm start'
# alias npmt='npm test'
# alias npml='npm run lint'
# alias npmd='npm run dev'
# alias npmp='npm publish'

# fnm aliases
alias fnmi='fnm install'
alias fnmu='fnm use'
alias fnml='fnm list'
alias fnmlr='fnm list-remote'
alias fnmlts='fnm install --lts && fnm use lts-latest'
alias fnmlatest='fnm install latest && fnm use latest'

# Helper function that gets supported open method for system
# launch-url() {
#   if hash open 2> /dev/null; then
#     open_command=open
#   elif hash xdg-open 2> /dev/null; then
#     open_command=xdg-open
#   elif hash lynx 2> /dev/null; then
#     open_command=lynx
#   else
#     echo -e "\033[0;33mUnable to launch browser, open manually instead"
#     echo -e "\033[1;96m🌐 URL: \033[0;96m\e[4m$1\e[0m"
#     return;
#   fi
#   echo $open_command $1
# }

# # Open Node.js docs, either specific page or show all
# function node-docs {
#   local section=${1:-all}
#   $(launch-url "https://nodejs.org/docs/$(node --version)/api/$section.html")
# }

# Launches npmjs.com on the page of a specific module
# open-npm () {
#   npm_base_url=https://www.npmjs.com
#   if [ $# -ne 0 ]; then
#     # Get NPM module name from user input
#     npm_url=$npm_base_url/package/$@
#   else
#     # Unable to get NPM module name, default to homepage
#     npm_url=$npm_base_url
#   fi
#   # Print messages
#   echo -e "\033[1;96m📦 Opening in browser: \033[0;96m\e[4m$npm_url\e[0m"
#   # And launch!
#   $(launch-url $npm_url)
# }

# alias npmo='open-npm'
