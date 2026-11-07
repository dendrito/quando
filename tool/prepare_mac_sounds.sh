#!/usr/bin/env bash
# Developer-only asset preparation. The resulting files are committed, so app
# users and ordinary builds do not need FFmpeg.
set -euo pipefail
cd "$(dirname "$0")/.."
for original in assets/sounds/gentle_*.ogg; do
  ffmpeg -v error -nostdin -i "$original" -c:a aac -b:a 128k \
    -movflags +faststart -y "${original%.ogg}.m4a"
  afinfo "${original%.ogg}.m4a" > /dev/null
done
