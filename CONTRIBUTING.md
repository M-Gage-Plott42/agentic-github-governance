# Contributing

Thanks for contributing. This repository is a template, so changes should stay
small, portable, and easy to apply in downstream repos.

## Before Opening a PR

1. Read `README.md`, `AGENTS.md`, and `docs/standards.md`.
2. Keep workflow, script, and docs changes synchronized.
3. Update `CHANGELOG.md` under `[Unreleased]` for user-visible changes.
4. Prefer SSH git remotes for push operations in non-interactive agent sessions.

## Execution Plan Requirement

Use `docs/execution-plan-template.md` when the change is non-trivial (multi-file
edits, policy changes, CI/security changes, or uncertain scope). Include the plan
in the PR description.

## Local Checks

Run the same checks expected by CI:

```bash
bash scripts/run_repo_quick_gate.sh
ruff check .
yamllint -c .yamllint.yml .
markdownlint-cli2 "**/*.md"
bash scripts/run_actionlint.sh
shellcheck scripts/*.sh
bash -n scripts/bootstrap_repo.sh
bash scripts/smoke_bootstrap_ruleset_payload.sh
```

Optional (when boundary policy is configured):

```bash
bash scripts/run_repo_quick_gate.sh --with-boundaries --strict-boundaries
```

## Pull Request Guidance

1. Keep PRs focused on one logical improvement.
2. Explain intent, risk, and rollback strategy in the PR description.
3. Include links to relevant workflow runs for CI/security changes.
4. Do not merge while required checks are red.

## Documentation Entropy Controls

When changes affect governance or automation behavior, update docs in the same PR:

1. Workflow changes: update `README.md` and `docs/standards.md`.
2. Bootstrap/script behavior changes: update `README.md`, `docs/standards.md`, and usage examples.
3. Policy or process changes: update `AGENTS.md` and/or `CONTRIBUTING.md`.
4. User-visible behavior changes: update `CHANGELOG.md`.

## CodeQL Check Rollout Policy

This template intentionally separates CodeQL rollout into two phases:

1. Keep CodeQL running but not required until the repository has at least one
   confirmed green CodeQL run after configuration changes.
2. Enable required CodeQL checks by rerunning bootstrap with:

```bash
REQUIRE_CODEQL_CHECKS=1 bash scripts/bootstrap_repo.sh <owner/repo>
```

This avoids locking PRs on unstable check contexts while preserving a clear
path to stricter enforcement.
