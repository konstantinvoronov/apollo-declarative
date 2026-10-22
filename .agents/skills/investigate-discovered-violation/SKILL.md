---
name: investigate-discovered-violation
description: At the developer's explicit request, investigate an existing violation discovered during review or maintenance, trace its evidenced origins and contributing causes, and coordinate approved remediation and verification.
---

# Investigate Discovered Violation

Use this project's local skills and governing harness. Run when the developer requests investigation of a discovered violation, including legacy code and technical debt outside an active task. Ordinary violation reporting uses the separate collection skill; invoking this investigation is a distinct developer decision.

## Establish the discovery

Identify the reported behavior, expected rule or pattern, affected object and path, current revision, and available historical evidence. Accept a file, declaration, example, violation record, or commit as a starting point; a prior task or ticket is optional. Ask only for information necessary to establish the finding.

Keep investigation read-only. Preserve the working tree and use Git history inspection to examine earlier revisions. Load historical source as evidence while following the active project's current execution and approval instructions.

## Trace evidenced causes

Use relevant diffs, file history, renames, callers, contracts, specifications, and available review records to locate the introduction of the behavior. Follow each supported contributing cause backward, including earlier decisions or dependencies that led to the visible symptom. Stop at the earliest supported cause or a clearly identified evidence boundary.

Distinguish introduction, later propagation, and discovery. Separate confirmed causes, contributing conditions, hypotheses, and unknowns. Commit timing or author identity alone establishes chronology rather than motive or causation.

Compare the implementation with rules and patterns available at the relevant revision, then separately assess current requirements. Distinguish an original violation from later architectural drift or a newer requirement. Record unavailable historical instructions and context traces as evidence limitations.

## Coordinate investigation checks

Read and perform these project-local skills for the affected architectural boundaries:

- `context-checker`: evaluate applicable context, authority, and available consultation evidence, keeping present inspection separate from historical loading evidence.
- `resolve-declarative-responsibilities`: resolve declared role, name, scope, layer, placement, and both dependency directions.
- `check-declarative-rules`: assess architectural declarations and approval evidence.
- `check-responsibility-leaks`: compare actual behavior and dependencies with the declared profile.
- `check-naming`: assess names against their responsibilities and applicable conventions.
- `pattern-keeper`: assess applicable approved patterns for the correction job.

For every result, identify the reviewed revision, files, rule versions, and limitations. Use each skill within its supported scope. For historical code outside a current-job skill's scope, provide a separately labeled historical comparison using its criteria and state that historical skill coverage is limited. An empty current diff provides evidence about current changes only. Run the pattern keeper again on the actual remediation diff after corrections.

Search related occurrences using the evidenced cause and affected contracts or patterns. Establish the bounded propagation scope and separate confirmed matches from superficially similar code.

## Propose remediation

Present the finding, evidenced cause chain, affected occurrences, and the smallest correction that addresses the supported cause. Name proposed or changed objects, responsibilities, layers, exact paths, protected files, and verification.

Use `task-decomposer` on the identified commit/range or resulting correction changes to separate independent concerns. Distinguish a proposed task split from a completed change-set audit.

Use `violation` for an uncollected developer-confirmed finding, following its recording permissions and duplicate checks. Recording and investigation remain separate activities.

Request approval for the exact remediation scope before source changes. Preserve existing commits and implement approved corrections as forward changes; history rewriting is a separate decision. Route proposed instruction or pattern improvements to developer-invoked `maintain-ai-harness`.

## Verify the approved correction

After authorized implementation, run `context-checker` for the correction task and `finalize-job` on its resulting changes. Finalization coordinates naming, declarative rules, responsibility leakage, patterns, decomposition, violation capture, and `update-diagnostic-spec` in audit mode for affected features.

Use `update-by-layer` to explain corrected objects and files. Report the original finding, remaining occurrences, cause addressed, verification evidence, commit state, and unresolved limitations. Distinguish a verified correction from a claim that all project violations have been eliminated.

## Result

Return a concise cause chain with source evidence, historical versus current-rule findings, related-occurrence scope, skill results and limitations, and the next approval or verification step.

Conclude with `INVESTIGATION COMPLETE — APPROVAL REQUIRED`, `CORRECTION VERIFIED`, or `UNVERIFIED`, according to the supported stage. A verified correction also states whether finalization passed and whether the correction is committed.
