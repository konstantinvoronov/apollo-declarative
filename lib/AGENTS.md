# AI Agents Guide (`AGENTS.md`)

<!-- shared-ai-harness:start -->
## Project-Local Harness

Follow `/ai_development/ai_harness.md`. Execute skills from this project's `.agents/skills`, not a sibling repository. Before edits, follow its task-scope and approval gate: resolve necessary layers and responsibilities, propose exact files and intended changes, and obtain approval. `lib/main.dart` is frozen unless the developer separately approves its exact change. At finalization, verify approved scope, use the local pattern keeper, and collect unprocessed user-declared violations before the final read-only audits. Pattern catalogs inherit cumulatively with specific subtree overrides; do not preload unrelated catalogs or create one per folder. Harness maintenance is developer-invoked only.
<!-- shared-ai-harness:end -->

## Declarative Foldering Authority

Read [Declarative Foldering Rules](../ai_development/declarative_foldering_rules.md) before resolving architectural placement or dependencies. That document is the source of truth for default ownership, scope, layers, responsibilities, and import/export directions.

This root guide and applicable descendant `AGENTS.md` files are scoped override declarations. Omitted fields inherit the document defaults; only explicitly declared, approved differences replace corresponding rules within their scope. Do not duplicate the general architecture or silently treat contradictory legacy text as an intentional override.

This file defines how agents must work with repository. It only cover certain places we manage to get hands on

Main rule - keep it simple, always try to find simple, streamlined, easy to digest solution
that will do the job. no overengenering, optional things or extra cautios.


# Foldering architecture

In this project it is important to position files in the correct architectural folders. Applicable blueprint and general layer rules define their responsibilities, structure, naming, and dependencies. A separate local AGENTS.md is needed only for an uncovered requirement or exception.

Dependencie rules estimated ralatebly to import and export syntact form the files inside folders.

To enforce declared architecture structure every time you finish implementing something new you must
run linter screen that will check how good you are doing and request changes if you broke the rules.

## Project Instructions and Scoped Overrides

### Image asset formats

Follow the image asset format rules in /ai_development/declarative_foldering_rules.md for project artwork and image assets.

### AppFailure usage instructions

Follow `/ai_development/app_failure_usage_rules.md` when implementing or reviewing failure handling.

### StatefulData usage instructions

Use the published `stateful_data` package for declarative data lifecycles instead of local `Resource` or per-value lifecycle types such as `AppSessionState`. Follow `/ai_development/stateful_data_usage_rules.md` when implementing or reviewing these lifecycles. This models a single data value, not the screen or Controller's overall state.

### Architectural-rule approval safeguard

Architectural-rule changes must match the exact proposed and approved content. Approval of an architectural outcome does not authorize additional constraints, prerequisites, or documentation requirements. Any newly discovered policy decision must be presented separately. Reviews must check both compliance and approval provenance.

### DI startup and registration boundaries

`/lib/app/di.dart` owns the GetIt container and initialization sequence. Its project imports are restricted to `/lib/app/di/`; Dart SDK and `get_it` remain permitted for wiring. The feature helper `/lib/app/di/features_di.dart` may import only public feature-root `/lib/features/<feature_name>/di.dart` entrypoints. The Core helper `/lib/app/di/core_di.dart` may import only `/lib/core/core_di.dart` as a project dependency. Both receive the container as an argument and are consumed only by the global DI entrypoint. Core's coordinator owns Core registrations, not feature registration or application routing/authentication policy. Resolve both dependency directions at every hop; this wiring does not permit importing feature internals.

## Logging Foldering structure and architecture

foldering is important - it defines scope, responsobilites and give instructions,
read applicable root, blueprint, and ancestor AGENTS.md files; do not create missing local guides unless an uncovered requirement or exception needs one.

store and update files accord ing to instructions.

lib/ui/common/uikit/ - Place With new UIKit elements analogs of figma each one in a new folder
aka  lib/ui/common/uikit/element_name/
inside the folder
file element_name_spec.md that hace figma link inside and spec for ai agent
file element_name_plan.md file with current developing progress and developer corrections and code review and progress

## Developing principles

Preserve existing comments, especially comments the agent did not author. Do not remove, rewrite, or translate them without explicit developer approval. If an existing comment appears outdated or conflicts with the implementation, report the mismatch for discussion instead of silently changing it. The English-language convention does not authorize changing existing comments.

Ask many question during planning sessions
Minimal refactor,
No renaming,
No ai comments only /// docs for 1-2 lines top on public functions
Always generate separate file for separate layers.
Clean architecture structure with clear Responsobilities, Single source of truth
Widgets should be simple and follow generic flutter approach, instead of taking alot of params they take child widget unless it is a comlex widget

Declarative programing style:
bed: ifAbsent functions, ensurePresence or loadIfNeeded.
good: sealed state classes with exastive switch sysntacses, business logic separation from ui,

fail soon rule. dont do exastive checking on data validity, report fail instead of hiding

### Planing work

start working with estimating layers involved and folders need to do that always study /feature/feature_name/AGENTS.md
and other files inside project and use it as a responsobilities and architecture blue pring for creating and modificating folders.
store source task
define stages
estimate correctness and suggest spliting task
each task should containing planing/rewieving plan/implementing/reviewing/correting and you should always remind developer to do next stage
it may involve other stage

ask if we need to write test but never do it by default
