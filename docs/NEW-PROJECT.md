# Starting a new project

Copy this repo's baseline, then work the list. Should take about fifteen
minutes and it prevents most of the problems that show up later.

## In the repo

- [ ] Copy `CLAUDE.md`, `CONTRIBUTING.md`, `CHANGELOG.md`, `.gitignore`,
      `.env.example`, `.claude/settings.json`, `scripts/check.sh`,
      `.github/` from this repo
- [ ] Rewrite the "What this project is" and "Commands" sections of
      `CLAUDE.md` — a `CLAUDE.md` with placeholder commands is worse than none
- [ ] Add a `LICENSE` if the repo is public
- [ ] Fill `run_project_checks()` in `scripts/check.sh` with the real lint,
      typecheck, and test commands
- [ ] Reset `CHANGELOG.md` to an empty `## [Unreleased]`
- [ ] Add the language-specific entries to `.gitignore`
- [ ] Commit the scaffolding before writing any application code

## In GitHub settings

These can only be done in the web UI, and they are what make the repo *safe*
rather than just tidy.

- [ ] **Settings → Rules → Rulesets**, target `main`:
      - [ ] Require a pull request before merging
      - [ ] Require 1 approval
      - [ ] Dismiss stale approvals when new commits are pushed
      - [ ] Require status checks to pass → select `check`
      - [ ] Require branches to be up to date before merging
      - [ ] Block force pushes
      - [ ] Restrict deletions
- [ ] **Settings → General → Pull Requests**: allow squash merging only;
      enable "automatically delete head branches"
- [ ] **Settings → Code security**: enable secret scanning, push protection,
      and Dependabot alerts
- [ ] **Settings → Actions → General**: set workflow permissions to
      read-only by default

## First-session sanity check

Open Claude Code in the repo and ask it to summarise `CLAUDE.md`. If the
summary matches what you intended, the instructions are landing. If it's
vague, the file is too vague.
