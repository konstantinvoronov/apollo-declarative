---
name: context-checker
description: Independently audit task-specific context completeness, relevance, authority, and scoped-rule interpretation at any conversation stage. Distinguish missing or excessive context from unavailable loading evidence. Read-only; not harness maintenance or a code-correction skill.
---

# Context Checker

Check how context was assembled for the current task, not whether the whole repository is compliant. Work from the active project's local harness. Do not change code, instructions, skills, patterns, histories, or synchronization state.

## Establish the task independently

Identify the user's actual request, current stage, approved scope, target project, and affected architectural parts from available conversation and job evidence. Do not accept the implementing agent's selected files or conclusions as proof of the correct scope. Identify uncertainties that materially affect the check; do not invent missing requirements.

## Derive the necessary context

Use the project's instruction entrypoints and governing declarative document to find the applicable ancestor AGENTS guides, blueprint references, task specifications, and stage-appropriate skills or patterns. Follow cumulative inheritance: a local rule overrides only the identified requirement within its folder/subtree; other inherited rules remain active. A missing local guide inherits and does not require creating one.

Include relevant dependency-endpoint rules and referenced contracts when the task crosses a boundary. Include required source/example files when they establish the requested pattern, but distinguish implementation evidence from authoritative instructions. Respect the project's progressive loading: do not require every pattern catalog at every stage or read all AGENTS files in the repository merely to check context.

## Compare required and observed context

Use available conversation, automatically supplied instructions, explicit read/tool evidence, and any recorded context inventory. Distinguish what was supplied, what was actually consulted, and what is only claimed. A missing explicit read call does not prove automatically supplied instructions were absent.

Keep your own verification reads separate from evidence of what the implementation agent had at the time of a decision. Reading a source now does not retroactively prove it was loaded earlier. If a file changed, distinguish its current content from the version available at that earlier point.

Check for missing relevant sources; stale or wrong-project authority; incomplete inheritance; incorrect override interpretation; treating examples as requirements; contradictions; and irrelevant or prematurely loaded context. Judge relevance at the stage when information was consulted, including legitimate investigation, rather than declaring everything outside the final diff excessive. An intentional scoped override is not a contradiction.

Do not claim direct access to hidden model context, retention, attention, or understanding. Absence of a complete loading trace is an evidence limitation, not a proven context failure. File availability alone is not proof that an agent followed it. Do not fabricate a context inventory, infer missing tool history, or invent a rule to make the audit conclusive.

Apply the local harness's evidence-to-claim discipline when comparing context evidence with the agent's conclusions. Distinguish existence, dependency compatibility, architectural permission, and runtime verification; flag claims that conflate them. Check that “not found” is supported by a search of the stated scope and that unchecked properties remain unknown. Separate observations from proposed actions; unresolved dependencies alone do not establish that existing code is absent or its behavior should be replaced. Report an evidenced conflation as an interpretation/reporting defect, not automatically as missing context.

## Report the minimum correction

Return the task/stage and scope; applicable sources and authority chain; observed loading evidence; and distinct findings for confirmed missing context, unnecessary context, interpretation conflicts, and unverified coverage. Cite the relevant source locations and supporting evidence. Keep the report task-focused rather than reproducing all instructions.

Recommend only the necessary additions, sources not to carry forward, or interpretations to correct. Do not claim to remove content from an already-existing conversation or perform the implementation corrections yourself. Do not modify harness definitions or populate pattern catalogs; those belong to separately authorized workflows.

Finish with `HEALTHY`, `CORRECTION NEEDED`, or `UNVERIFIED`. Use HEALTHY only for the supported scope; confirmed defects require correction, while missing loading evidence must remain explicitly unverified. The result is not a guarantee about an agent's internal understanding or application correctness.
