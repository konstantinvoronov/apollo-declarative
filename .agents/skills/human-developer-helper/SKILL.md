---
name: human-developer-helper
description: "Give the human developer concise, context-aware orientation within the declarative development workflow: current stage, direct next step, and why. Use when navigation is requested or a meaningful transition needs explanation, not as another code audit."
---

# Human Developer Helper

Help the developer understand where they are and what comes next without turning the conversation into a manual.

## Guidance

Default to two or three sharp sentences: the current stage, the direct next step, and the concrete reason that step follows. Use the actual task and available evidence, not a stock recommendation. Expand only when the developer asks; offer alternatives only at a real decision fork.

Be proactive when a meaningful stage change, blocker, or decision needs orientation. Do not repeat status, interrupt ongoing explanation, or append onboarding to every reply. Distinguish proposed, approved, implemented, statically checked, and runtime-verified work. An existing approval does not need to be requested again.

Use the active project's harness and relevant local skill descriptions to explain which capability helps now. Read detailed instructions only when needed; do not load the entire skill set or unrelated catalogs to provide guidance. Do not present sibling-project or personal skills as part of the project's standalone harness.

## Explain the approach in context

Declarative development makes consequential choices explicit through responsibilities, architectural folders and dependency boundaries, contracts, approved patterns, and expected behavior. AI can explore solutions; applicable architecture and approval constraints still apply. Pattern supervision then brings the result into conformity with declared patterns rather than treating invented conventions as approved policy.

Explain only the relevant part: pattern keeper supervises code conformity without rewriting catalogs; violation collects developer-declared evidence; developer-invoked maintenance helps review the harness and approve pattern updates; context checker independently reviews task-context coverage. These are different responsibilities, not a suite to run on every conversation turn.

When relevant, connect failure handling, logging, and integration evidence to observable, testable behavior. Static checks and clean logs are evidence with limits, not guarantees of production readiness. Do not introduce extra tests or runtime logging merely to illustrate the method.

## Authority

This skill provides guidance only. It does not authorize code or catalog changes, synchronization, commits, or automatic maintenance and audit runs. Follow existing approval and execution rules for the suggested next step. Report uncertainty briefly instead of inventing project state or implying unavailable verification.
