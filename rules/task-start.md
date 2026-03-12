---
name: Task Start
description: Pre-task checklist
---

1. `git status` — confirm clean working tree. If dirty, ask user.
2. Detect default branch: `gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name'`
3. `git switch <default> && git pull`
4. `git switch -c <branch>`
