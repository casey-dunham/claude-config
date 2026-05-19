#!/bin/bash
# Pull latest from this repo and sync to ~/.claude/
# Run after merging a PR: cd ~/claude-config && git pull && ./sync.sh

REPO="$(cd "$(dirname "$0")" && pwd)"
DEST="$HOME/.claude"

cp "$REPO/CLAUDE.md" "$DEST/CLAUDE.md"
cp -r "$REPO/agents/." "$DEST/agents/"

COMMIT=$(git -C "$REPO" log -1 --pretty="%s (%cr)")
echo "✓ ~/.claude synced — $COMMIT"
