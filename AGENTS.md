# AGENTS.md

## Purpose

This repository is a reusable template for agentic GitHub governance defaults.
Prefer changes that improve downstream reliability, security, and clarity.

## Repository Priorities

1. Keep CI workflows stable and easy to copy into new repositories.
2. Keep security defaults explicit (Dependabot, CodeQL, vulnerability reporting).
3. Keep bootstrap automation idempotent and aligned with documented behavior.
4. Keep docs concise and synchronized with automation.

## Operating Rules For Agent Edits

- Read `README.md`, `docs/standards.md`, and `.github/workflows/*` before editing.
- When workflow behavior changes, update `README.md` and `CHANGELOG.md` in the same patch.
- Prefer minimal, auditable diffs over broad refactors.
- Use pinned GitHub Actions versions in workflows.
- Prefer SSH Git remotes for push operations in non-interactive agent sessions.

## Setup Trigger Matrix

- Do not run full bootstrap on every thread.
- Run bootstrap/setup only when:
  - new machine or fresh clone,
  - `.venv` is missing/recreated, or
  - dependency/hook files changed.
- Run the quick local gate at least once per active session and before major push:

  ```bash
  bash scripts/run_repo_quick_gate.sh
  ```

- If storage boundaries are configured in downstream repos, run:

  ```bash
  bash scripts/run_repo_quick_gate.sh --with-boundaries --strict-boundaries
  ```

## Context Map

- CI/workflow changes:
  Start with `.github/workflows/*`, then `README.md`, then `docs/standards.md`.
- Governance and automation changes:
  Start with `scripts/bootstrap_repo.sh`, then `CONTRIBUTING.md`, then `docs/standards.md`.
- Agent policy changes:
  Start with `AGENTS.md`, then `docs/AGENTS.example.md`, then `README.md`.

## Planning And Steering

- For non-trivial tasks, create an execution plan before edits.
- Use `docs/execution-plan-template.md` for plan structure.
- Surface assumptions and unknowns early; do not hide them in final summaries.
- If scope changes mid-task, update the plan and call out the decision explicitly.

## Unknowns And Escalation

- If behavior is ambiguous or blocked by external settings, report exact blocker and
  provide both CLI and manual UI fallback paths.
- If docs conflict with code, treat code as current truth and include doc-sync updates
  in the same change set.
- Do not proceed with destructive operations without explicit user direction.

## CodeQL Policy

- This template uses **advanced** CodeQL setup via `.github/workflows/codeql.yml`.
- Do not configure GitHub CodeQL default setup in bootstrap for this template.
- For interpreted languages in template repos, default to `build-mode: none` unless a
  concrete build step is required.

## Validation Expectations

- Run file-relevant checks locally before finishing:
  - `bash scripts/run_repo_quick_gate.sh`
  - `ruff check .`
  - `yamllint -c .yamllint.yml .`
  - `markdownlint-cli2 "**/*.md"`
  - `bash scripts/run_actionlint.sh`
  - `shellcheck scripts/*.sh`
- If a check is unavailable locally, state that explicitly in the handoff.

## Optional Scalability Patterns

- Host profiles: `docs/policies/host_profiles.example.json`
- Run provenance example: `docs/policies/run_manifest.example.json`
- Storage boundaries: `docs/policies/storage_boundaries.example.json`
- Active focus + ADR memory: `docs/active/current_focus.example.md`,
  `docs/adr/README.md`
