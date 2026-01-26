# DOTFILES KNOWLEDGE BASE

**Generated:** 2026-01-26
**Commit:** 5e0c27f
**Branch:** main

## OVERVIEW

Personal dotfiles repo (srod/dotfiles) with multi-platform support (macOS, Arch, Debian, Fedora). Uses Dotbot for symlink management, Antigen for ZSH plugins, XDG Base Directory compliance throughout.

## STRUCTURE

```
.dotfiles/
├── install.sh          # Main orchestrator (502 lines) - runs all setup phases
├── lets-go.sh          # Remote bootstrap: curl | bash entry point
├── symlinks.yaml       # Dotbot config - declarative symlink definitions
├── config/
│   ├── zsh/            # ZSH config (see config/zsh/AGENTS.md)
│   ├── vim/            # Vim config + plug.vim
│   ├── general/        # Shared configs (.gitconfig, .bashrc, topgrade.toml)
│   └── ghostty/        # Ghostty terminal config
├── scripts/
│   ├── installs/       # Package managers (Brewfile, apt, pacman, dnf, flatpak)
│   ├── macos-setup/    # macOS preferences + security hardening
│   └── linux/          # Linux-specific (dconf)
├── utils/              # 14 utility scripts (sourced in .zshrc)
└── lib/dotbot/         # Git submodule (external)
```

## WHERE TO LOOK

| Task | Location | Notes |
|------|----------|-------|
| Add symlink | `symlinks.yaml` | Uses XDG vars, conditional `if:` supported |
| Add macOS app | `scripts/installs/Brewfile` | Homebrew bundle format |
| Add Linux pkg | `scripts/installs/{debian-apt,arch-pacman,fedora-dnf}.sh` | OS-specific |
| Add alias | `config/zsh/aliases/` | Group by domain (general, git, node-js) |
| Add ZSH plugin | `config/zsh/helpers/import-plugins.zsh` | Antigen bundle format |
| Add utility | `utils/` | Follow dual-mode pattern, source in .zshrc |
| macOS prefs | `scripts/macos-setup/macos-preferences.sh` | NSDefaults commands |

## CONVENTIONS

**Shell Scripts:**
- Shebang: `#!/usr/bin/env bash` (portable)
- Colors: `CYAN_B`, `YELLOW_B`, `RED_B`, `GREEN_B`, `RESET` at top of script
- Check commands: `command_exists() { hash "$1" 2>/dev/null; }`
- Progress: `current_event/total_events` counter pattern (macos-setup)

**Paths:**
- XDG compliant: `$XDG_CONFIG_HOME` (~/.config), `$XDG_DATA_HOME` (~/.local/share)
- ZSH root: `$ZDOTDIR` = `$XDG_CONFIG_HOME/zsh`
- Dotfiles: `$DOTFILES` = `$HOME/.dotfiles`

**Utilities:**
- Dual-mode execution: works as both standalone script and sourced function
- Function prefix: `aio_*` for multi-operation utilities
- Help: implement `--help` / `-h` flag

## ANTI-PATTERNS

- **No `set -e`**: Most scripts lack error handling. Don't assume failure stops execution.
- **Missing execute perms**: Scripts in `scripts/installs/` may need `chmod +x`
- **Duplicate color vars**: Each script redefines colors (not centralized)
- **Commented code**: `.zshrc` has ~60 lines of disabled config (lines 77-138)

## INSTALL FLOW

```
lets-go.sh (curl | bash)
    └── install.sh
        ├── pre_setup_tasks()     # Check requirements, set XDG vars
        ├── setup_dot_files()     # Git clone/pull, run Dotbot
        ├── install_packages()    # OS-specific (Brew/apt/pacman/dnf/flatpak)
        ├── apply_preferences()   # ZSH plugins, macOS prefs
        └── finishing_up()        # Reload shell, summary
```

**Flags:** `--auto-yes` (skip prompts), `--no-clear`, `--help`

## COMMANDS

```bash
# Full install (interactive)
./install.sh

# Remote bootstrap
bash <(curl -s https://raw.githubusercontent.com/srod/dotfiles/main/lets-go.sh)

# Update system + packages
dot --update   # or just: dot

# Edit dotfiles in IDE
dot --edit
```

## NOTES

- **Dotbot**: Symlinks managed declaratively via `symlinks.yaml`, not manual `ln -s`
- **Plugin manager**: Antigen (auto-installs if missing via curl)
- **Timeout prompts**: 15s default, 1s with `--auto-yes`
- **macOS tasks**: 100+ NSDefaults per script in macos-setup/
- **lib/dotbot**: External submodule - don't edit, update via `git submodule update`
