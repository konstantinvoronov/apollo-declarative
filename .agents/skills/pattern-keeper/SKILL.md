---
name: pattern-keeper
description: Supervise the current uncommitted job against applicable project-wide and folder-scoped implementation patterns at finalization. Require corrections without editing source, pattern catalogs, or harness rules.
---

# Pattern Keeper

Use this project's `ai_development/ai_harness.md` and local pattern catalogs. Do not use a sibling project's skill or patterns as an implicit authority. This is an enforcement supervisor, not a catalog-maintenance or code-writing skill.

## Resolve the job and effective patterns

Identify the current job from the conversation, staged and unstaged diffs, and untracked files. Separate unrelated existing work. If the current job cannot be isolated, report the missing evidence instead of attributing the entire dirty tree to it.

Read `ai_development/patterns.md`, then existing `patterns.md` files along each involved file's ancestor chain. Deduplicate reads and load only the relevant catalogs, not every catalog in the repository. No local file is required. Read related callers/collaborators and their catalogs only where needed to establish the changed behavior.

All ancestor catalogs still apply. A more-specific pattern overrides only the identified rule for its folder and descendants; other inherited patterns remain active. Do not treat the nearest catalog as a replacement or duplicate inherited entries into local files. Preserve architecture and approval requirements. Report contradictions without silently selecting the easier rule. A missing catalog or absent applicable pattern is not itself a violation.

## Supervise conformity

For each applicable pattern, compare the actual implementation and connected behavior with its use/non-use conditions, good example, and rejected approach. Check semantics, lifecycle, dependencies, and error handling where the pattern addresses them, rather than matching surface text alone. Do not force the incidental details of an example onto unrelated situations.

Report deviations with code locations, pattern source and scope, evidence, and the correction needed to preserve intended behavior while following the pattern. Require the implementing agent to rethink and correct the solution within the authorized job, then rerun this check and affected verification. A review request alone does not authorize edits; existing approvals and protected-code rules still govern the implementation agent.

Do not edit any source, patterns, violations, or harness instructions yourself. Never invent or weaken a pattern to justify existing code, add a new architecture requirement, or demand unrelated refactoring. Escalate a pattern gap or unresolved conflict to the developer instead of hallucinating a rule. Catalog maintenance belongs to the separately invoked maintenance skill.

## Result

Return applicable pattern sources, verified matches, required code corrections, and unresolved gaps/conflicts. State `PASS`, `CORRECTIONS REQUIRED`, or `BLOCKED`. An empty applicable catalog can pass with no applicable patterns; do not manufacture findings. Finalization cannot pass while a confirmed deviation remains. After implementation changes, evidence must refer to the resulting code, not the earlier diff.
