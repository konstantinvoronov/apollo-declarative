---
name: update-diagnostic-spec
description: Audit or update an affected feature's diagnostic log specification against project logging patterns, implemented behavior, and relevant edge cases without growing runtime code solely for logging. Use during feature diagnostics work and as a required read-only check during job finalization.
---

# Update Diagnostic Spec

Keep feature diagnostics useful without expanding production behavior merely to make an edge case observable.

## Choose the mode

- `audit`: read-only. Use this mode when called by `finalize-job` or when the user asks what diagnostic work is missing.
- `update`: use only when the user explicitly asks to update the feature's diagnostic specification. Present the exact proposed Markdown changes and receive the developer's approval before writing them, as required by the project rules.

Neither mode authorizes new runtime implementation solely for logging.

## Establish the feature scope

Identify the affected feature and current-job behavior from the conversation and Git evidence. Read every applicable `AGENTS.md`, the feature specification, the feature's `<feature_name>_logs_test_spec.md`, the changed code, and the project's existing logging facilities and patterns.

## Assess diagnostic coverage

For every changed behavior and relevant corner case, determine:

- the expected state transition or outcome;
- whether existing project-approved logging makes it observable;
- the exact existing event, field, or sequence that proves the outcome;
- the failure evidence an AI agent should search for;
- whether the diagnostic specification accurately describes that evidence.

Do not require a log for an edge case that is already reliably distinguishable through an existing state or event. Do not add redundant logs.

## Hard-to-diagnose edge cases

When an edge case is not observable and making it observable would require code added only for logging:

1. Skip the instrumentation.
2. Do not add branches, handlers, state, fields, wrappers, functions, exceptions, or runtime calls solely to emit diagnostics.
3. In `update` mode, add a concise comment at the closest existing code location stating that the edge case is hard to diagnose and is intentionally left without extra instrumentation because diagnosing it would require code solely for logging.
4. Record the same diagnostic limitation in `<feature_name>_logs_test_spec.md`, including what cannot be concluded from logs.

The comment may explain only this diagnostic limitation. It must not change runtime behavior or introduce a speculative implementation plan.

## Update the diagnostic specification

In `update` mode, keep the specification aligned with actual evidence. Include:

- expected events and sequences already emitted by the feature;
- relevant corner cases and the observable evidence for each;
- failure evidence;
- the ordered AI verification procedure;
- explicitly documented hard-to-diagnose limitations.

Do not claim coverage that the implementation does not provide. Do not change production source except for the permitted diagnostic-limitation comment.

## Report

Return one result for each changed behavior or edge case:

- `COVERED`: existing logs and specification are aligned;
- `SPEC UPDATE REQUIRED`: existing evidence is sufficient but the specification is stale;
- `DIAGNOSTIC LIMITATION`: added runtime instrumentation would be required, so the edge case remains intentionally uninstrumented and must be documented;
- `BLOCKED`: required code, rules, or log evidence is unavailable.

In audit mode, make no edits. In update mode, list the approved files changed and confirm that no runtime behavior was added for logging.
