# agentic-github-governance

[![License](https://img.shields.io/github/license/M-Gage-Plott42/agentic-github-governance?label=License)](LICENSE)
[![ruff](https://github.com/M-Gage-Plott42/agentic-github-governance/actions/workflows/lint-python.yml/badge.svg?branch=main)](https://github.com/M-Gage-Plott42/agentic-github-governance/actions/workflows/lint-python.yml)
[![markdownlint](https://github.com/M-Gage-Plott42/agentic-github-governance/actions/workflows/lint-markdown.yml/badge.svg?branch=main)](https://github.com/M-Gage-Plott42/agentic-github-governance/actions/workflows/lint-markdown.yml)
[![yamllint](https://github.com/M-Gage-Plott42/agentic-github-governance/actions/workflows/lint-yaml.yml/badge.svg?branch=main)](https://github.com/M-Gage-Plott42/agentic-github-governance/actions/workflows/lint-yaml.yml)
[![actionlint](https://github.com/M-Gage-Plott42/agentic-github-governance/actions/workflows/lint-actions.yml/badge.svg?branch=main)](https://github.com/M-Gage-Plott42/agentic-github-governance/actions/workflows/lint-actions.yml)
[![shellcheck](https://github.com/M-Gage-Plott42/agentic-github-governance/actions/workflows/lint-shell.yml/badge.svg?branch=main)](https://github.com/M-Gage-Plott42/agentic-github-governance/actions/workflows/lint-shell.yml)
[![CodeQL](https://github.com/M-Gage-Plott42/agentic-github-governance/actions/workflows/codeql.yml/badge.svg?branch=main)](https://github.com/M-Gage-Plott42/agentic-github-governance/actions/workflows/codeql.yml)

Opinionated template for AI-assisted development repositories using agentic
GitHub governance defaults:

- predictable CI and lint checks,
- dependency hygiene with Dependabot,
- security defaults and vulnerability reporting,
- non-blocking admin bypass for branch rulesets,
- cross-agent instruction pattern with `AGENTS.md`, `CLAUDE.md`, and an
  illustrative AGENTS template.

## Harness Engineering Model

This template treats repository docs as an operating harness for both humans and
agents:

- `AGENTS.md` defines local execution behavior and escalation rules.
- `docs/standards.md` defines governance, CI, and quality baselines.
- `docs/execution-plan-template.md` is the default plan format for non-trivial changes.

## Use This Template In 60 Seconds

1. Click **Use this template** on GitHub to create your new repository.
1. Set your repository name/description and confirm default branch is `main`.
1. Run bootstrap to apply branch protection ruleset + security defaults:

   ```bash
   bash scripts/bootstrap_repo.sh <owner>/<repo>
   ```

1. Add/confirm topics so discoverability is instant:

   ```bash
   gh repo edit <owner>/<repo> \
     --add-topic github-actions \
     --add-topic codeql \
     --add-topic dependabot \
     --add-topic pre-commit \
     --add-topic repo-template \
     --add-topic governance
   ```

## Included Files

- `.github/dependabot.yml`
- `.github/workflows/lint-python.yml`
- `.github/workflows/lint-markdown.yml`
- `.github/workflows/lint-yaml.yml`
- `.github/workflows/lint-actions.yml`
- `.github/workflows/lint-shell.yml`
- `.github/workflows/codeql.yml`
- `.github/workflows/dependency-review.yml`
- `.github/workflows/dependabot-auto-merge.yml`
- `.github/dependency-review-config.yml`
- `.github/CODEOWNERS`
- `.pre-commit-config.yaml`
- `.markdownlint.yaml`
- `.yamllint.yml`
- `AGENTS.md`
- `CLAUDE.md`
- `CONTRIBUTING.md`
- `scripts/install_actionlint.sh`
- `scripts/run_actionlint.sh`
- `scripts/generate_ruleset_payload.sh`
- `scripts/smoke_bootstrap_ruleset_payload.sh`
- `scripts/run_repo_quick_gate.sh`
- `scripts/check_storage_boundaries.py`
- `docs/execution-plan-template.md`
- `docs/operations-patterns.md`
- `docs/active/current_focus.example.md`
- `docs/adr/README.md`
- `docs/policies/host_profiles.example.json`
- `docs/policies/storage_boundaries.example.json`
- `docs/policies/run_manifest.example.json`
- `src/template_sanity.py`
- `CHANGELOG.md`
- `SECURITY.md`
- `docs/AGENTS.example.md`
- `docs/standards.md`
- `scripts/bootstrap_repo.sh`

## Quickstart

```bash
git clone git@github.com:M-Gage-Plott42/agentic-github-governance.git
cd agentic-github-governance
python3 -m venv .venv
source .venv/bin/activate
pip install pre-commit ruff yamllint
pre-commit install
pre-commit run --all-files
bash scripts/run_repo_quick_gate.sh
```

## Quick Local Gate

Use one command before push:

```bash
bash scripts/run_repo_quick_gate.sh
```

Optional strict boundary check:

```bash
bash scripts/run_repo_quick_gate.sh --with-boundaries --strict-boundaries
```

## Workflow Hardening Defaults

Required-check workflows in this template are hardened to be portable and
predictable:

- action references are pinned to full commit SHAs,
- workflow-level concurrency cancels superseded runs on the same ref,
- `merge_group` triggers are included so merge queue can reuse the same
  required checks without missing status reports.

## Actions SHA Pinning Setting

As of `2026-04-12`, this repository's Actions permissions audit returns
`sha_pinning_required=true`.

Audit a repository setting read-only with:

```bash
gh api repos/<owner>/<repo>/actions/permissions
```

Enable the setting manually in the GitHub UI:

- `Settings -> Actions -> General -> Require actions to be pinned to a full-length commit SHA`

Or via the Actions permissions API:

- `PATCH /repos/{owner}/{repo}/actions/permissions`

This template does not automate that API call in `scripts/bootstrap_repo.sh`
yet, because the same endpoint also controls `allowed_actions`, which is a
broader policy decision than simply flipping SHA enforcement. The live template
repository now enforces the setting directly at the repository level.

## Git Transport For Agent Sessions

Prefer SSH remotes for push operations from non-interactive agent shells. HTTPS
pushes can fail on credential prompts in headless environments.

Use:

```bash
git remote set-url origin git@github.com:<owner>/<repo>.git
gh auth setup-git
```

Check:

```bash
git remote -v
```

## Bootstrap New Repo Settings

```bash
bash scripts/bootstrap_repo.sh M-Gage-Plott42/your-repo
```

This applies settings and rulesets with admin bypass so required checks protect PRs without blocking owner/admin direct pushes when needed.

For CodeQL, this template uses the advanced workflow in `.github/workflows/codeql.yml`, and bootstrap disables GitHub's CodeQL default setup to prevent SARIF upload conflicts.

If a legacy dynamic CodeQL workflow entry remains listed in Actions metadata, bootstrap attempts cleanup and prints a manual UI fallback if the GitHub API refuses the disable operation.

CodeQL required-check rollout is intentionally two-phase. After one confirmed green CodeQL run, enforce CodeQL checks in branch rulesets with:

```bash
REQUIRE_CODEQL_CHECKS=1 bash scripts/bootstrap_repo.sh M-Gage-Plott42/your-repo
```

## Dependency Review (Optional, Gated)

This template includes a dependency review workflow plus
`.github/dependency-review-config.yml`, but keeps required-check enforcement
opt-in.

Support matrix:

- public repositories: supported by default;
- private repositories: supported only with GitHub Code Security or GitHub
  Advanced Security.

Default behavior:

- public repositories run dependency review automatically on pull requests;
- private repositories keep the job dormant unless the repository variable
  `ENABLE_DEPENDENCY_REVIEW=true` (or `1`) is set after the repository has the
  required GitHub security feature enabled.

Make dependency review required in branch rulesets only when the repository is
ready for it:

```bash
REQUIRE_DEPENDENCY_REVIEW=1 bash scripts/bootstrap_repo.sh M-Gage-Plott42/your-repo
```

Ruleset payload smoke test:

```bash
bash scripts/smoke_bootstrap_ruleset_payload.sh
```

## AGENTS.md Pattern

- `AGENTS.md` is the live operational contract for this template repository.
- `CLAUDE.md` imports `AGENTS.md` with Claude-specific notes kept below the
  import.
- `docs/AGENTS.example.md` is a reusable starting template for downstream repositories.

## Optional Operational Patterns

The template now includes portable patterns for:

- event-triggered setup checks,
- machine-readable host profiles,
- manifest-first run provenance,
- storage boundary audits,
- active-doc contraction with ADR memory,
- reusable workflows with `workflow_call` for multi-repo estates.

See `docs/operations-patterns.md`.
