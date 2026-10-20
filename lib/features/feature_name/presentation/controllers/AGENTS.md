# AI Agents Guide (`AGENTS.md`)

## Folder

`/lib/features/feature_name/presentation/controllers`

## SRP

Contains one Controller, Cubit, or Bloc for each screen and its companion State declarations. Controllers are the entrypoint for that screen's UI logic.

## Allowed Direct Children

- none

## Allowed Files

- `*_controller.dart`
- `*_cubit.dart`
- `*_bloc.dart`
- `*_state.dart`

## Naming

- Files: `<screen_name>_controller.dart`, `<screen_name>_cubit.dart`, or `<screen_name>_bloc.dart`
- Classes: `<ScreenName>Controller`, `<ScreenName>Cubit`, or `<ScreenName>Bloc`
- State files: `<screen_name>_state.dart`
- State classes: `<ScreenName>State`

## Blueprint Required

- no

## Public Entrypoints

- none

## Forbidden

- none beyond cumulative rules and the allow-lists above
