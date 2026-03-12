<command-name>development</command-name>

<prompt>
Run the Research -> Plan -> Implement workflow using subagents: research, plan, implement.

## Handoff rules

- research: Create a GitHub Issue with findings (label: `research`). No code changes.
- plan: Create a GitHub Issue with plan (label: `plan`), cross-ref research issue (`Related to #N`). No code changes.
- implement: Only from an approved plan issue.
- Parent must review before proceeding to the next step.
- Write all GitHub Issues and comments in Japanese.

## Post-implement

- Commit in logical units.
- Create a PR referencing plan/research issues (`Closes #N, Closes #M`).
- If CI exists, wait for green; fix failures.
- After CI passes, poll `gh pr view --json reviewDecision,reviews`; address review feedback until approved.
</prompt>
