# Changelog

All notable changes to this repository are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Added shared `scripts/install_actionlint.sh` and `scripts/run_actionlint.sh`
  helpers so CI and local pre-commit use the same verified `actionlint`
  release binary.
- Added `CLAUDE.md` as a thin shim that imports `AGENTS.md` for Claude Code.
- Added repository-level `AGENTS.md` for live Codex collaboration rules.
- Added `docs/AGENTS.example.md` as a downstream template.
- Added `docs/execution-plan-template.md` for structured non-trivial task planning.
- Added Actions lint workflow (`actionlint`).
- Added shell lint workflow (`shellcheck`).
- Added `CONTRIBUTING.md` and `.github/CODEOWNERS`.
- Added `scripts/generate_ruleset_payload.sh` for reusable ruleset JSON generation.
- Added `scripts/smoke_bootstrap_ruleset_payload.sh` for payload smoke testing.
- Added `scripts/run_repo_quick_gate.sh` as a one-command local guardrail.
- Added `scripts/check_storage_boundaries.py` for optional storage boundary audits.
- Added optional operations pattern guidance (`docs/operations-patterns.md`).
- Added optional host profile, storage boundary, and run manifest example policies.
- Added active-focus and ADR example scaffolding (`docs/active/*`, `docs/adr/*`).
- Added dependency review workflow (`.github/workflows/dependency-review.yml`)
  and config file (`.github/dependency-review-config.yml`).

### Changed

- Renamed the template identity toward agentic GitHub governance while keeping
  tool-specific guidance explicit.
- Updated the Actions lint workflow and pre-commit hook to use `actionlint`
  `v1.7.12` from the verified upstream release binary instead of divergent
  local and CI install paths.
- Updated CodeQL workflow to use explicit `build-mode: none` for Python and
  GitHub Actions in advanced setup.
- Pinned `github/codeql-action` workflow references to full commit SHAs.
- Added workflow-level concurrency to required-check workflows so superseded
  runs are canceled on active refs.
- Added `merge_group` triggers to required-check workflows for merge-queue
  compatibility.
- Updated bootstrap automation to disable CodeQL default setup when applying
  this template, preventing advanced/default setup conflicts.
- Updated bootstrap ruleset payload to require `actionlint` and `shellcheck`.
- Updated bootstrap/ruleset generation to support opt-in required dependency
  review via `REQUIRE_DEPENDENCY_REVIEW=1`.
- Added optional CodeQL-required-check rollout via
  `REQUIRE_CODEQL_CHECKS=1` after first green CodeQL run.
- Updated bootstrap to support `RULESET_PAYLOAD_ONLY=1` for payload-only runs.
- Updated bootstrap to attempt cleanup of legacy dynamic CodeQL workflow entries
  with manual UI fallback messaging if API disable is rejected.
- Updated pre-commit hooks to include `actionlint` and `shellcheck` parity checks.
- Added a "Use This Template In 60 Seconds" section to README with a first-action
  setup path and topic guidance.
- Added harness-engineering guidance across README, AGENTS, standards, and
  contributing docs.
- Updated README and standards docs to document AGENTS pattern and CodeQL mode.
- Updated README and standards docs with current Actions SHA-pinning guidance
  and dependency review support matrix.
- Enabled repository-level Actions SHA pinning for the live template repo while
  keeping bootstrap automation docs-only for that setting.
- Updated AGENTS/CONTRIBUTING guidance with setup-trigger and quick-gate usage.
- Added SSH-first git transport guidance for Codex/headless push workflows.
- Expanded optional operations guidance with reusable workflow recommendations
  for multi-repo estates.

## [0.1.0] - 2026-02-16

### Added

- Initial template baseline for Codex + GitHub best practices.
- CI workflows for Python, Markdown, YAML, and CodeQL scanning.
- Dependabot updates and Actions-only Dependabot auto-merge workflow.
- Pre-commit configuration for local lint parity.
- Security policy, standards guide, and bootstrap automation script.
