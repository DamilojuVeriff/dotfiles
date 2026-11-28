--------------------------------------------------------------------------
-- Rex configuration, ported from tmux/tmux.conf
--------------------------------------------------------------------------
--
-- This directory is linked to ~/.config/rex. Reload with `rex config reload`
-- (or prefix + r), and validate with `rex config check`.
--
-- Fonts, colours, cursor and padding are app settings rather than Lua. They
-- are ported from ghostty/config.ghostty by rex/settings.sh.
--
-- tmux options with no counterpart here are built into Rex: mouse support,
-- true colour, undercurl, hyperlinks, focus events, vi keys in copy mode and
-- tab numbering from 1.

--------------------------------------------------------------------------
-- Key Bindings
--------------------------------------------------------------------------

require("keybindings")

--------------------------------------------------------------------------
-- Session restore
--------------------------------------------------------------------------
--
-- Replaces tmux-resurrect and tmux-continuum. The Rex server restores
-- sessions, tabs and panes by itself, and its built-in rules resume Claude
-- Code. ssh and lazygit (@resurrect-processes) don't report a resume command,
-- so their panes come back as a shell in the same directory.

-- Only resume Claude Code in projects under ~/Code. rex.set is missing from
-- older Rex builds, so this is skipped there.
if rex.set then
  rex.set("resume.trust.claude.dir", "~/Code")
end
