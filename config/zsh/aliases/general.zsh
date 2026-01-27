command_exists () {
  hash "$1" 2> /dev/null
}

# If eza installed, use it for ls commands
if command_exists eza ; then
  alias ls='eza --icons=always --color=always --git'
  alias ll='eza --icons=always --color=always --git -lAh'
else
  alias la='ls -A' # List all files/ includes hidden
  alias ll='ls -lAFh' # List all files, with full details
  alias lb='ls -lhSA' # List all files sorted by biggest
  alias lm='ls -tA -1' # List files sorted by last modified
fi

# Finding files and directories
alias dud='du -d 1 -h' # List sizes of files within directory
alias duf='du -sh *' # List total size of current directory
alias ff='find . -type f -name' # Find a file by name within current directory
(( $+commands[fd] )) || alias fd='find . -type d -name' # Find directory by name

# External Services
alias myip='curl icanhazip.com'
alias weather='curl "fr.wttr.in/77600"'
alias weather-short='curl "fr.wttr.in/77600?format=3"'
alias worldinternet='curl https://status.plaintext.sh/t'

# Re-run last cmd as root
alias plz="fc -l -1 | cut -d' ' -f2- | xargs sudo"

# Hledger alias, with multiple journal files
alias hl='hledger-ui -f ~/Library/CloudStorage/OneDrive-Personal/hledger/2026.journal \
                     -f ~/Library/CloudStorage/OneDrive-Personal/hledger/2025.journal \
                     --forecast'

alias hlweb='hledger-web -f ~/Library/CloudStorage/OneDrive-Personal/hledger/2026.journal \
                         -f ~/Library/CloudStorage/OneDrive-Personal/hledger/2025.journal \
                        --forecast'
