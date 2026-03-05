#!/usr/bin/env bash
set -euo pipefail
TZ="America/Chicago"; export TZ
TODAY="$(date +%F)"

echo "PIPELINE PM — $TODAY"

# PM lane generation needs separate PM jobs (we will create them)
openclaw cron run <LANE_B_PM_ID>
openclaw cron run <LANE_C_PM_ID>

# PM Images cron (we will create it)
openclaw cron run <IMAGES_PM_ID>

# Push
openclaw workspace-sync sync --direction push

echo "DONE PM — pushed to Drive"