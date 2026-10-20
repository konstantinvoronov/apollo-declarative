# AI Agents Guide (`AGENTS.md`)

## Folder

`/lib/features/feature_name/presentation`

## SRP

Contains this feature's user interface and Presentation coordination.

## Allowed Direct Children

- `controllers`
- `models`
- `mixins`
- `sheets`
- `screens`
- `widgets`
- `flows`
- `shared`

## Allowed Files

- `di.dart`: optional private helper for Presentation registrations
- `routing.dart`
- `*_screen.dart`
- `*_sheet.dart`
- `*_widget.dart`

## Naming

- Files: `snake_case`
- Screens: `<name>_screen.dart`
- Sheets: `<name>_sheet.dart`
- Widgets: `<name>_widget.dart`

## Public Entrypoints

- `routing.dart`: feature-local routing wiring. It defines route-builder functions that global App routing imports and explicitly calls. It imports this feature's screens, sheets, and route parameters internally.
- `shared/*`

- `di.dart`: private Presentation registration helper, consumed only by this feature's root `di.dart`

Same-feature flow access remains internal. Cross-feature access is through `shared/*` only, from other features' Presentation layers. App consumes only the feature's `routing.dart`; other Presentation implementations are not App entrypoints.

## May Be Imported By

- /lib/features/feature_name
- /lib/app/routing
- /lib/features/feature_name/presentation/flows
- /lib/features/*

## Forbidden

- none beyond cumulative rules and the allow-lists above
