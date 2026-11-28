#!/usr/bin/env bash

# Rex app settings, ported from ghostty/config.ghostty.
#
# Rex keeps fonts, colours, cursor and padding in the app's settings rather
# than in init.lua, so this script applies them through the app's actions.
# It needs Rex running, with Remote Control turned on in Settings > General.
#
# Not ported, because Rex has no matching setting:
#   shell-integration, term, window-decoration

DOTFILES=${DOTFILES:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}

if ! command -v rex &>/dev/null; then
  echo "Rex CLI not found. Skipping Rex settings."
  exit 0
fi

setting() {
  local output
  if ! output=$(rex do "$@" 2>&1); then
    echo "  Failed: rex do $*"
    echo "  $output"
    echo "Open Rex, turn on Remote Control in Settings > General, then run: make rex"
    exit 1
  fi
}

echo "Applying Rex settings..."

# Appearance (Ghostty uses one dark palette whatever the system appearance)
setting client.setting.interface.appearance.scheme value=dark
setting client.theme.import path="$DOTFILES/rex/themes/dotfiles.ghostty"
setting client.setting.terminal.selection.foreground value=theme
setting client.setting.terminal.selection.background value=theme

# Translucent background (background-opacity = 0.9). Rex has no opacity
# percentage, so see-through panes come from the Glass style instead.
setting client.setting.interface.appearance.style value=glass
setting client.setting.interface.appearance.glass value=true

# Cell Spacing (adjust-cell-height = 50%, adjust-cell-width = 1)
setting client.setting.terminal.typography.line_height value=50
setting client.setting.terminal.advanced_fonts.character_spacing value=1px

# Cursor
setting client.setting.terminal.cursor.style value=block
setting client.setting.terminal.cursor.blink value=normal

# Font
setting client.setting.terminal.typography.font value="FiraCode Nerd Font"
setting client.setting.terminal.typography.size value=13
setting client.setting.terminal.advanced_fonts.ligatures value=true

# Terminal
setting client.setting.terminal.selection.copy_on_select value=true

# Keyboard
# Show the keys that can follow the Ctrl+B prefix
setting client.setting.terminal.keyboard.sequence_hints value=true
# Left Option sends Alt for Neovim's <A-j>/<A-k>; right Option still types symbols
setting client.setting.terminal.keyboard.option value=left_sends_alt

# Tabs
# Name tabs after the running program, like tmux's window-status-format
setting client.setting.terminal.titles.prefer_generated value=true

# Window
# Force the terminal to use the macOS native wide color gamut
setting client.setting.terminal.colors.display_p3 value=true
setting client.setting.interface.pane_padding.horizontal value=8
setting client.setting.interface.pane_padding.vertical value=8

echo "Rex settings applied."
