# AI Agents Guide (`AGENTS.md`)

## Folder

`/lib/core/flows`

## SRP

Contains app-level routing flows that coordinate ordered navigation across feature routes and transfer navigation state between steps.

The only App import target is its global `routing.dart` entrypoint. Directory dependency lists below are bounds only; they do not permit importing other App files.

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

- `routing.dart`: exposed only to the global App `routing.dart`; other App files may not import this entrypoint

## May Import From

- /lib/app

## May Be Imported By

- /lib/app

## Forbidden

- none beyond cumulative rules and the allow-lists above
