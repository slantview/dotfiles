---
name: git-worktrees
description: "Mandatory workflow for every task that may edit, generate, format, test with file changes, commit, or publish in a Git repository. Always load this skill before any repository mutation. It keeps primary checkouts read-only and requires all work on fresh branches in dedicated linked worktrees."
---

# Git Worktrees

Use a dedicated linked Git worktree for every repository change.
The primary checkout is read-only.

## Non-Negotiable Rule

Never edit repository files in the primary checkout.
This includes direct edits, generated files, formatter output, dependency lockfile updates, build artifacts, staging, commits, and any test or tool that can change the working tree.

The primary checkout may be used only for read-only inspection, fetching remote refs, and `git worktree` management.
If the work cannot proceed in a linked worktree, stop and report the blocker.

## Required Workflow

1. Inspect the current checkout with `git status --short --branch` and `git worktree list --porcelain`.
2. Determine the remote default branch from `refs/remotes/origin/HEAD` or the repository host.
3. Fetch current refs with `git fetch origin --prune` without changing the primary working tree.
4. Create a fresh task branch from `origin/<default-branch>`.
5. Add a linked worktree in a sibling worktree directory outside the primary checkout.
6. Confirm the linked worktree is on the intended branch and starts clean.
7. Perform all edits, generation, formatting, validation, staging, commits, pushes, and pull request work inside that linked worktree.
8. Keep unrelated work in separate worktrees and separate pull requests.
9. Remove a task worktree only after its work is safely published or merged and its branch disposition is proven.

Example setup:

```bash
git fetch origin --prune
git worktree add -b agent/<task-name> ../worktrees/<repository>-<task-name> origin/<default-branch>
cd ../worktrees/<repository>-<task-name>
git status --short --branch
```

## Existing Linked Worktrees

An existing linked worktree may be reused only when it is dedicated to the exact same task, its branch is correct, and its current contents have been audited.
Do not reuse stale, shared, detached, or unrelated worktrees for convenience.

## Dirty Primary Checkouts

Treat every existing change in a primary checkout as user-owned work.
Do not stash, reset, clean, move, delete, stage, or commit it from the primary checkout.

Audit the change read-only.
If it is useful and unpublished, recreate or port the exact intended change onto a fresh branch in a separate linked worktree.
Validate and publish that work independently before any cleanup is considered.

## Completion Gate

Before declaring the task complete, verify that:

- The implementation and commit exist only in the dedicated task worktree and branch.
- The primary checkout was not modified by the task.
- The task worktree has no unexplained changes.
- Every retained change is committed and published through the intended pull request workflow.
- Cleanup would not remove unpublished work.
