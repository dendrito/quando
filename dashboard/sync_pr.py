#!/usr/bin/env python3
"""Keeps board cards in step with pull requests. Run by .github/workflows/board-sync.yml.

Modes:
  (no argument)  one pull request, read from the GitHub event file.
  --all          every pull request, read from the GitHub API (needs GH_TOKEN + GITHUB_REPOSITORY);
                catches up existing cards only, never adds cards for old PRs.

- A pull request that no card mentions gets a new card (dashboard/cards/pr-<n>.json, "auto": true).
- An auto card follows its PR: draft -> In progress, ready -> Needs your review, merged -> Done, closed -> On hold.
- A card written by hand (or by a Claude thread) that lists the PR in "prs" moves to Done once the PR is merged
  and every other PR it lists is merged or closed. Only cards that are In progress or Needs your review move; decisions, plans,
  parked and finished cards are left alone, and nothing is ever moved backwards.
- The card links to the Claude thread named in the PR description ("project thread" link), when there is one.
Only reads PR data; never runs pull request code.
"""
import glob, json, os, re, subprocess, sys

here = os.path.dirname(os.path.abspath(__file__))


def load_cards():
    cards = {}
    for path in glob.glob(os.path.join(here, "cards", "*.json")):
        try:
            cards[path] = json.load(open(path, encoding="utf-8"))
        except ValueError:
            print("skipping unreadable card", path)
    return cards


def write(path, c):
    with open(path, "w", encoding="utf-8") as f:
        json.dump(c, f, indent=2, ensure_ascii=False)
        f.write("\n")


def pr_status(pr):
    if pr.get("merged") or pr.get("merged_at"):
        return "done"
    if pr["state"] == "closed":
        return "hold"
    return "doing" if pr.get("draft") else "review"


def sync(pr, states, cards, create=True):
    """Apply one PR to the cards. states maps PR number -> 'done' | 'hold' | 'doing' | 'review'."""
    n = pr["number"]
    status = pr_status(pr)
    states[n] = status
    m = re.search(r"thread=(cmsg_[A-Za-z0-9]+)", pr.get("body") or "")
    thread_id = m.group(1) if m else None
    changed = False
    mine = [(p, c) for p, c in cards.items() if n in c.get("prs", [])]
    if not mine:
        if not create:
            return False
        order = max([c.get("order", 0) for c in cards.values()] + [0]) + 1
        c = {"id": f"pr-{n}", "title": pr["title"][:120], "status": status, "tag": "pr", "prs": [n],
             "note": "Added automatically from the pull request.", "auto": True, "order": order}
        if thread_id:
            c["threadIds"] = [thread_id]
        path = os.path.join(here, "cards", f"pr-{n}.json")
        cards[path] = c
        write(path, c)
        return True
    for path, c in mine:
        edited = False
        if c.get("auto"):
            if c["status"] != status:
                c["status"] = status
                edited = True
            if thread_id and thread_id not in c.get("threadIds", []):
                c["threadIds"] = c.get("threadIds", []) + [thread_id]
                edited = True
        elif status == "done" and c["status"] in ("doing", "review"):
            others = [states.get(k) for k in c["prs"] if k != n]
            if all(s in ("done", "hold") for s in others):
                c["status"] = "done"
                edited = True
        if edited:
            write(path, c)
            changed = True
    return changed


def main():
    cards = load_cards()
    if "--all" in sys.argv:
        repo = os.environ["GITHUB_REPOSITORY"]
        out = subprocess.run(["gh", "api", "--paginate", "--slurp", f"repos/{repo}/pulls?state=all&per_page=100"],
                             check=True, capture_output=True, text=True).stdout
        prs = [p for page in json.loads(out) for p in page]
        states = {p["number"]: pr_status(p) for p in prs}
        changed = False
        for p in sorted(prs, key=lambda p: p["number"]):
            if p["head"]["repo"] and p["head"]["repo"]["full_name"] != repo:
                continue
            changed = sync(p, states, cards, create=False) or changed
        print("changed" if changed else "unchanged", "all", len(prs))
        return
    pr = json.load(open(os.environ["GITHUB_EVENT_PATH"], encoding="utf-8"))["pull_request"]
    repo = os.environ.get("GITHUB_REPOSITORY")
    states = {}
    # Other PRs a card lists: look them up so a card finishes only when all of them are.
    wanted = {k for c in cards.values() if pr["number"] in c.get("prs", []) for k in c["prs"]} - {pr["number"]}
    for k in wanted:
        try:
            o = subprocess.run(["gh", "api", f"repos/{repo}/pulls/{k}"], check=True, capture_output=True, text=True).stdout
            states[k] = pr_status(json.loads(o))
        except Exception as e:  # unknown state: treat as still open
            print("could not read PR", k, e)
    changed = sync(pr, states, cards)
    print("changed" if changed else "unchanged", pr["number"], pr_status(pr))


main()
