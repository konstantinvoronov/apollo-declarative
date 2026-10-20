---
name: task-decomposer
description: Review a commit, commit range, staged change, or working tree for excessive scope across projects, features, and independent concerns, then recommend smaller approachable tasks and commits. Use before finalization or when the user asks whether work should be split.
---

# Task Decomposer

Perform a read-only scope review. Recommend undoing or reorganizing work when useful, but never reset, revert, restore, uncommit, delete, stage, or commit anything without separate explicit authorization.

## Select the change set

Inspect the commit, commit range, staged changes, or working-tree changes named by the caller. When no target is named, use the current job's changes established from the conversation and Git evidence. Separate unrelated pre-existing changes and report uncertainty.

## Inventory the scope

Identify:

- distinct repositories or projects;
- affected features;
- user-visible outcomes;
- independent architectural or behavioral concerns;
- migrations, refactors, generated output, tests, diagnostics, and documentation supporting each outcome;
- dependencies that determine the order of possible smaller tasks.

Do not judge scope by changed-line count alone. Keep implementation, tests, diagnostics, specification updates, and required documentation together when they verify one coherent outcome.

## Decide whether to decompose

Recommend decomposition when the change combines independently deliverable outcomes, unrelated features, multiple projects that can be completed separately, or a refactor that can be reviewed independently from behavior built on top of it.

Treat a cross-layer change as one task when every layer is required for one coherent feature outcome. Do not create artificial micro-commits that cannot be built, reviewed, or verified independently.

## Recommend the smaller tasks

When decomposition is appropriate:

1. State why the current change is too broad.
2. Recommend preserving a recoverable snapshot before reorganizing it.
3. Suggest returning the combined work to an editable state only as a proposed action requiring developer approval.
4. Define ordered smaller tasks, each with one outcome, affected project and feature, file scope, dependencies, acceptance criteria, verification, documentation, diagnostics, and intended commit boundary.
5. Identify files that must move together and files that can safely be separated.

When the change is already cohesive, say so and explain why a smaller split would reduce clarity or verifiability.

## Report

Return the number of projects, features, and independent outcomes found; the decomposition decision; the proposed ordered tasks when needed; and a final `PASS`, `SPLIT RECOMMENDED`, or `BLOCKED` result. Do not perform the proposed Git operations.
