#!/usr/bin/env bash
set -euo pipefail

TZ="America/Chicago"
export TZ
TODAY="$(date +%F)"
ROOT="/Users/hypvalaagent/.openclaw/workspace/shared/daily"

lane_report () {
  lane="$1"
  dir="$ROOT/$lane/$TODAY"

  echo ""
  echo "Lane: $lane"
  echo "Folder: $dir"

  if [ ! -d "$dir" ]; then
    echo "  folder: MISSING"
    return
  fi

  posts=$(find "$dir" -maxdepth 1 -type f -name "post-*.txt" 2>/dev/null | wc -l | tr -d ' ')
  prompts=$(find "$dir" -maxdepth 1 -type f -name "post-*-image-prompts.txt" 2>/dev/null | wc -l | tr -d ' ')
  zips=$(find "$dir" -maxdepth 1 -type f -name "post-*-images.zip" 2>/dev/null | wc -l | tr -d ' ')

  echo "  posts (.txt): $posts"
  echo "  prompts: $prompts"
  echo "  image zips: $zips"

  if [ -f "$dir/_review.json" ]; then
    echo "  risk file: present"
  else
    echo "  risk file: none"
  fi
}

echo "DAILY REVIEW — $TODAY ($TZ)"

lane_report "lane-b"
lane_report "lane-c"

echo ""
echo "Drive push reminder:"
echo "openclaw workspace-sync sync --direction push"