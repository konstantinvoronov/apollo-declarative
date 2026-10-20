---
name: update-by-layer
description: Explain changes from the latest task, a specific prompt, or the available conversation, grouped by architectural layer and responsibility, with object names, file paths, and generated updates. Use when the developer asks what changed or requests an update by layer.
---

# Update by Layer

Give the developer a read-only explanation of what changed and why, organized by architectural meaning.

## Establish the reporting scope

Use the developer's requested scope: latest prompt, latest completed change, entire available conversation, or a named Git change set. For an unspecified request, use the current job and state that scope briefly. Resolve materially ambiguous scope with one concise question.

Combine the conversation's requests, decisions, and implementation evidence with relevant Git status, diffs, commits, and untracked files. Separate this job's changes from earlier or unrelated work. State coverage limits where historical snapshots or conversation evidence are unavailable. A clean working tree can still contain completed changes in commits.

Distinguish proposals, implemented changes, and verification results. For conversation-wide reports, explain the current net result and identify material changes that were later reverted or superseded. For prompt-specific reports, attribute changes to that prompt using available evidence.

## Group by scope, layer, and responsibility

Use the active project's governing architecture and applicable AGENTS guides to identify ownership and scope, architectural layer, object role, and implementation kind. Use the project-local responsibility resolver when a classification requires clarification; carry unresolved declarations into the report explicitly.

Group actual changes under the relevant scopes and layers, then responsibilities: Services, Controllers and companion States, Infrastructure Repositories, Widgets, Domain Entities, Domain Models, Use Cases, and Domain contracts for their respective roles. Describe interfaces separately from concrete implementations. Place supporting Wrappers, Formatters, Validators, and Mappers in their owner's layer. Give App/DI wiring, dependencies, generated output, and AI development documentation their own relevant groups.

## Explain the changes

Use short scope/layer headings and simple object-first bullets. Begin each entry with the action, architectural role, and declared object name, for example: "Added Core Domain service contract — IAppBuildInfoService." Follow with a short responsibility explanation and place the file link last.

For each affected object or coherent file group, include:

- the action: added, updated, moved, renamed, removed, or reverted;
- the scope, architectural layer, role, and declared object name, when applicable;
- a brief explanation of the changed responsibility or behavior and its purpose;
- the exact file name and path, using clickable absolute links for existing local files;
- automatic or generated provenance when supported by tool or generator evidence.

Show old and new locations for moves and renames when recoverable. Mark uncertain attribution or generation provenance explicitly. Explain the primary architectural change before its supporting wiring and generated effects. Report observed verification separately from implementation.

Keep the report concise and include the groups relevant to the selected scope. Use a table when the developer explicitly requests tabular output. A reporting request authorizes inspection and explanation; implementation changes, rule updates, and Git mutations follow their respective developer approvals.
