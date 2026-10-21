# AI Agents Guide (`AGENTS.md`)

## Folder

`/lib/core/flows`

## SRP

Contains app-level routing flows that coordinate ordered navigation across feature routes and transfer navigation state between steps.

Core Flows access App through its global `/lib/app/routing/app_router.dart` entrypoint. Apply this entrypoint restriction together with the directory dependency lists below.

## Allowed Direct Children

- none

## Allowed Files

- `*_flow.dart`
- `routing.dart`

## Naming

- Files: `<name>_flow.dart`
- Classes: `<Name>Flow`
- Routing entrypoint: `routing.dart`

## Blueprint Required

- no

## Public Entrypoints

- `routing.dart`: exposed only to `/lib/app/routing/app_router.dart`

## May Import From

- /lib/app/routing

## May Be Imported By

- /lib/app/routing

## Forbidden

- none beyond cumulative rules and the allow-lists above
