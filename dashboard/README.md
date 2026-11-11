# Project board

A small website that shows where Quando? / Matai? stands: deadlines, work by status, open pull requests and issues, and plan links. It needs no server and no Claude.

Live at `https://dendrito.github.io/quando/` once Pages is on (see "One-time setup").

## Click a card, edit from the page

- Click any card to read its details, documentation links, pull requests and links to the Claude threads about it (thread links need your Claude login).
- **Turn on editing** (top right) once per browser: create a fine-grained GitHub token for only this repo with **Contents: Read and write**, and paste it. It is stored only in that browser. Then click a card → **Edit**, or **+ Add task** (or the **+** on a column). **Edit columns** renames, reorders, adds and removes columns; **+ Add date** and **+ Add plan** add dates and plans, and clicking a date or a plan's Edit button changes it. Saving commits to `main`, and the public page refreshes about a minute later.
- Never share the token. To remove it, press **Editing: on** → turn off.

## How the board is stored

- **One file per card:** `dashboard/cards/<id>.json`. Two people (or Claude threads) editing different cards never conflict.
- **Everything else** (dates, plans, columns, thread list, headline): `dashboard/board.json`.
- The site builds `data.json` from those files (`python3 dashboard/build.py`, run automatically on publish). A typo in any file fails the build with the file name, and the old site stays up.

Card fields: `id` (optional; it is the file name), `title`, `status` (`decide`, `doing`, `review`, `next`, `hold`, `done`, or any column id in `board.json`), optional `tag`, `note`, `details`, `plan`, `prs` (pull request numbers), `threads` (ids from `board.json`), `docs` (`[{"title","url"}]`), `order` (sort number).

To add a card by hand on GitHub: Add file → Create new file → `dashboard/cards/my-card.json` with `{"id": "my-card", "title": "…", "status": "next"}`.

## Updates that happen by themselves

- **Pull requests:** the "Board sync" workflow gives every new pull request a card and moves it as the PR moves: draft = In progress, ready = Needs your review, merged = Done, closed = On hold. Cards written by hand are never touched, and editing an automatic card on the site makes it yours.
- **Thread links:** every card shows a 💬 link to its Claude thread. Automatic PR cards take it from the "project thread" link in the PR description; other cards list thread keys in `threads` (see `board.json`) or raw ids in `threadIds`.
- **Merges:** when a pull request is merged, automatic PR cards go to Done, and so does any hand-made card in In progress or Needs your review that lists that PR (once every PR it lists is merged or closed). Decisions, plans and parked cards stay put. To catch up after a gap, run the "Board sync" workflow by hand from the Actions tab.
- **Business tab:** plans with `"group": "business"` in `board.json` show on the Business tab (titles and links only, no notes). Add one with "+ Add document" on that tab when editing is on.
- **Mark a card done without a PR:** run the "Board set card" workflow (Actions tab, or `actions_run_trigger` from a Claude thread) with `card` = the card id (file name in `dashboard/cards`), `status` = `done`, and an optional `note`. Threads finishing a task with no PR should do this, or ask the coordinator to.
- **Claude threads:** each thread keeps its own card in `dashboard/cards/` current (status, note, links). Because it is one file per card, threads don't collide.

## Plans and tasks

Each plan in `"plans"` has an `id`, a `status` (`proposed` until you agree, then `agreed`) and a link. A card with `"plan": "business"` is a task that comes from that plan, and the plan tile counts its open tasks. When a plan changes, change its cards here.

**Business, pricing, tax and legal plans stay out of this public repo.** They live as private Claude pages; this site only links to them. Do not paste their content into the board files.

## One source of truth for Claude too

`dashboard/cards/` and `dashboard/board.json` on `main` are the project's task list. Your edits there are the latest word. Every Claude thread should read it before starting work and treat it as overriding older chat. When a thread finishes something it should update the card, not just say so in chat.
