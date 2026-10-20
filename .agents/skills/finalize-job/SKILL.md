---
name: finalize-job
description: Audit a completed development job against this repository's declarative architecture, protected-file rules, feature documentation, diagnostic-log specification, verification evidence, and Git commit state. Use when the user asks to finalize, close, complete, or verify a job before handoff.
---

# Finalize Job

Use this project's local skills and ai_development/ai_harness.md, not a sibling checkout's definitions. The final verification pass is read-only: do not create commits or silently repair findings. Pattern enforcement and violation capture run before that pass as described below. Existing source-edit and approval boundaries remain active.

## Preparation before the final audit

Run the local violation skill over the available conversation to collect unprocessed developer-declared violations into the project-owned history, without inventing declarations or duplicating existing records. This authorized evidence capture may append history; it does not modify source or patterns. Report unavailable conversation evidence explicitly.

Run the local pattern-keeper against the current uncommitted job and its cumulative scoped catalogs. It supervises and requires conformity without editing files. If it reports required code corrections, return to the implementation phase: obtain any approval required by the project, make authorized corrections, then rerun the keeper and affected verification. Do not finalize a job with confirmed pattern deviations or unresolved effective-rule conflicts. An empty catalog is not a reason to invent patterns.

Only after that preparation run the final read-only audits below on the resulting code. Harness maintenance is not part of normal finalization; invoke maintain-ai-harness only at the developer's explicit request. Finalization never updates catalogs to make code pass.

## Required project-local audits

Load and run the project-local `check-declarative-rules` skill for the current job. Use its report as the architecture-compliance result.

Load and run the project-local `check-naming` skill for the current job. Any confirmed naming violation or unresolved naming-rule conflict means the job is not ready to finalize. Optional naming improvements do not block finalization.

Load and run the project-local `check-responsibility-leaks` skill for the current job. Any confirmed responsibility leak means the job is not ready to finalize. Possible leaks must be reported separately and block finalization only when the required evidence is unavailable.

Load and run the project-local `task-decomposer` skill for the same change set. A `SPLIT RECOMMENDED` result means the job is not ready to finalize. Present its smaller-task proposal, but do not undo, reorganize, stage, or commit the work.

Load and run the project-local `update-diagnostic-spec` skill in `audit` mode for every affected feature. A `SPEC UPDATE REQUIRED` or undocumented `DIAGNOSTIC LIMITATION` means the job is not ready to finalize. Finalization must not run this skill in update mode or modify source files.

If any required project-local skill is missing or cannot run, mark finalization `BLOCKED`.

## Establish the job scope

Identify the files and features changed for the current job from the conversation, the working-tree diff, and the relevant commits. Separate current-job changes from unrelated or pre-existing work. If that separation cannot be established reliably, state what evidence is missing instead of attributing unrelated changes to the job.

## Audit declarative architecture

Include the complete result from `check-declarative-rules`. Do not replace its audit with a superficial folder check.

## Audit affected feature documentation

For every affected feature, verify its `ai_development` folder and required documents against that folder's `AGENTS.md`:

- `feature_spec.md` describes the implemented behavior, requirements, acceptance criteria, and supported corner cases;
- `implementation_plan.md` reflects remaining work while the feature is incomplete;
- `development_history.md` preserves the feature-specific developer conversation, decisions, clarifications, corrections, implementation history, and verification results from this job;
- `<feature_name>_logs_test_spec.md` defines expected diagnostic events, corner cases, failure evidence, and the procedure an AI agent uses to determine whether the feature works correctly.

Do not accept a document merely because it exists. Compare its contents with the actual change and the developer's decisions in the current conversation.

## Audit diagnostics and verification

Verify that changed behavior has diagnostic evidence sufficient for the feature's log specification. Check that relevant analysis, tests, and log checks have completed successfully and correspond to the changed behavior. Distinguish a missing check from a failed check and include the available command or log evidence.

## Audit Git completion

Inspect repository status and relevant commit history. The job is committed only when every current-job change is included in a commit and no current-job file remains staged, modified, deleted, or untracked. Do not create, amend, squash, push, or otherwise modify commits as part of this audit.

## Report

Return a concise checklist with one of these results for each area:

- `PASS`: requirement verified with evidence;
- `FAIL`: requirement is unmet;
- `BLOCKED`: required evidence is unavailable;
- `NOT APPLICABLE`: explain why the requirement does not apply.

Cover pattern conformance, violation-capture evidence, declarative architecture, naming and responsibility alignment, behavioral responsibility leakage, task decomposition, protected files and approvals, feature specification, implementation plan, development history, diagnostic coverage and log specification, verification evidence, and commit state. Finish with an overall result. Mark the job finalized only when every applicable item passes, the pattern keeper passes, the naming audit has no confirmed violation or unresolved rule conflict, the responsibility audit has no confirmed leak, the task decomposer does not recommend a split, and the diagnostic audit requires no update.
