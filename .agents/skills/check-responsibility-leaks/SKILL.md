---
name: check-responsibility-leaks
description: Compare naming and folder declarations with actual responsibilities, outbound dependencies, inbound consumers, and implementation behavior across architectural boundaries. Use for declarative and behavioral leakage reviews and as a required guard during job finalization; never silently reconcile contradictory declarations.
---

# Check Responsibility Leaks

Perform a read-only behavioral responsibility audit. Do not move or rewrite code unless the developer separately authorizes a correction.

## Establish the audit scope

Use the current job's changed methods, declarations, and files unless the caller names another scope. Read their direct callers, importers, construction and registration points, and collaborators far enough to determine what the code actually does and who depends on it. Separate unrelated pre-existing behavior from responsibility introduced or changed by the current job.

## Resolve declared responsibilities

Load and run the project-local `resolve-declarative-responsibilities` skill for every reviewed object. Use its structured result as the designed responsibility profile. If it returns `CONFLICT` or `BLOCKED`, preserve that result and do not infer the missing profile from implementation behavior. Continue checking every dependency direction or responsibility that remains unambiguous.

The resolver uses cumulative `AGENTS.md` rules, foldering, and naming to identify intended scope, layer, implementation kind, object role, responsibilities, outbound dependencies, inbound consumers, entrypoints, and visibility. Treat that declaration as the comparison baseline, not proof that the implementation follows it.

Report the resolver's naming, implementation-kind, placement, scope, entrypoint, visibility, and rule violations before reporting implementation leakage. Do not silently repair a declaration conflict by assuming a corrected path or name. Actual behavior may show which responsibility the object performs, but it cannot make the original contradictory declarations compliant.

## Determine actual responsibilities

Inspect:

- method bodies and branches;
- owned mutable state and lifecycle;
- side effects and I/O;
- collaborators and service-locator access;
- accepted and returned representations;
- error creation and translation;
- navigation, rendering, and user-facing formatting;
- mapping and validation;
- orchestration across repositories, features, or layers;
- external SDK, framework, database, storage, and transport types that cross a boundary.

From this evidence, state the implementation's actual responsibilities independently of its declared name and folder. A method or object can have more than one actual responsibility.

Also inventory actual dependency relationships in both directions:

- outbound dependencies from imports, constructor parameters, fields, inheritance, mixins, service-locator access, calls, accepted and returned types, annotations, and generated or framework types;
- inbound consumers from importers, callers, constructors, DI registrations, exports, public entrypoints, and types that expose the object;
- the exact public, shared, DI, or routing entrypoint used for each boundary crossing.

## Detect responsibility leakage

Compare the independently determined actual responsibilities, dependencies, and consumers with the resolver's designed responsibility profile. Report behavior implemented outside its declared owner, including:

- an outbound dependency not permitted by `May Import From`;
- an inbound consumer not permitted by `May Be Imported By`;
- bypassing a required public or shared entrypoint even when the source and consumer layers are otherwise permitted;
- a concrete implementation, framework type, generated client type, or mutable mechanism crossing a boundary that permits only abstractions or Domain representations;
- UI state, navigation, rendering, localization, or display formatting in Domain, Data, or Infrastructure;
- business rules or business decisions in widgets, DTOs, mappers, Data Sources, DI, routing, or external-client adapters;
- external I/O, framework state, service access, or concrete integrations in Domain;
- concrete service integration or Domain repository implementation in Data;
- DTO-to-Domain mapping inside a Data Source instead of a Data mapper coordinated by an Infrastructure repository;
- API, database, storage, or client-specific types escaping their declared boundary;
- client-specific cancellation, transport, or persistence mechanisms leaking into Domain or Data contracts;
- screens or widgets calling repositories, Data Sources, DI containers, or external services instead of their designated Controller;
- Controllers directly owning external integration details or coordinating multiple features where a Core Manager is the declared owner;
- repositories owning Presentation behavior, navigation, or screen state;
- Core or Shared code containing feature-specific behavior outside the declared Manager, Flow, or adapter boundary;
- one object or method accumulating independent reasons to change that belong to different architectural responsibilities.

Also detect hidden leakage when a declaration has the correct folder and suffix but its method bodies perform work owned elsewhere.

Dependency permission does not prove responsibility alignment. An allowed dependency can still be used to perform work owned by another layer. Likewise, correct method behavior does not excuse a dependency or consumer that crosses a forbidden boundary.

## Avoid false positives

Do not flag ordinary value passing, error propagation, or dependency inversion merely because two layers participate. A higher layer may coordinate lower-layer contracts when its rules permit that responsibility. Project-owned abstractions may cross boundaries where the applicable rules explicitly allow them; concrete client mechanics may not.

Distinguish a confirmed leak from a design concern that requires more caller or runtime evidence.

## Report

For every finding, provide:

- exact path and one-based method or declaration line;
- resolved scope, layer, implementation kind, object role, and designed responsibility profile;
- actual responsibility evidenced by the implementation;
- offending outbound dependency or inbound consumer, including the entrypoint used or bypassed;
- the applicable `May Import From`, `May Be Imported By`, public-entrypoint, or shared-export rule;
- the layer or object that should own that responsibility;
- affected callers, returned types, state, or side effects;
- severity and whether the leak was introduced by the current job.

Separate `CONFIRMED LEAK`, `POSSIBLE LEAK`, and `NOT A LEAK`. Finish with `PASS`, `FAIL`, or `BLOCKED`. Possible leaks alone do not fail the audit without sufficient evidence.

When the resolver reports declaration violations, include a separate `DECLARATION VIOLATIONS` section before the leakage findings. Confirmed declaration violations fail the audit even when method behavior has not yet leaked across a boundary.
