# Project-Local AI Harness

## Ownership and execution

Each project carries its own `.agents/skills` and harness instructions. Run the skills from the project being changed, not from a sibling checkout. Apollo is the live implementation testbed; reusable improvements made there can be promoted back to the Declarative AI blueprint. A standalone project must not require that blueprint checkout at runtime or during development.

Common harness definitions are synchronized by `ai_development/sync_harness.py` using an explicit manifest. Pattern catalogs, violation history, implementation plans, application source, and synchronization state are project-owned and are not synchronized. The blueprint's pattern catalog starts empty; Apollo's catalog accumulates developer-approved implementation patterns. Do not populate either catalog just by observing existing code.

## Evidence-to-claim discipline

Distinguish existence, dependency compatibility, architectural permission, and runtime verification. Never summarize a failure in one category as a failure in another. State the observed fact separately from the proposed action. “Not found” requires a scoped search and means not found within that scope; “not checked” means unknown. Existing code with unresolved dependencies is not missing code, and a dependency problem alone does not justify replacing its behavior.

## Task scope and approval before edits

Before implementation, state the requested outcome and the minimum necessary architectural scopes and layers. Propose every file to create, modify, or delete, with its intended change and reason, including dependency, generated-file, and verification effects. Keep the plan concise; an architectural role or a convenient implementation path does not prove that the task needs it.

Use the project-local `resolve-declarative-responsibilities` for proposed new objects and affected responsibility or dependency boundaries before editing. Report scope, layer, role, naming, and both dependency directions with their controlling rules. Record that resolution in the proposal; resolving an object after implementing it is not evidence of a pre-edit check. Unresolved declarations require a developer decision, not invented permission.

Obtain explicit developer approval of the proposed file-and-change scope before implementation. Approval of the requested outcome alone is not approval of an unpresented implementation. If another file, layer, dependency, or materially different change becomes necessary, stop and request approval of the amended scope. Do not request the same approval again while implementing the unchanged approved scope. Read-only investigation may precede approval.

`lib/main.dart` is frozen by default. Do not edit, reformat, regenerate, or delete it as an ordinary implementation step. Startup ownership does not unlock it. A significant need must first be brought to the developer for a separate decision naming the file and exact intended change; only direct approval of that change unlocks it. Generic task approval does not suffice.

Before handoff, compare the actual task changes with the approved file-and-change scope, separately from architectural compliance and runtime verification. Include new, deleted, dependency, and generated files; distinguish pre-existing changes. Report missing approval or pre-edit resolution evidence as unverified or blocked, never as a pass inferred from valid placement or a clean analyzer.

## Scoped pattern catalogs

`ai_development/patterns.md` governs the entire project. An optional `patterns.md` in any other folder governs that folder and its descendants. These scoped coding contracts are permitted alongside source despite ordinary source-only file lists; they are not extra AGENTS guides or transient planning files. No folder is required to have a catalog.

For an involved file, apply the project-wide catalog and every catalog on its ancestor chain, from general to specific. Catalogs accumulate. A local declaration can override a specific inherited pattern within its subtree; it never cancels unrelated rules or the parent catalog. An override identifies the inherited pattern it changes. Missing local files inherit without copying patterns. Contradictory declarations that do not establish an intentional scoped override require a developer decision.

Keep each pattern short:

```markdown
## Pattern: descriptive_name — Short title

Use when: applicable situation.
Do not use when: excluded situations.
Rule and reason: the required approach and why.
Overrides: inherited pattern name, only for an intentional override.

### Good code
Small representative example of the approved approach.

### Bad code
Small representative example of the rejected approach, with its reason.
```

Use code fences in real entries. Examples are representative, not instructions to copy irrelevant details. Keep provenance from a processed violation with the entry when applicable. Existing architecture and approval rules remain active; a pattern catalog cannot silently change architectural boundaries.

## Work and finalization

Do not preload every pattern catalog while solving a task. Ordinary architectural and approval constraints still apply. At finalization, run the local `pattern-keeper` to resolve relevant catalogs and supervise conformity of the current uncommitted job. It issues evidence-based correction requirements; the implementation agent makes authorized code changes and reruns verification. The keeper itself does not edit code, catalogs, or harness rules, and cannot declare its own implementation to be a new approved pattern.

Run the local `violation` skill during a conversation when a violation is declared and during finalization to collect any unprocessed declarations from available dialogue. Store evidence in `ai_development/violations_unsorted.md`, not in a shared upstream history. Do not infer user declarations from ordinary corrections. Missing conversation evidence is a limitation, not permission to reconstruct quotations.

After corrections and violation capture, final verification audits the resulting code read-only. A scoped override is not a conflict merely because it differs from the general rule; unresolved contradictory requirements are conflicts. Report gaps instead of inventing a pattern to fill them.

## Task-specific context verification

The local context-checker can independently audit context health at any task stage. It derives required context from the user's task and the governing folder rules, then compares that with available evidence of consulted or automatically supplied sources. It distinguishes missing or excessive context, stale/wrong authority, and incorrect cumulative scope interpretation. It does not preload every catalog or guide merely to perform the check.

The checker is read-only and separate from harness maintenance. Its own inspection reads do not prove that the implementation agent had the same context earlier. When loading evidence or historical source versions are unavailable, it reports unverified coverage rather than claiming visibility into hidden model state. It recommends focused context corrections without editing code, rules, or catalogs. This is available at any stage, not a new mandatory check on every task or an automatic finalization prerequisite.

## Human developer guidance

The local human-developer-helper gives concise orientation when requested or when a meaningful transition needs explanation. Its default is two or three sharp sentences: current stage, direct next step, and why that step follows. It uses the actual task, approval state, and verification evidence, expanding only on request rather than repeating onboarding or listing every skill.

The helper explains the declarative approach and relevant local capabilities in context. It provides guidance, not execution authority or an automatic audit/maintenance stage; suggesting a next step does not approve it. It distinguishes proposals, implemented changes, and verified behavior without claiming that declarations or clean checks guarantee production readiness.

## Developer-invoked maintenance

`maintain-ai-harness` runs only at the developer's request, not as routine finalization. It reviews instruction discovery, staged context loading, authority, scope/override resolution, skills, and pattern consistency against the violation evidence. It distinguishes a source-code mistake from missing, conflicting, or ambiguous instructions. It does not claim that wording can guarantee absence of hallucinations.

The developer decides which violations become patterns and where they belong. Apply only approved catalog/harness updates. Preserve the cause, bad code, and confirmed good approach in the destination pattern before removing a processed violation and its linked follow-up records from the pending history. Verify the transfer and keep a recoverable original. Leave unrelated and undecided violations intact. This maintenance operation is the deliberate exception to the collection skill's append-only behavior.

## Synchronization

Use `python3 ai_development/sync_harness.py --source /path/to/source --target /path/to/target` to preview. Add `--apply` to perform a reviewed synchronization. Use `--path` to restrict the manifest to specific entries. The tool copies only listed shared files or marked sections; it never deletes unlisted target files or searches for catalogs to overwrite.

The first differing existing file is a conflict, not an automatic overwrite. Later runs compare with the last synchronized content: target-only edits are retained, and concurrent edits require reconciliation. After reviewing a conflict, `--accept-source path` explicitly chooses the source for that entry. That switch is not developer approval by itself. Never use it to erase independent work without the developer's direction. Existing files being replaced are backed up.

Run the same tool with source and target reversed to promote approved Apollo improvements. Do not turn intentional project-specific guide differences into shared files merely to make synchronization green. Extend the manifest only when that exact shared unit has been agreed.
