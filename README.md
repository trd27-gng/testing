# testing

A sandbox repo for establishing how we work with Claude Code, before applying
it to real projects. It doubles as the template every future project starts
from.

## What's here

| Path | Purpose |
| --- | --- |
| `CLAUDE.md` | Standing instructions Claude reads at the start of every session |
| `CONTRIBUTING.md` | Branching, commits, versioning, releases, definition of done |
| `CHANGELOG.md` | What changed, in human terms |
| `.claude/settings.json` | Shared Claude Code permissions — what's auto-allowed, what asks, what's blocked |
| `scripts/check.sh` | One command that runs every check; CI runs this exact script |
| `.github/workflows/ci.yml` | The gate that protects `main` |
| `.github/pull_request_template.md` | Keeps PR descriptions consistent |
| `.env.example` | Every env var the app needs, with placeholder values |
| `docs/NEW-PROJECT.md` | Checklist for spinning up the next repo |

## Verify the setup

```bash
./scripts/check.sh
```

That's the same command CI runs. If it passes locally, it passes in CI.

## Day-to-day flow

```bash
git checkout main && git pull
git checkout -b feat/short-slug
# … work …
./scripts/check.sh
git commit -m "feat(scope): imperative summary"
git push -u origin feat/short-slug
# open a PR, get CI green, get a review, squash merge
```

Details and the reasoning behind each rule: [CONTRIBUTING.md](CONTRIBUTING.md).
