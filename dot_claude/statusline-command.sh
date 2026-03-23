#!/usr/bin/env bash
# Catppuccin Mocha color palette (hex values from ~/.config/starship.toml)
# Colors are rendered in a dimmed terminal context by Claude Code's status line.

# Catppuccin Mocha
PEACH="\033[38;2;250;179;135m"    # #fab387 - directory
YELLOW="\033[38;2;249;226;175m"   # #f9e2af - vcs branch
SAPPHIRE="\033[38;2;116;199;236m" # #74c7ec - model
LAVENDER="\033[38;2;180;190;254m" # #b4befe - context
OVERLAY1="\033[38;2;127;132;156m" # #7f849c - separators / muted
RESET="\033[0m"

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
home_dir="$HOME"

# Shorten a path to at most 2 components, with ~ substitution and ../ prefix
# when truncation occurs. Matches the display rules in the spec.
shorten_path() {
  local path="$1"
  if [ "$path" = "$home_dir" ]; then
    echo "~"
    return
  fi
  # Replace leading $HOME/ with ~/
  local rel="${path/#$home_dir\//~\/}"
  # Count components: split on / (ignoring leading ~)
  local stripped="${rel#\~/}"
  # Direct child of home: ~/dirname - no truncation needed
  if [ "$rel" != "$path" ] && [[ "$stripped" != */* ]]; then
    echo "$rel"
    return
  fi
  # Two or more levels deep (under home or absolute): show .../parent/current
  local parent
  local current
  parent=$(basename "$(dirname "$path")")
  current=$(basename "$path")
  echo ".../${parent}/${current}"
}

short_dir=$(shorten_path "$cwd")

model=$(echo "$input" | jq -r '.model.display_name // empty')

remaining_pct=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')

# Walk up from a directory looking for .jj or .git, returning the root path.
find_vcs_root() {
  local dir="$1"
  local marker="$2"
  while [ "$dir" != "/" ]; do
    if [ -d "${dir}/${marker}" ]; then
      echo "$dir"
      return 0
    fi
    dir=$(dirname "$dir")
  done
  return 1
}

# Detect VCS type and collect branch + repo root.
vcs_label=""
vcs_branch=""
vcs_root=""

jj_root=$(find_vcs_root "$cwd" ".jj")
git_root=$(find_vcs_root "$cwd" ".git")

if [ -n "$jj_root" ] && [ -n "$git_root" ]; then
  # Co-located: .jj and .git are both present; use the shallower (or same) root.
  # Prefer the jj root for the label, git for branch resolution.
  vcs_label="jj (git)"
  vcs_root="$jj_root"
  vcs_branch=$(git -C "$git_root" -c core.hooksPath=/dev/null symbolic-ref --short HEAD 2>/dev/null \
    || git -C "$git_root" -c core.hooksPath=/dev/null rev-parse --short HEAD 2>/dev/null)
elif [ -n "$jj_root" ]; then
  vcs_label="jj"
  vcs_root="$jj_root"
  # Show the short change ID (8 chars) so every commit is identifiable, plus the
  # bookmark name in parens when one exists. This is more useful than bookmarks alone
  # since anonymous changes are the norm in jj workflows.
  change_id=$(jj log -r @ --no-graph -T 'change_id.short(8)' -R "$jj_root" 2>/dev/null)
  bookmark_suffix=$(jj log -r @ --no-graph -T 'if(bookmarks, " (" ++ bookmarks ++ ")")' -R "$jj_root" 2>/dev/null)
  vcs_branch="${change_id}${bookmark_suffix}"
elif [ -n "$git_root" ]; then
  vcs_label="git"
  vcs_root="$git_root"
  vcs_branch=$(git -C "$git_root" -c core.hooksPath=/dev/null symbolic-ref --short HEAD 2>/dev/null \
    || git -C "$git_root" -c core.hooksPath=/dev/null rev-parse --short HEAD 2>/dev/null)
fi

short_vcs_root=""
if [ -n "$vcs_root" ]; then
  short_vcs_root=$(shorten_path "$vcs_root")
fi

# Build the two-line status output.
sep="${OVERLAY1}|${RESET}"

# Line 1: dir | model | ctx remaining
line1="${PEACH}${short_dir}${RESET}"

if [ -n "$model" ]; then
  line1="${line1} ${sep} ${SAPPHIRE}${model}${RESET}"
fi

if [ -n "$remaining_pct" ]; then
  remaining_int=$(printf '%.0f' "$remaining_pct")
  line1="${line1} ${sep} ${LAVENDER}ctx: ${remaining_int}% remaining${RESET}"
fi

out="$line1"

# Line 2 (only inside a VCS repo): vcs | repo root | branch
if [ -n "$vcs_label" ]; then
  line2="${OVERLAY1}${vcs_label}${RESET}"
  line2="${line2} ${sep} ${PEACH}${short_vcs_root}${RESET}"
  if [ -n "$vcs_branch" ]; then
    line2="${line2} ${sep} ${YELLOW}${vcs_branch}${RESET}"
  fi
  out="${out}\n${line2}"
fi

printf "%b" "$out"
