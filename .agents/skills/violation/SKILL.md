---
name: violation
description: Collect unprocessed developer-declared code violations from the available conversation, on a specific declaration or during finalization. Preserve the cause, offending code, and confirmed intended good pattern in one project-local history; do not invent violations or edit pattern catalogs.
---

# Violation Memory

Preserve only code-pattern violations explicitly declared by the user. This is not a general feedback, review, or conversation-memory skill.

## Storage

Use the active project's Git root. Store records in:

`ai_development/violations_unsorted.md`

Create the file and its parent directories when the first record is captured. Keep it chronological and unsorted.

If the project already declares another violation-log path, use that path instead. Never create a second competing log.

When invoked during a conversation or finalization, review the available dialogue for declarations that satisfy the trigger below but have not yet been recorded. Compare user evidence, affected code, and reason with existing records before appending; do not duplicate a captured violation. Unavailable older conversation is a stated limitation, not evidence that all historical violations were captured. Do not bulk-record ordinary feedback or architecture reviews.

## Required trigger

Create a record only when all of these are present:

1. A concrete code pattern, source snippet, import, dependency, file placement, or structural coding pattern.
2. The user directly declares that pattern a violation.
3. The user gives the reason it is a violation.

Explicit invocation of `$violation` still requires the code pattern and the user's reason.

Do not record:

- agent-discovered or tool-discovered findings;
- architecture audit results the user has not directly declared violations;
- ordinary corrections, preferences, planning decisions, or discussion rules;
- mistakes in assistant wording or attribution;
- speculative violations;
- a declaration that lacks the user's reason.

If the user declares a code violation without giving the reason, do not create a partial record. Ask for the reason only when necessary to the active request; otherwise wait for the user to supply it.

## Evidence collection

For a valid violation, collect the smallest evidence that preserves the problem:

- every relevant user message verbatim and in conversation order;
- the affected file and one-based line when available;
- the exact problematic code snippet, import, folder placement, or abstract pattern;
- the user's direct reason verbatim.
- the developer-confirmed intended good pattern, if available, even when the code has not yet been fixed;
- an existing pattern reference when the developer identifies the violated pattern.

If the violation is described across several messages, label each quote `User message 1`, `User message 2`, and so on. Do not collapse them into an agent-written summary.

Read the code before it is changed. If it was already fixed, recover the old form from the current diff or the conversation when possible. Never recreate missing code from memory. Write `Not recoverable` when the original evidence is unavailable.

Never infer, complete, or improve the user's direct reason.

Exclude secrets, credentials, personal data, and unrelated conversation. Replace sensitive fragments with `[REDACTED]` and state that redaction occurred.

## Append-only record format

Append records at the end of the file. Do not sort, merge, renumber, rewrite, or delete prior records. The separate developer-invoked maintain-ai-harness skill may remove an approved processed violation and linked follow-ups only after verifying that their evidence has been transferred into the agreed scoped pattern. Collection itself never performs that transfer.

Use an ID shaped as `V-YYYYMMDD-HHMMSS`; add `-2`, `-3`, and so on if needed. Prefer the user's local timezone when it is available.

For a new violation append:

````markdown
## V-YYYYMMDD-HHMMSS — Violation

- Recorded: YYYY-MM-DD HH:MM timezone
- Location: path:line, or pattern scope
- Status: unresolved

### User declaration

> Exact user message declaring the code pattern a violation

### Violating code or pattern

```language
exact minimal evidence
```

### Direct violation reason from user

> Exact user wording

### Intended good pattern

Developer-confirmed description or representative good code. If not yet confirmed, state that it is undecided; do not invent a correction.

### Pattern reference

Developer-identified catalog entry when available; otherwise leave unresolved.
````

If evidence is a folder or conceptual pattern rather than source code, use a plain-text fenced block.

## Confirmed good pattern and fix evidence

Append a linked intended good pattern when the user directly identifies or confirms it for an existing violation. Distinguish a confirmed target from a verified implemented fix. Representative code or a description is sufficient when the user confirms the approach; never manufacture an exact replacement or treat an agent-proposed fix as learned guidance. Record fixed-code evidence separately when it actually exists.

````markdown
## V-YYYYMMDD-HHMMSS — Good pattern learned

- Recorded: YYYY-MM-DD HH:MM timezone
- For: V-original-id
- Fixed location: path:line or commit when implemented; otherwise pending

### User message

> Exact relevant user wording

### Good pattern confirmed by user

> Exact user wording

### Confirmed target or corrected code

```language
exact minimal corrected evidence
```
````

If several records are equally plausible, ask which violation the fix belongs to before writing.

## Completion behavior

After recording, state the record ID and log path. Continue the user's main task when one is active; recording a violation is not permission to fix or refactor the code.

Report new records, already-captured declarations, and undecided good patterns. Never update pattern catalogs, alter harness policy, or delete processed entries as part of collection.
