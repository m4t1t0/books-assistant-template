#!/usr/bin/env bash
# Wipe .git and re-init with an 'Initial commit from books-assistant
# template' commit. The caller (setup flow / agent) is responsible for
# confirming with the user before invoking this — the script itself has
# no safety guards.

set -euo pipefail

# cd -P resolves symlinks physically, so this works whether the script is
# invoked via scripts/setup/.
REPO_ROOT="$(cd -P "$(dirname "$0")/../.." && pwd -P)"
cd "$REPO_ROOT"

if [ ! -d .git ]; then
  echo "no .git directory found at $REPO_ROOT — nothing to wipe" >&2
  exit 1
fi

rm -rf .git
git init -q
git add -A
git commit -q -m "Initial commit from books-assistant template"
echo "fresh git history initialized at $REPO_ROOT"
echo "note: 'origin' is gone — add your own remote when ready:"
echo "  gh repo create <you>/books-assistant --private --source . --push"
