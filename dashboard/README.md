# Project board

A small website that shows where Quando? / Matai? stands: deadlines, work by status, open pull requests and issues, and plan links. It needs no server and no Claude.

Live at `https://dendrito.github.io/quando/` once Pages is on (see "One-time setup").

## Change what the board shows

Everything you see in the columns, dates and links comes from **`dashboard/data.json`**.

1. Open the file on GitHub and press the pencil (or use the **Edit this board** button on the site).
2. Change the text between quotes. To move a card to another column, change its `"status"` to one of: `doing`, `review`, `next`, `hold`, `done`.
3. Press **Commit changes**. The site updates in about a minute.

To add a card, copy a block from `{` to `},`, paste it below another one, and change the words. Keep the commas between blocks, and no comma after the last one. If the site shows "Could not read data.json", a comma or quote is wrong. GitHub's editor underlines the problem.

Card fields: `title`, `status`, `tag` (any short word), `note` (optional), `prs` (optional list of pull request numbers, which show live as draft / ready / merged).

Dates are written like `2026-11-12T23:59:00-03:00` (the `-03:00` is Brasília time).

## Things that update by themselves

- **Open pull requests** and **open issues** come straight from GitHub.
- The little pill on a card (`#25 · draft`) follows that pull request.
- To add a task without touching the file, press **New task** to open a GitHub issue. It appears under Open issues.

## One-time setup

1. On GitHub: **Settings → Pages → Build and deployment → Source: GitHub Actions.**
2. After the pull request that added this folder is merged, the **Project board** workflow publishes the site. Later edits to `dashboard/` publish automatically.

Don't put private information here. This repository is public.
