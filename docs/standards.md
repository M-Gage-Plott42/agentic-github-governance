# Standards Baseline

This template consolidates maintainership patterns proven in the following repositories:

- `M-Gage-Plott42/qiskit-v2-guide`
- `M-Gage-Plott42/QUBO_QA`
- `M-Gage-Plott42/utc-hpc-guide`
- `M-Gage-Plott42/Dissertation_Template`

## Governance Defaults

- Required CI checks with branch rulesets.
- Admin bypass enabled in rulesets so required checks protect contributors without blocking owner/admin emergency pushes.
- Wiki and Projects disabled unless intentionally used.
- Auto-merge enabled for approved update classes.
- Automatic branch deletion on merge enabled.
- `CODEOWNERS` for ownership enforcement on critical paths.
- `CONTRIBUTING.md` for predictable contribution expectations.

## Dependency and Security Defaults

- Dependabot version updates enabled for GitHub Actions and Python (`pip`).
- Dependabot security updates enabled.
- Private vulnerability reporting enabled.
- CodeQL advanced workflow enabled for Python and GitHub Actions.
- CodeQL default setup disabled when advanced workflow is present.
- CodeQL checks move to required status checks only after one confirmed green run.
- Workflow action references pin to full commit SHAs for immutable releases.
- Repository-level `sha_pinning_required=true` is the recommended hardened
  state, but this template documents that setting instead of bootstrap-managing
  it because the same Actions permissions API also controls `allowed_actions`.
  The live template repository enforces `sha_pinning_required=true` directly at
  the repository settings level.
- Dependency review is available as a gated workflow baseline:
  - public repositories are supported by default;
  - private repositories require GitHub Code Security or GitHub Advanced
    Security before enabling the workflow as an active gate.

## CI and Quality Defaults

- Python lint (`ruff`).
- Markdown lint (`markdownlint-cli2`).
- YAML lint (`yamllint`).
- GitHub Actions lint (`actionlint`).
- Shell script lint (`shellcheck`).
- Pre-commit hooks to mirror CI checks locally.
- Shared verified `actionlint` release-binary helpers so CI and pre-commit use
  the same pinned version without relying on a local Go toolchain.
- `AGENTS.md` operational guidance for repository-local agent behavior.
- `CLAUDE.md` shim support for Claude Code without duplicating shared rules.
- `docs/AGENTS.example.md` as a copy/adapt baseline for downstream repos.
- Bootstrap ruleset payload generation covered by a dedicated smoke script.
- Required-check workflows use workflow-level concurrency so superseded runs are
  canceled instead of piling up on active branches.
- Required-check workflows include `merge_group` triggers so merge queue can
  reuse the same required checks without missing status reports.

## Harness Engineering Standards

### Legibility

- Documentation should be optimized for agent execution, not only human narrative.
- Critical operational rules should be explicit, terse, and colocated with the repo.
- The current source of truth for agent behavior is `AGENTS.md`.

### Entropy Control

- Any change to `.github/workflows/*`, `scripts/bootstrap_repo.sh`, or security posture
  must include synchronized updates to docs and changelog in the same patch.
- Conflicting docs should be treated as defects and fixed immediately.
- Policy changes should include both intent and enforcement mechanism.

### Execution Planning

- Non-trivial changes should begin with an explicit execution plan.
- Use `docs/execution-plan-template.md` for common structure and handoff format.
- Plans should list assumptions, validation steps, and rollback path.

### Steering Loop And Adaptation

- Long-running or uncertain work should expose checkpoints where scope can be adjusted.
- Unknowns and blockers should be surfaced early, with explicit fallback options.
- Standards should be revised as tools and model behavior evolve.

## Operational Friction Reducers (Optional Patterns)

The following patterns are optional but high ROI for agent-heavy repositories:

1. Single quick-gate command before pushes (`scripts/run_repo_quick_gate.sh`).
2. Event-triggered setup policy (bootstrap only on trigger changes, not every thread).
3. Machine-readable host profiles for default jobs/backend selection.
4. Manifest-first run provenance with central run index and integrity checks.
5. Storage boundary audits for local-only synced artifacts vs tracked code/docs.
6. Active-doc contraction with ADRs to preserve rationale and reduce prompt load.
7. Reusable workflows with `workflow_call` when multiple repos share the same CI
   job graph and stable required-check contexts must be preserved.

Reference:

- `docs/operations-patterns.md`

## Release and Audit Defaults

- Semantic version tags and release notes.
- Changelog maintained in-repo.
- Security policy maintained in-repo.
