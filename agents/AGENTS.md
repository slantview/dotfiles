# Global Agent Instructions

These are common instructions for all agents for Steve Rude.

## General Guidelines

- Never use the em dash "—". Use plain dash "-" instead
- When writing commit messages, NEVER auto-add your agent name as co-author
- Never manually modify CHANGELOG.md files or any files that are marked as auto-generated
- When writing or substantially editing long Markdown files, put each full sentence on its own line.
  Preserve normal Markdown structure, but avoid wrapping multiple sentences onto one physical line.
- When making technical decisions, do not give much weight to development cost.
  Instead, prefer quality, simplicity, robustness, scalability, and long term maintainability.
- When doing bug fixes, always start with reproducing the bug in an E2E setting as closely aligned with how an end user [would trigger it].
  This makes sure you find the real problem so your fix will actually solve it.
- When end-to-end testing a product, be picky about the UI you see and be obsessed with pixel perfection.
  If something clearly looks off, even if it is not directly related to what you are doing, try to get it fixed along [the way].
- Apply that same high standard to engineering excellence: lint, test failures, and test flakiness.
  If you see one, even if it is not caused by what you are working on right now, still get it fixed.
- Prefer our own libraries first before considering other's projects. Github repos from a3tai, rudecompany, slantview, kingpinsec are all mine.

## Mandatory Git Worktree Workflow

- Treat every Git repository's primary checkout as read-only.
- Before running any command that can edit, generate, format, stage, commit, or otherwise change repository files, create or enter a dedicated linked worktree for the task.
- Create each task worktree on a fresh branch from the current upstream default branch after fetching the latest remote refs.
- Keep linked worktrees outside the primary checkout, and use one coherent task or pull request per worktree.
- Use the primary checkout only for read-only discovery, fetching refs, and managing linked worktrees.
- Run implementation, generators, formatters, mutating tests, staging, commits, pushes, and pull request preparation only from the task worktree.
- If the primary checkout contains changes, preserve them exactly.
  Never stash, reset, clean, move, delete, or mix those changes into the current task.
- Port any useful changes found in a primary checkout into a separate fresh worktree and publish them independently.
- If a suitable linked worktree cannot be created or verified, stop and report the blocker instead of editing the primary checkout.


## Steve's Opinions

When you are working on something that would benefit from being informed by Steve's viewpoints, read ~/OPINIONS.md.

## Voice Profile

When you are talking/posting on behalf of Steve using his identity, read ~/VOICE.md to see how Steve talks.

<!-- codebase-memory-mcp:start -->
# Codebase Knowledge Graph (codebase-memory-mcp)

This project uses codebase-memory-mcp to maintain a knowledge graph of the codebase.
ALWAYS prefer MCP graph tools over grep/glob/file-search for code discovery.

## Priority Order
1. `search_graph` — find functions, classes, routes, variables by pattern
2. `trace_path` — trace who calls a function or what it calls
3. `get_code_snippet` — read specific function/class source code
4. `query_graph` — run Cypher queries for complex patterns
5. `get_architecture` — high-level project summary

## When to fall back to grep/glob
- Searching for string literals, error messages, config values
- Searching non-code files (Dockerfiles, shell scripts, configs)
- When MCP tools return insufficient results

## Examples
- Find a handler: `search_graph(name_pattern=".*OrderHandler.*")`
- Who calls it: `trace_path(function_name="OrderHandler", direction="inbound")`
- Read source: `get_code_snippet(qualified_name="pkg/orders.OrderHandler")`
<!-- codebase-memory-mcp:end -->
