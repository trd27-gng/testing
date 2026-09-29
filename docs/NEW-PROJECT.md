# Starting a new project

Two halves: the files, which Claude does, and the GitHub settings, which only
you can do. Your half is about five minutes of clicking, once per repo.

## Step 0 — Create the repo from this template

This repo is a GitHub template, so the whole baseline comes across in one
step: **Use this template → Create a new repository**.

That replaces the old "copy these files by hand" list entirely.

## Claude's half — the files

Say *"set up this repo for <the project>"* in a new Claude Code session and
Claude works this list. You don't do these by hand.

- [ ] Rewrite "What this project is" and "Commands" in `CLAUDE.md` — a
      `CLAUDE.md` with placeholder commands is worse than none
- [ ] Fill `run_project_checks()` in `scripts/check.sh` with the real lint,
      typecheck, and test commands
- [ ] Reset `CHANGELOG.md` to an empty `## [Unreleased]`
- [ ] Add language-specific entries to `.gitignore`
- [ ] Rewrite `README.md` for the actual project
- [ ] Add a `LICENSE` if the repo is public
- [ ] Commit the scaffolding before any application code

## Your half — GitHub settings

These can only be done in the web UI. They are what make the repo *safe*
rather than merely tidy.

### 1. Decide visibility first — it gates everything else

On **GitHub Free**, rulesets do not enforce on private repositories. GitHub
says so directly on the Rulesets page:

> *"Your rulesets won't be enforced on this private repository until you move
> to GitHub Team organization account."*

So on the free tier the choice is real:

| | Private | Public |
| --- | --- | --- |
| Ruleset enforcement | ❌ | ✅ |
| Secret scanning + push protection | ❌ | ✅ |
| Actions minutes | 2,000/mo | unlimited |

**Default to public** unless the code itself is commercially sensitive.
Public is *safer* for credentials, not riskier: push protection actively
blocks a push containing a key, and you only get it on public repos.

Visibility never protects secrets. `.gitignore` and environment variables do.
A private repo with a key committed is one leaked clone away from a breach; a
public repo with no key in it is fine.

If you keep it private, skip to step 4 — rulesets won't do anything, and
`CONTRIBUTING.md` becomes a convention you follow rather than a rule GitHub
enforces.

### 2. Branch ruleset

**Settings → Rules → Rulesets → New ruleset → New branch ruleset**

- [ ] Name it `main protection`
- [ ] **Enforcement status: Active** ← defaults to Disabled, easy to miss
- [ ] Target branches → Add target → **Include default branch**
- [ ] ☑ Restrict deletions
- [ ] ☑ Block force pushes
- [ ] ☑ Require a pull request before merging
      - **Required approvals: 0** while you are the only maintainer. GitHub
        will not let you approve your own PR, so 1 locks you out of merging
        your own work. Raise it the day someone else joins.
      - Allowed merge methods → **Squash** only
- [ ] ☑ Require status checks to pass → **Add checks** → type `check`
      - The picker is a search box and only populates from checks that have
        reported recently. If it is empty, open one PR first so CI reports
        once, then add it.

Verify afterwards: `main` should report `protected: true` at
`https://api.github.com/repos/<owner>/<repo>/branches/main`.

### 3. Pull request settings

**Settings → General → Pull Requests**

- [ ] ☑ Allow squash merging — untick merge commits and rebase
- [ ] ☑ Automatically delete head branches

One merge style means one commit per PR on `main`, and the squash commit
message becomes the changelog entry.

> On a squash merge the **PR title** becomes the commit message, discarding
> the commit you actually wrote. Check the title is a valid Conventional
> Commit before merging.

### 4. Security

- [ ] **Settings → Code security**: secret scanning, push protection,
      Dependabot alerts (all free on public repos)
- [ ] **Settings → Actions → General**: workflow permissions read-only
      by default

## One-time, account-wide

Do this once, not per repo: **https://github.com/settings/emails**

- [ ] ☑ Keep my email address private
- [ ] ☑ Block command line pushes that expose my email

Public repos make commit author emails harvestable. After enabling, point
local git at the alias or your pushes will be rejected:

```bash
git config --global user.email "<id>+<username>@users.noreply.github.com"
```

Note GitHub's caveat: commits **already** authored with a public email stay
public. This protects future commits only.

## First-session sanity check

Open Claude Code in the new repo and ask it to summarise `CLAUDE.md`. If the
summary matches what you intended, the instructions are landing. If it comes
back vague, the file is too vague — fix it before it misleads every future
session.
