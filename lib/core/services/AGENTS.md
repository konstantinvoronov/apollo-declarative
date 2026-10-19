# AI Agents Guide (`AGENTS.md`)

## Folder

`/lib/core/services`

## SRP

Contains concrete, app-wide Services that isolate external capabilities, including device, platform, and logging integrations. Services use the matching Domain Service interfaces. The same responsibility rules apply to library-scoped Core Services.

Project-facing Service exports live directly in this folder. Interface exports live in `/lib/core/domain/services`. Apply general layer dependencies in both directions; exports do not widen permissions.

## Allowed Files

- `*_service.dart`

## Naming

- Files: `<name>_service.dart`
- Classes: `<Name>Service`
- Matching Domain interfaces: `I<Name>Service`

## Public Entrypoints

- `*_service.dart`

## Forbidden

- application routing, UI-response policy, or feature-specific business coordination
- library-name folders used only to nest export wiring
