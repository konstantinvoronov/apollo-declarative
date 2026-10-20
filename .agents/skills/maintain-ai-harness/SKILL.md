---
name: maintain-ai-harness
description: When the developer explicitly requests harness maintenance, review AI instruction consistency and context loading, then help process recorded violations into approved scoped patterns. Do not run as ordinary job finalization.
---

# Maintain AI Harness

Run only when the developer requests maintenance. Use the active project's local skills and `ai_development/ai_harness.md`. This skill has two responsibilities: review harness effectiveness/consistency, and help the developer process collected violations. It does not implement application code.

## Review the harness

Inventory entrypoint instructions, governing architecture documents, applicable AGENTS guides, skills, scoped pattern catalogs, and their discovery links. Trace how an agent actually obtains context rather than assuming every document is loaded. Check missing references, stale paths, circular/duplicated instructions, excessive eager loading, authority ambiguity, and requirements that encourage unsupported guessing or incidental complexity.

Resolve cumulative scope before calling differences contradictions. Local overrides affect only their folder/subtree and specific rules; unrelated inherited rules remain active. Compare the declared workflow with violation evidence and the available conversation. Distinguish implementation noncompliance from missing, ambiguous, contradictory, or undiscoverable guidance. Do not claim a causal explanation without evidence or promise that instructions can eliminate hallucinations.

Present findings and precise proposed harness changes. Do not rewrite instructions to excuse faulty implementation or impose new policies beyond the developer's approved scope.

## Process the violation collection

Read `ai_development/violations_unsorted.md` and any explicitly declared legacy history. Do not create a competing history. Group only records relevant to a candidate decision; preserve their evidence and distinguish unresolved entries from confirmed good patterns. A recorded mistake is not automatically a universal rule.

Help the developer choose whether a violation describes a reusable pattern, its use/non-use conditions, and the proper project-wide or folder-wide scope. Check existing catalogs for duplicates, deliberate overrides, and contradictions. Propose the smallest complete entry with the reason and good/bad examples. If the intended correction or scope is not confirmed, leave it pending rather than inventing one.

After approval, update only the agreed catalog/harness files. Preserve the cause, original bad code, developer-confirmed good approach, and provenance in the destination pattern. Verify that the destination contains that evidence before removing the processed violation and its linked correction records. Keep a recoverable original and report the transfer. Never clear unrelated, undecided, or incompletely transferred records. This is the approved maintenance exception to append-only collection, not permission for the violation or keeper skill to rewrite history.

## Completion

Report findings, decisions, exact changes, evidence transfers, and pending issues. Do not alter application code, automatically run during normal finalization, silently synchronize projects, or commit changes. Common approved improvements can be synchronized separately; project patterns and violation history remain local.
