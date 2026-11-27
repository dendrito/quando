#!/usr/bin/env bash
# One short line that says which code a build came from: commit and day,
# for example "a1b2c3d 27 Nov" ("+" after the commit = uncommitted changes).
# Settings shows it; compare it with `git log -1 --format=%h origin/main`.
cd "$(dirname "$0")/.."
dirty=; [[ -n $(git status --porcelain 2>/dev/null) ]] && dirty=+
echo "$(git rev-parse --short HEAD 2>/dev/null || echo dev)$dirty $(date -u '+%-d %b')"
