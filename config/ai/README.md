# AI / Agent setup

Portable config + reinstall manifests for my AI tools.
Secrets and tool-generated files (auth, sessions, caches, hooks) stay local — only
manifests and hand-authored config live here.

## Fresh-machine restore

1. **CLI tools** — `brew bundle` installs `rtk` (see `scripts/installs/Brewfile`).
2. **Bun globals** — `install.sh` runs `bun add -g $(cat scripts/installs/npmfile)`,
   which includes **caveman** (`@juliusbrussee/caveman-code`) and **opencode** (`opencode-ai`).
   caveman then regenerates its own Claude/Codex hooks + `~/.claude/settings.json` entries.
3. **Skills** — `skills/skill-lock.json` tracks only the skills you added via
   `npx skills add -g` (skills.sh). Restore by copying it to `~/.agents/.skill-lock.json`.
   NOTE: `npx skills list -g` shows more skills than the lock — the extras are installed
   by caveman/ponytail/Codex themselves (they don't write to skills.sh's lock), so they
   come back via those tools, not here. Keep the lock free of ghost entries (skills gone
   from disk) or `npx skills update`/`remove` will error.
4. **Pi plugins** — `cp pi/package.json ~/.pi/agent/npm/ && (cd ~/.pi/agent/npm && npm install)`.
5. **OpenCode instructions** — `opencode/AGENTS.md` is symlinked to `~/.config/opencode/AGENTS.md`.

## Ponytail — https://github.com/DietrichGebert/ponytail

Per-agent plugin (YAGNI / "lazy senior dev" ruleset). Reinstall per host:

- **Claude Code**: `/plugin marketplace add DietrichGebert/ponytail` then `/plugin install ponytail@ponytail`
- **Codex**: `codex plugin marketplace add DietrichGebert/ponytail` then `/plugins` → install
- **OpenCode**: add `"plugin": ["@dietrichgebert/ponytail"]` to `opencode.json`
- **Pi**: `pi install git:github.com/DietrichGebert/ponytail`
- **Copilot CLI**: `copilot plugin marketplace add DietrichGebert/ponytail` then `copilot plugin install ponytail@ponytail`

> `skill-lock.json` and `pi/package.json` are snapshots — refresh them when you add/remove skills or plugins.
