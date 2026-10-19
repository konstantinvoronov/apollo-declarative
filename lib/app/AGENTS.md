# AI Agents Guide (`AGENTS.md`)

This file defines how agents MUST work with this folder and its subfolder or other folders with this name in the project.

## Layer

/app — Wiring & Configuration Layer

## 1. Foldering structure and architecture limits and requirements and dependenscy

Only one folder for the project

## 2. Reponsobilities for this folder

App initialization / Dependency Injection (DI) / Routing / Session/bootstrap logic

`/lib/app/di.dart` owns the GetIt container and DI startup sequence. Its project imports are restricted to `/lib/app/di`, whose helpers compose public feature and Core DI entrypoints.

## Public Entrypoints

- Project imports use permitted DI, routing, and Domain entrypoints; the global DI and helper restrictions below remain narrower.
- App initialization and routing may import permitted library Service entrypoints directly or use existing project-facing Service entrypoints under `/lib/core/services`, subject to the applicable layer and dependency rules.
- `/lib/app/di.dart` is narrower: it may import only Dart SDK, `get_it`, and files declared by `/lib/app/di/AGENTS.md`.
- `/lib/app/di` is an allowed direct child for registration composition. Its files follow the narrower helper rules.
- Feature DI entrypoints may be imported only by `/lib/app/di/features_di.dart`; other App files use the global DI entrypoint.
- Startup is exposed to `/lib/main.dart`, not arbitrary files in `/lib`. Other App files may consume App entrypoints internally. Shared configuration/adaptation consumers remain permitted. Core Flows consume only the global routing entrypoint, not other App files.
## May Be Imported By

- /lib
- /lib/app/*
- /lib/shared/*
- /lib/core/flows

## Forbidden

- business implementations outside initialization, DI, routing, session bootstrap, localization, initial shell, and bootstrap wiring
