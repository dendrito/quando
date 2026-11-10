#!/usr/bin/env python3
"""Keeps board cards in step with pull requests. Run by .github/workflows/board-sync.yml.

- A pull request that no card mentions gets a new card (dashboard/cards/pr-<n>.json, "auto": true).
- An auto card follows its PR: draft -> In progress, ready -> Needs your review, merged -> Done, closed -> On hold.
- A card you or a Claude thread wrote by hand is never changed. Editing an auto card on the site makes it yours.
Only reads the event file; never runs pull request code.
"""
import glob, json, os, sys

here = os.path.dirname(os.path.abspath(__file__))
pr = json.load(open(os.environ["GITHUB_EVENT_PATH"], encoding="utf-8"))["pull_request"]
n = pr["number"]
if pr.get("merged"):
    status = "done"
elif pr["state"] == "closed":
    status = "hold"
elif pr.get("draft"):
    status = "doing"
else:
    status = "review"

cards = {}
for path in glob.glob(os.path.join(here, "cards", "*.json")):
    c = json.load(open(path, encoding="utf-8"))
    cards[path] = c
mine = [(p, c) for p, c in cards.items() if n in c.get("prs", [])]
if not mine:
    order = max([c.get("order", 0) for c in cards.values()] + [0]) + 1
    c = {"id": f"pr-{n}", "title": pr["title"][:120], "status": status, "tag": "pr", "prs": [n],
         "note": "Added automatically from the pull request.", "auto": True, "order": order}
    path = os.path.join(here, "cards", f"pr-{n}.json")
    mine = [(path, c)]
    changed = True
else:
    changed = False
for path, c in mine:
    if c.get("auto") and c["status"] != status:
        c["status"] = status
        changed = True
    if changed:
        with open(path, "w", encoding="utf-8") as f:
            json.dump(c, f, indent=2, ensure_ascii=False)
            f.write("\n")
print("changed" if changed else "unchanged", n, status)
