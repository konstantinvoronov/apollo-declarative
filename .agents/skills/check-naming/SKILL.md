---
name: check-naming
description: Audit changed files and declarations against this repository's project-wide and folder-specific naming conventions, tracing each name to its real responsibility and consumers. Use for naming reviews and as a required guard during job finalization.
---

# Check Naming

Perform a read-only naming audit. Do not rename files, declarations, parameters, or callers unless the developer separately authorizes the correction.

## Establish the audit scope

Use the current job's changed files and declarations unless the caller names another scope. Identify renamed, added, and materially repurposed declarations. Include affected callers, tests, documentation, failure sources, exports, registration functions, and serialized or native names where consistency matters.

## Resolve naming rules and responsibilities

For every reviewed declaration, read the cumulative `AGENTS.md` files for its path. Use both the `Naming` and `SRP` sections: a syntactically correct suffix is still wrong when the declaration does not perform that responsibility.

Trace the declaration to its callers and determine:

- the business or architectural outcome it owns;
- its consumer;
- its lifecycle transition, when applicable;
- its input and output roles;
- its place in the feature or processing pipeline;
- the folder responsibility that permits it to exist there.

## Project-wide conventions

- Interfaces use the `I<Name><Role>` convention declared by their folder rules.
- Concrete implementations use the corresponding `<Name><Role>` name without an `I` prefix and without an `Impl` suffix.
- Repository names identify Domain repository contracts or their concrete Infrastructure implementations.
- Data Source names identify one isolated external service boundary.
- Controller, Cubit, and Bloc names identify the screen whose UI logic they own.
- Manager names identify app-wide coordination across two or more features.
- Flow names identify presentation navigation or interaction orchestration.
- Use Case names identify a business operation coordinating multiple repositories or repository operations.
- Validator names identify concrete, stateless validation operations or pure abstract validation bases whose primary operation or contract is `validate`.
- Formatter names identify concrete, stateless formatting operations whose primary operation is `format`.
- DTO names identify external transport or persistence shapes; Mapper names identify the source representation or conversion boundary.
- Params names identify the operation or destination receiving the values.
- Feature DI and routing names follow their exact blueprint names and registration-function conventions.

Treat suffixes such as `Manager`, `Repository`, `Service`, `Controller`, `Flow`, `UseCase`, `Validator`, `Formatter`, `DTO`, `Mapper`, and `Params` as responsibility claims, not decoration.

## Purpose-oriented names

Prefer names that state the result, consumer, domain outcome, or lifecycle transition. Require `initialize...` for an explicit lifecycle transition and `select...For...` for a policy or precedence decision. Use `<result>For<context>` where a value is prepared for a specific consumer.

Flag vague verbs such as `get`, `update`, `process`, `handle`, `do`, `manage`, `ensure`, and `prepare` when the actual domain outcome is known. Flag names that describe implementation mechanics while hiding the business or pipeline purpose.

## Consistency checks

Check that file, declaration, constructor, operation, caller, registration, test, documentation, export, and failure-source names describe the same responsibility. Flag a name when code has gained a different responsibility even if the spelling did not change.

When an applicable `AGENTS.md` naming rule conflicts with the project-wide conventions above, report the rule conflict separately rather than choosing one silently.

## Report

For each confirmed issue, provide:

- current name and exact path with one-based line;
- evidence-based responsibility;
- violated project or folder naming principle;
- proposed name;
- affected callers and compatibility surfaces.

Separate `CONFIRMED VIOLATION`, `RULE CONFLICT`, and `OPTIONAL IMPROVEMENT`. Finish with `PASS`, `FAIL`, or `BLOCKED`. Optional improvements alone do not fail the audit.
