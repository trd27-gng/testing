#!/usr/bin/env bash
# The single entry point for "is this change OK to push?"
#
# CI runs this exact script, so a green run here means a green run there.
# As the project gains a toolchain, add its real commands to run_project_checks.

set -euo pipefail

cd "$(dirname "$0")/.."

failed=0

step() { printf '\n\033[1m==> %s\033[0m\n' "$1"; }
ok()   { printf '    \033[32mok\033[0m  %s\n' "$1"; }
bad()  { printf '    \033[31mFAIL\033[0m %s\n' "$1"; failed=1; }
skip() { printf '    --  %s\n' "$1"; }

# --- Hygiene checks: these apply to every project, in every language --------

step "Repository hygiene"

if git ls-files --error-unmatch .env >/dev/null 2>&1; then
  bad ".env is tracked by git — remove it and rotate anything it contained"
else
  ok ".env is not tracked"
fi

if [ -f .env.example ]; then
  ok ".env.example present"
else
  bad ".env.example missing — document every env var the app reads"
fi

for f in README.md CLAUDE.md CONTRIBUTING.md CHANGELOG.md .gitignore; do
  if [ -f "$f" ]; then ok "$f present"; else bad "$f missing"; fi
done

if grep -rIn --exclude-dir=.git --exclude-dir=node_modules --exclude=check.sh \
     -E '(BEGIN (RSA|OPENSSH|EC|PGP) PRIVATE KEY)' . >/dev/null 2>&1; then
  bad "a private key appears to be committed"
else
  ok "no committed private keys"
fi

# --- Project checks: fill these in as the toolchain lands ------------------

step "Project checks"

run_project_checks() {
  local ran=0

  if [ -f package.json ]; then
    ran=1
    npm ci --no-audit --no-fund
    npm run lint --if-present
    npm test --if-present
  fi

  if [ -f pyproject.toml ] || [ -f requirements.txt ]; then
    ran=1
    python -m pip install --quiet --upgrade pip
    [ -f requirements.txt ] && python -m pip install --quiet -r requirements.txt
    command -v ruff >/dev/null 2>&1 && ruff check .
    command -v pytest >/dev/null 2>&1 && pytest -q
  fi

  if [ -f go.mod ]; then
    ran=1
    go vet ./...
    go test ./...
  fi

  if [ -f Cargo.toml ]; then
    ran=1
    cargo fmt --check
    cargo clippy -- -D warnings
    cargo test
  fi

  return $((1 - ran))
}

if run_project_checks; then
  ok "project checks passed"
else
  skip "no toolchain detected yet — add real lint/test commands here"
fi

# --- Result ----------------------------------------------------------------

printf '\n'
if [ "$failed" -eq 0 ]; then
  printf '\033[32mAll checks passed.\033[0m\n'
else
  printf '\033[31mChecks failed. Fix the items marked FAIL above.\033[0m\n'
  exit 1
fi
