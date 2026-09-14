# CLAUDE.md

Project instructions for Claude Code. Read automatically at the start of every
session in this repository. Keep it short and current — stale rules are worse
than no rules.

## What this project is

`testing` — a sandbox repo used to establish and validate our working
standards before applying them to real projects.

> **When you fork this for a real project:** replace this section with two or
> three sentences on what the project actually does, who uses it, and what the
> deployment target is.

## Commands

<!-- Fill these in as soon as the project has a toolchain. Claude runs these
     instead of guessing. -->

| Purpose | Command |
| --- | --- |
| Install deps | _not yet defined_ |
| Run tests | _not yet defined_ |
| Lint / format | _not yet defined_ |
| Full pre-push check | `./scripts/check.sh` |
| Run the app | _not yet defined_ |

## Working agreement

These rules apply to every session. They exist so the human never has to
wonder what just happened.

1. **State the plan before non-trivial work.** Anything beyond a single-file
   edit gets a short plan first — what will change, which files, how it will
   be verified. Wait for a go-ahead on anything architectural.
2. **One logical change per branch.** No drive-by refactors bundled into a
   fix. If something unrelated is broken, say so and leave it alone.
3. **Never push to `main`.** Work happens on a branch, lands through a PR.
4. **Report honestly.** If tests fail, show the output. If a step was
   skipped, say which and why. Never describe unverified work as done.
5. **Say what was verified and how.** "Tests pass" means the command was run
   and its output was read. Otherwise say "not verified".
6. **Flag assumptions out loud.** If the request is ambiguous, make the
   reasonable call, do the work, and name the assumption in the summary — do
   not silently pick an interpretation.
7. **Stop and ask** before: deleting data, rewriting git history, changing
   CI or release config, adding a new runtime dependency, or anything that
   touches production.

## Safety rules

- **Never commit secrets.** No API keys, tokens, passwords, or connection
  strings in tracked files — not even in tests or examples. Use `.env`
  (gitignored) locally and GitHub Actions secrets in CI. If a secret is
  found in the history, say so immediately and treat it as compromised.
- **Never `git push --force` to a shared branch.** On your own branch use
  `--force-with-lease` only, and only when you created the branch.
- **Never disable or delete a failing test** to get a green build. Fix the
  code or explain why the test is wrong.
- **Destructive shell commands** (`rm -rf`, `DROP`, `truncate`, migrations)
  get confirmed first, every time, regardless of earlier approvals.
- **No new dependencies without asking.** Prefer the standard library.

## Code conventions

- Match the style of the surrounding file. Consistency beats personal taste.
- Comment *why*, not *what*. If the code needs a comment to explain what it
  does, rewrite the code.
- No dead code, no commented-out blocks, no placeholder stubs left behind.
- Errors are handled or propagated — never swallowed silently.

## Git conventions

Full detail in [CONTRIBUTING.md](CONTRIBUTING.md). The short version:

- Branches: `feat/…`, `fix/…`, `chore/…`, `docs/…`, `refactor/…`, `test/…`
- Commits: [Conventional Commits](https://www.conventionalcommits.org/) —
  `feat(auth): add token refresh`
- Versions: [SemVer](https://semver.org/) tags, `v1.2.3`
- Every user-facing change adds a line under `## [Unreleased]` in
  [CHANGELOG.md](CHANGELOG.md), in the same commit as the change.
