# ZSH CONFIGURATION

## OVERVIEW

Modular ZSH config with Antigen plugin manager, Powerlevel10k theme, XDG-compliant paths. Entry: `.zshrc`

## STRUCTURE

```
zsh/
├── .zshenv         # XDG paths, EDITOR, env vars (sourced FIRST, always)
├── .zshrc          # Main orchestrator - sources everything below
├── .zprofile       # Login shell only (pipx PATH)
├── .p10k.zsh       # Powerlevel10k theme config (1718 lines)
├── helpers/
│   ├── setup-antigen.zsh    # Plugin manager init (curl if missing)
│   ├── import-plugins.zsh   # Antigen bundles (20+ plugins)
│   └── misc-stuff.zsh       # Runtime: pnpm, bun, fnm paths
├── aliases/
│   ├── general.zsh    # ls/eza, du, find, curl, hledger
│   ├── git.zsh        # ga, gc, gd, gs, gco, gpr (308 lines)
│   └── node-js.zsh    # NVM lazy-load, npm aliases
└── lib/
    ├── history.zsh      # 50k history, dedup, timestamp
    ├── completion.zsh   # Cache, styling, kill/man/ssh completions
    ├── key-bindings.zsh # Emacs mode, history search, Ctrl+Arrow
    ├── colors.zsh       # TERM=xterm-256color
    └── ...              # cursor, navigation, expansions, surround, term-title
```

## SOURCING ORDER (CRITICAL)

```
1. .zshenv          # XDG vars, ZDOTDIR, EDITOR (always first)
2. .zshrc           # Interactive shell entry
   ├── p10k instant prompt
   ├── utils/* (transfer, matrix, hr, web-search, am-i-online, color-map, dot)
   ├── helpers/setup-antigen.zsh
   ├── helpers/import-plugins.zsh
   ├── helpers/misc-stuff.zsh
   ├── aliases/* (general, git, node-js, alias-tips)
   ├── lib/* (colors, cursor, history, surround, completion, term-title, navigation, expansions, key-bindings)
   └── .p10k.zsh (again at end)
```

**Order matters**: Antigen must init before bundles. Plugins before aliases (for oh-my-zsh git aliases).

## WHERE TO LOOK

| Task | Location |
|------|----------|
| Add env var | `.zshenv` |
| Add plugin | `helpers/import-plugins.zsh` |
| Add alias | `aliases/{general,git,node-js}.zsh` |
| Change history | `lib/history.zsh` |
| Change keybindings | `lib/key-bindings.zsh` |
| Change prompt | `.p10k.zsh` (or run `p10k configure`) |

## CONVENTIONS

**Aliases:**
- Check before alias: `command_exists eza` then alias
- Short prefixes: `ga`=git add, `gc`=git commit, `gco`=git checkout

**Variables:**
- `zsh_dir=${ZDOTDIR}` - used throughout .zshrc
- `utils_dir=${XDG_CONFIG_HOME}/utils` - utility scripts location

**Plugins (Antigen):**
```zsh
antigen use oh-my-zsh              # Base library
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen theme romkatv/powerlevel10k
antigen apply                      # MUST call at end
```

## ANTI-PATTERNS

- **Duplicate p10k source**: Lines 41 & 83 both source .p10k.zsh (redundant)
- **Dead code**: Lines 77-138 in .zshrc are commented-out FZF/Android/Ruby configs
- **Missing shebangs**: 4 lib files lack shebang (cursor, expansions, key-bindings, navigation)

## NOTES

- **Antigen location**: `$XDG_CACHE_HOME/zsh/antigen` (auto-downloads if missing)
- **History file**: `$XDG_CACHE_HOME/zsh/history` (50k entries)
- **Completion cache**: `.zcompcache/` in this directory
- **macOS-specific**: Homebrew PATH added conditionally in .zshrc
