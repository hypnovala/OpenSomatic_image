#!/usr/bin/env bash
set -euo pipefail
TZ="America/Chicago"; export TZ
TODAY="$(date +%F)"

echo "PIPELINE AM — $TODAY"

# 1) Run lane generators (by cron run IDs you already have)
openclaw cron run 8403e840-5c70-44cd-9a8c-1e13a33bf073
openclaw cron run 0df96ad7-d7ed-418b-8618-f97e797a457d

# 2) Images (use your IMAGES cron id)
openclaw cron run 759e972c-485c-45b8-844e-4a71cbfca3a5

# 3) Push
openclaw workspace-sync sync --direction push

echo "DONE AM — pushed to Drive"
