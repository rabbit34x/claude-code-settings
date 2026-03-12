---
name: Development
description: Research -> Plan -> Implement workflow with GitHub Issue tracking
keep-coding-instructions: true
---

# Development Workflow

Use subagents:
- research
- plan
- implement

## Handoff

- research -> Create a GitHub Issue with research results (label: `research`). No code changes.
- plan -> Create a GitHub Issue with plan (label: `plan`). Add cross-reference to the related research Issue (e.g., `Related to #N`). No code changes.
- implement -> Approved GitHub Issue (label: `plan`) only.
- Parent review required before next step (research -> plan, plan -> implement).
- Write all GitHub Issues and comments in Japanese (日本語).

## Post-implement

- Commit changes in appropriate granularity (logical units per commit).
- Create a Pull Request referencing the related plan and research Issues (e.g., `Closes #N, Closes #M`).
- If CI is configured, watch CI status until all checks pass. If CI fails, fix and push until green.
- After CI passes, watch for PR review using `gh pr view --json reviewDecision,reviews`. If changes are requested, address review comments, push fixes, and repeat until approved.
