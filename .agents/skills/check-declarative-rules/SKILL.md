---
name: check-declarative-rules
description: Audit code and documentation changes against every applicable declarative folder, blueprint, dependency, naming, entrypoint, protection, and approval rule in this repository. Use for architecture compliance reviews and as a required part of finalizing a job.
---

# Check Declarative Rules

Perform a read-only compliance audit. Do not modify files, repair findings, or infer approval that the developer did not provide.

## Determine the change scope

Use the target commit, commit range, staged changes, or working-tree changes named by the caller. When no target is named, audit the current job's changes using the conversation and Git evidence. Separate unrelated pre-existing changes and report uncertainty instead of assigning them to the current job.

## Verify approval independently from architecture

Follow the task-scope and approval gate in the target project's `ai_development/ai_harness.md`. Compare the actual task diff, including new/deleted files, package and generated effects, against the developer-approved exact files and intended changes. Valid placement, task-outcome approval, and successful analysis do not establish edit authorization. Separate pre-existing changes from this task.

Check that proposed new objects and affected responsibility/dependency boundaries had a recorded project-local responsibility resolution before implementation. A review performed now does not prove that the pre-edit check happened. Missing evidence is `BLOCKED`; a confirmed change beyond the approved scope is `FAIL`.

For `lib/main.dart`, require a separate developer decision naming the file and exact intended change. Its startup role and generic task approval do not unlock the frozen entrypoint. Report authorization and architectural compliance separately; neither substitutes for the other.

## Resolve the rules

For each changed file, read every applicable `AGENTS.md` from the repository scope down to the file's folder. Apply the rules cumulatively and honor narrower child rules only where the parent allows them.

Check:

- folder responsibility and placement;
- allowed children, files, and naming;
- blueprint completeness and matching `AGENTS.md` files;
- layer dependency direction;
- both `May Import From` and `May Be Imported By` for each changed dependency;
- public, shared, DI, and routing entrypoints;
- read-only or protected locations;
- required developer approval before documentation changes;
- any explicit forbidden pattern in the applicable rules.

Inspect source imports and exports rather than relying only on folder names. A shared entrypoint permits only the consumer layers explicitly declared for that shared folder.

## Report

Return:

- `PASS` for each verified rule group;
- `FAIL` for each violation, with the changed path and one-based line plus the conflicting rule path and line;
- `BLOCKED` when the required diff, rule, or approval evidence is unavailable;
- `NOT APPLICABLE` where a rule group does not apply.

Finish with an overall declarative-compliance result. Do not record a violation through the `violation` skill unless the developer directly declares the concrete pattern a violation and gives the reason.
