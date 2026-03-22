#!/usr/bin/env bash
# Catppuccin Mocha color palette (hex values from ~/.config/starship.toml)
# Colors are rendered in a dimmed terminal context by Claude Code's status line.

# Catppuccin Mocha
PEACH="\033[38;2;250;179;135m"   # #fab387 - directory
YELLOW="\033[38;2;249;226;175m"  # #f9e2af - git branch
SAPPHIRE="\033[38;2;116;199;236m" # #74c7ec - model
LAVENDER="\033[38;2;180;190;254m" # #b4befe - context
OVERLAY1="\033[38;2;127;132;156m" # #7f849c - separators / muted
RESET="\033[0m"

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
# Replace $HOME with ~ then strip leading ~/
home_dir="$HOME"
short_dir="${cwd/#$home_dir\//}"
# If the path equals home exactly, show basename; otherwise show last 2 segments
if [ "$cwd" = "$home_dir" ]; then
  short_dir="~"
elif [ "$short_dir" = "$cwd" ]; then
  # Path is not under home - show last 2 path segments
  short_dir=$(echo "$cwd" | awk -F'/' '{if(NF>2) print $(NF-1)"/"$NF; else print $NF}')
else
  # Path is under home - show last 2 segments of the relative path
  short_dir=$(echo "$short_dir" | awk -F'/' '{if(NF>2) print $(NF-1)"/"$NF; else print $0}')
fi

model=$(echo "$input" | jq -r '.model.display_name // empty')

used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Git branch detection - skip optional locks to avoid contention
branch=""
if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(git -C "$cwd" -c core.hooksPath=/dev/null symbolic-ref --short HEAD 2>/dev/null \
    || git -C "$cwd" -c core.hooksPath=/dev/null rev-parse --short HEAD 2>/dev/null)
fi

# Build status line segments
sep="${OVERLAY1}|${RESET}"

out=""

# Directory segment
out="${out}${PEACH}${short_dir}${RESET}"

# Git branch segment (only when in a repo)
if [ -n "$branch" ]; then
  out="${out} ${sep} ${YELLOW} ${branch}${RESET}"
fi

# Model segment
if [ -n "$model" ]; then
  out="${out} ${sep} ${SAPPHIRE}${model}${RESET}"
fi

# Context usage segment
if [ -n "$used_pct" ]; then
  used_int=$(printf '%.0f' "$used_pct")
  out="${out} ${sep} ${LAVENDER}ctx:${used_int}%${RESET}"
fi

printf "%b" "$out"
