#!/usr/bin/env python3
"""Builds dashboard/data.json (what the website reads) from board.json + cards/*.json.

Run from anywhere:  python3 dashboard/build.py
Fails loudly if a file is not valid JSON or a card is malformed, so a typo
never reaches the live site.
"""
import datetime, glob, json, os, sys

here = os.path.dirname(os.path.abspath(__file__))
board = json.load(open(os.path.join(here, "board.json"), encoding="utf-8"))
status_ids = {s["id"] for s in board["statuses"]}
cards, seen = [], set()
for path in sorted(glob.glob(os.path.join(here, "cards", "*.json"))):
    name = os.path.basename(path)
    try:
        c = json.load(open(path, encoding="utf-8"))
    except ValueError as e:
        sys.exit(f"{name}: not valid JSON ({e})")
    for key in ("id", "title", "status"):
        if not c.get(key):
            sys.exit(f"{name}: missing \"{key}\"")
    if c["id"] + ".json" != name:
        sys.exit(f"{name}: id must match the file name")
    if c["status"] not in status_ids:
        sys.exit(f"{name}: unknown status \"{c['status']}\" (columns: {', '.join(sorted(status_ids))})")
    if c["id"] in seen:
        sys.exit(f"{name}: duplicate id")
    seen.add(c["id"])
    cards.append(c)
cards.sort(key=lambda c: (c.get("order", 1000), c["id"]))
board["items"] = cards
board["updated"] = datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%d")
with open(os.path.join(here, "data.json"), "w", encoding="utf-8") as f:
    json.dump(board, f, indent=1, ensure_ascii=False)
print(f"data.json: {len(cards)} cards")
