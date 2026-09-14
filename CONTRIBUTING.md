# Contributing

The standards for this repo and every repo we start from it. The goal is that
anyone — human or Claude — can look at the repo and know exactly what state
it's in and what happens next.

## 1. Repository baseline

Every project repo has these, from the first commit:

| File | Why |
| --- | --- |
| `README.md` | What it is, how to run it, how to test it |
| `CLAUDE.md` | Standing instructions for Claude Code |
| `CONTRIBUTING.md` | This file — workflow and standards |
| `CHANGELOG.md` | Human-readable history of what changed |
| `LICENSE` | Required for anything public |
| `.gitignore` | Language-appropriate, plus `.env` |
| `.env.example` | Every env var the app needs, with dummy values |
| `.github/workflows/ci.yml` | The gate that protects `main` |
| `.github/pull_request_template.md` | Forces a consistent PR description |
| `scripts/check.sh` | One command that runs everything CI runs |
| `.claude/settings.json` | Shared permission rules for Claude Code |

`scripts/check.sh` is the important one: **CI must run exactly what you can
run locally.** If those ever diverge, CI becomes a slot machine.

## 2. Branching

`main` is always releasable and always protected. Nothing is committed to it
directly.

```
feat/short-slug       new capability
fix/short-slug        bug fix
chore/short-slug      deps, tooling, config
docs/short-slug       docs only
refactor/short-slug   no behaviour change
test/short-slug       tests only
claude/short-slug     branches Claude Code creates on its own
```

One branch, one logical change. If a branch needs a paragraph to describe it,
it should have been two branches.

## 3. Commits

[Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<optional scope>): <imperative summary, lowercase, no trailing period>

<optional body: why, not what>

<optional footer: BREAKING CHANGE: …  /  Closes #12>
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`,
`ci`, `chore`, `revert`.

This isn't bureaucracy — the commit type is what determines the next version
number (§5), so getting it right is load-bearing.

Examples:

```
feat(api): add pagination to /users
fix(auth): stop refreshing an already-expired token
chore(deps): bump requests to 2.32.3
```

## 4. Pull requests

1. Open the PR as a **draft** while work is in progress.
2. Mark it ready when CI is green and the description is filled in.
3. At least one approving review before merge.
4. **Squash merge** into `main`. The squash commit message follows the
   Conventional Commit format — it becomes the changelog entry.
5. Delete the branch after merge.

A PR that has been open for more than a week is a signal it was scoped too
large. Split it.

## 5. Versioning and releases

[Semantic Versioning](https://semver.org/): `MAJOR.MINOR.PATCH`, tagged
`v1.2.3`.

| Change | Bump | Driven by |
| --- | --- | --- |
| Breaking change | MAJOR | `BREAKING CHANGE:` footer or `feat!:` |
| New backwards-compatible feature | MINOR | `feat:` |
| Backwards-compatible bug fix | PATCH | `fix:` |

While the project is pre-1.0 (`0.x.y`), breaking changes bump the **minor**
version instead. Reaching `1.0.0` is a deliberate decision meaning "the public
interface is now stable and we will not break it casually."

### Changelog

[Keep a Changelog](https://keepachangelog.com/) format. Every user-facing
change adds its line under `## [Unreleased]` **in the same commit as the
change** — not batched up at release time, which is how changelogs end up
being lies.

### Cutting a release

```bash
git checkout main && git pull
# 1. Move [Unreleased] entries under a new "## [1.2.0] - YYYY-MM-DD" heading
# 2. Commit:
git commit -am "chore(release): v1.2.0"
# 3. Tag and push:
git tag -a v1.2.0 -m "v1.2.0"
git push origin main --follow-tags
# 4. Publish a GitHub Release from the tag, body = that changelog section
```

Never move or delete a published tag. If a release is wrong, cut a new one.

## 6. Secrets and configuration

- Config comes from environment variables. Nothing secret is ever hardcoded.
- `.env` is gitignored. `.env.example` is committed and lists every variable
  the app reads, with placeholder values.
- CI secrets live in GitHub Actions secrets.
- Enable **secret scanning** and **push protection** in repo settings.
- If a secret is ever committed: rotate it first, scrub the history second.
  Rotation is the part that actually matters.

## 7. Definition of done

A change is done when all of these are true:

- [ ] It does what was asked, and nothing extra
- [ ] Tests cover the new behaviour and the whole suite passes
- [ ] `./scripts/check.sh` passes locally
- [ ] CI is green
- [ ] `CHANGELOG.md` updated if the change is user-facing
- [ ] Docs/README updated if behaviour or setup changed
- [ ] No secrets, no debug output, no commented-out code
- [ ] Reviewed and approved
