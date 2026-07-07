#!/usr/bin/env bash

# simkill — kill iOS simulators + Android emulators, flush inactive memory.
# Frees CPU/RAM hogs from Tauri mobile dev. Swap clears only on reboot.
# Sourced from .zshrc; run `simkill` to invoke.

simkill() {
  echo "→ iOS simulators…"
  xcrun simctl shutdown all 2>/dev/null
  if killall Simulator 2>/dev/null; then echo "  Simulator killed"; else echo "  Simulator not running"; fi

  echo "→ Android emulators…"
  if command -v adb >/dev/null 2>&1; then
    adb devices 2>/dev/null | awk '/emulator/{print $1}' | while read -r e; do
      adb -s "$e" emu kill 2>/dev/null
    done
    adb kill-server 2>/dev/null
    echo "  adb stopped"
  else
    echo "  adb not in PATH, skipped"
  fi

  echo "→ Flushing inactive memory (sudo purge — asks password)…"
  sudo purge && echo "  purged (swap clears only on reboot)"

  echo "→ Swap now:"; sysctl -n vm.swapusage
}
