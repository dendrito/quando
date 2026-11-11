#!/usr/bin/env python3
"""Set a card's status (and optionally add a note line). Used by .github/workflows/board-set.yml.

Usage: set_card.py <card-id> <status> [note]
Card id = the file name in dashboard/cards without .json. Status = a column id from board.json
(decide, doing, review, next, hold, done).
"""
import json, os, sys

here = os.path.dirname(os.path.abspath(__file__))
if len(sys.argv) < 3:
    sys.exit(__doc__)
cid, status = sys.argv[1], sys.argv[2]
note = sys.argv[3].strip() if len(sys.argv) > 3 else ""
statuses = [s["id"] for s in json.load(open(os.path.join(here, "board.json"), encoding="utf-8"))["statuses"]]
if status not in statuses:
    sys.exit(f"unknown status {status!r}; use one of {statuses}")
path = os.path.join(here, "cards", cid + ".json")
if not os.path.isfile(path):
    sys.exit(f"no card {cid!r}; ids are the file names in dashboard/cards")
c = json.load(open(path, encoding="utf-8"))
c["status"] = status
if note:
    c["note"] = note[:300]
c.pop("auto", None)  # a person or thread has spoken for this card; sync no longer moves it
with open(path, "w", encoding="utf-8") as f:
    json.dump(c, f, indent=2, ensure_ascii=False)
    f.write("\n")
print("set", cid, status)
