-- Key bindings, ported from tmux/keybindings.conf.
--
-- Ctrl+B is the prefix, as in tmux. Rex's own Cmd shortcuts (Cmd+T, Cmd+D,
-- Cmd+K, ...) keep working alongside these.

local prefix = "ctrl+b>"

local function bind(key, action, args)
  rex.bind(prefix .. key, action, args)
end

-- Press the prefix twice to send one Ctrl+B to the terminal
bind("ctrl+b", "pane.send_key", { key = "ctrl+b" })

-- Reload config
bind("r", "client.config.reload")

-- Split panes using | and -
bind("shift+\\", "pane.split", { direction = "right" })
bind("-", "pane.split", { direction = "down" })

-- tmux defaults for splits: % and "
bind("shift+5", "pane.split", { direction = "right" })
bind("shift+'", "pane.split", { direction = "down" })

-- Tabs (tmux windows)
bind("c", "client.tab.new")
bind("n", "client.tab.next")
bind("p", "client.tab.previous")
bind(",", "client.tab.rename")
bind("shift+7", "client.tab.close") -- &
for i = 1, 9 do
  bind(tostring(i), "client.tab.goto", { index = i })
end

-- Panes
bind("left", "pane.focus", { direction = "left" })
bind("right", "pane.focus", { direction = "right" })
bind("up", "pane.focus", { direction = "up" })
bind("down", "pane.focus", { direction = "down" })
bind("o", "pane.focus_next")
bind("z", "pane.zoom")
bind("x", "pane.close")
bind("shift+1", "pane.move_to_new_tab") -- !
bind("space", "pane.balance")

-- Resize panes. tmux repeats prefix + Ctrl+arrow without the prefix (bind -r);
-- here the first press also enters a resize mode, where the arrows keep
-- resizing until Escape or Enter.
rex.mode("resize", { exclusive = true })
rex.action{
  name  = "resize_start",
  title = "Resize Pane and Enter Resize Mode",
  args  = { direction = "string" },
  run   = function(ctx, args)
    rex.client.queue("pane.resize", { direction = args.direction })
    rex.client.queue("client.mode.enter", { name = "resize" })
  end,
}
for _, direction in ipairs({ "left", "right", "up", "down" }) do
  bind("ctrl+" .. direction, "resize_start", { direction = direction })
  rex.bind("resize/" .. direction, "pane.resize", { direction = direction })
  rex.bind("resize/ctrl+" .. direction, "pane.resize", { direction = direction })
  rex.bind("resize/shift+" .. direction, "pane.resize", { direction = direction, amount = 15 })
end
rex.bind("resize/=", "pane.balance")
rex.bind("resize/enter", "client.mode.exit")

-- Sessions
bind("s", "session.switch")
bind("shift+4", "session.rename") -- $
bind("shift+9", "session.previous") -- (
bind("shift+0", "session.next") -- )

-- Copy mode (vi keys are Rex's default there)
bind("[", "pane.copy_mode.enter")
