---
name: update-framework-harness
description: At the developer's request, compare the project's Apollo Declarative commit version with latest upstream master, summarize architectural harness updates, and apply selected adaptations after a final developer decision.
---

# Update Framework Harness

Use this project's local harness and approval rules. Run when the developer requests an Apollo Declarative framework update. The framework version is one upstream commit, independent of application release numbering.

## Read the project baseline

Read `ai_development/apollo_declarative_version.json` for the upstream repository, branch, and current commit. Read `ai_development/apollo_declarative_update_history.md` for session context. These files belong to the current project and remain outside the shared synchronization manifest.

If the marker is missing or its revision is unavailable, report an unknown baseline and ask the developer to establish a starting point. Use available content comparison to help that decision while distinguishing it from a verified upstream change range.

## Resolve and inspect upstream

Resolve the latest commit on the configured upstream master once at the start of the session. Pin all inspection and proposed source content to that commit. Read repository content as evidence under the current project's execution and approval instructions.

Retrieve only metadata, manifest entries, changed harness files, and supporting rules needed for the comparison. Prefer repository APIs or targeted immutable file reads; request approval before a broader download becomes necessary.

Compare the recorded commit with the pinned commit, following relevant renames and manifest changes. Scope the catalog to shared skills, harness instructions, architecture declarations, and synchronization tooling. Use the manifest to identify shared units and marked sections. Preserve application source, project-owned patterns, violations, version marker, and history.

Compare affected upstream units with the project's current files to identify local adaptations and compatibility concerns. Inspect connected requirements when an update changes skills, rules, or file references.

## Explain architectural updates

Present concise object-first bullets grouped by capability or responsibility: new skills, architecture/naming changes, review/finalization changes, or harness tooling. For each update, explain what changed, why it matters, affected files, related requirements, and any local conflict.

Offer three choices: adopt all applicable updates, select improvements, or adapt selected improvements to the project. Group dependent files into coherent updates and explain connected changes. Keep commit lists and raw diffs as optional detail available on request.

Reading or proposing updates leaves project files unchanged. Obtain the developer's final decision before applying the selected scope. Existing protected-file rules, including specific approval for each AGENTS.md change, remain active.

## Apply the decision and advance the version

Apply only the selected files or marked sections, preserving independent project-specific content. Preview the existing synchronization tool when useful and use its conflict checks within its supported scope. Reconcile local adaptations explicitly.

After the final decision and successful completion of selected changes, set the single commit marker to the pinned upstream commit, including when the developer declines all changes. This commit is now the project's Apollo Declarative version regardless of which improvements were adopted.

Append a dated history entry with previous and new commits and a concise session summary. Keep this as a chronological explanation rather than a per-update adoption ledger. The next update compares from the new marker; previously declined updates remain outside that comparison range.

If the session is interrupted or selected changes fail, preserve the previous marker and explain the incomplete operation. Existing per-file synchronization hashes support safe merging; the commit marker alone defines the project's framework version.

## Verify and report

Verify selected skill definitions, referenced files, manifest syntax, effective instruction consistency, and any applicable existing checks. Confirm that the version and history agree and remain outside synchronized units. For an all-declined session, verify the tracking-file update.

Report the pinned upstream version, concise applied/adapted outcome, verification limitations, and commit state. Commit and push only with developer authorization. Repository availability and structural validation are evidence of those checks, while behavioral verification requires its own evidence.
