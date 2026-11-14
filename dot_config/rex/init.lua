-- Keybindings ported from ~/.config/tmux/tmux.conf (prefix C-Space).

local prefix = "ctrl+space"

-- C-Space C-Space sends a ctrl-space to the app
rex.bind(prefix .. ">" .. prefix, "pane.send_key", { key = "ctrl+space" })

-- <prefix> c: new tab (tmux new-window)
rex.bind(prefix .. ">c", "client.tab.new")

-- <prefix> s: session picker (tmux sesh popup)
rex.bind(prefix .. ">s", "session.switch")

-- <prefix> | and -: split right / down
rex.bind(prefix .. ">shift+\\", "pane.split.right")
rex.bind(prefix .. ">-", "pane.split.down")

-- Shift arrow to switch tabs
rex.bind("shift+left", "client.tab.previous")
rex.bind("shift+right", "client.tab.next")

-- <prefix> r: resize mode; h/j/k/l resize until Escape or Enter
rex.mode("resize", { exclusive = true })
rex.bind(prefix .. ">r", "client.mode.enter", { name = "resize" })
rex.bind("resize/h", "pane.resize", { direction = "left" })
rex.bind("resize/j", "pane.resize", { direction = "down" })
rex.bind("resize/k", "pane.resize", { direction = "up" })
rex.bind("resize/l", "pane.resize", { direction = "right" })
rex.bind("resize/enter", "client.mode.exit")

-- ctrl+h/j/k/l: vim-tmux-navigator style. When (n)vim or fzf is in the
-- foreground the key passes through to it; otherwise focus moves to the
-- neighbouring pane.
local function is_vim(block_id)
  if block_id == nil then return false end
  local ok, p = pcall(rex.block.call, "com.superlogical.terminal", "process", { block_id = block_id })
  if not ok or type(p) ~= "table" or p.foreground == nil then return false end
  local name = p.foreground.argv0 or p.foreground.name or ""
  name = name:match("[^/]*$")
  return name:match("^g?n?vim?x?$") ~= nil or name == "view" or name == "fzf"
end

for key, dir in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
  rex.bind("ctrl+" .. key, function(ctx, ev)
    if is_vim(ctx.block_id) then return false end
    rex.session.focus_direction{ direction = dir }
    return true
  end)
end
