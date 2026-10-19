# AI Agents Guide (`AGENTS.md`)

## Folder

`/lib/core`

## SRP

Core inherits its scope, layers, responsibilities, and general dependency directions from `/ai_development/declarative_foldering_rules.md`. Feature-private visibility from the feature blueprint does not restrict Core Domain consumers.

`core_di.dart` coordinates Core registrations only. App composes this entrypoint through `/lib/app/di/core_di.dart`; the coordinator does not register features or implement routing or authentication policy.

Managers coordinate features through public `domain/shared` contracts. Their consumers are App wiring, Core Flows, and feature Presentation Controllers, subject to both dependency directions. This is a Manager-specific boundary, not a restriction on Core Domain.

## Allowed Files

- `core_di.dart`

## Naming

- Managers: `<Name>Manager` in `<name>_manager.dart`

## Forbidden

- Manager dependencies on App wiring, feature implementations, Data, Infrastructure, or Presentation
- Domain, Data, Infrastructure, screen, sheet, or widget consumers of Managers, including through exports
