# Changelog

All notable changes to this project are documented here.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
Versioning follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Categories: `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, `Security`.

## [Unreleased]

### Added

- Repository baseline: `CLAUDE.md`, `CONTRIBUTING.md`, `CHANGELOG.md`,
  `.gitignore`, `.env.example`
- Shared Claude Code permission settings in `.claude/settings.json`
- CI workflow and a `scripts/check.sh` entry point that CI and local runs
  share
- Pull request template and a `docs/NEW-PROJECT.md` setup checklist

### Changed

- `docs/NEW-PROJECT.md` rewritten against what the free tier actually allows:
  splits the checklist into Claude's half (the files) and the maintainer's
  half (GitHub settings), documents that rulesets do not enforce on private
  repos on GitHub Free, adds the visibility decision table, corrects the
  ruleset steps (Active enforcement, 0 required approvals while solo,
  squash-only merges), and adds the account-wide commit-email privacy step
