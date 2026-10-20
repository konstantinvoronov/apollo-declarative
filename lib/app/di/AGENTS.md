# AI Agents Guide (`AGENTS.md`)

## Folder

`/lib/app/di`

## SRP

Contains registration composition helpers invoked by `/lib/app/di.dart`. `features_di.dart` calls only public feature DI entrypoints; `core_di.dart` calls only the public Core DI coordinator. The container is passed to helpers; they do not own or import the global container.

`features_di.dart` imports only feature-root `di.dart` entrypoints and calls `register<FeatureName>Feature`. `core_di.dart` imports only `/lib/core/core_di.dart` and calls `registerCore`. SDK and GetIt wiring follow the existing root DI declaration; no additional external-package permission is introduced.

`presentation_di.dart` registers the app-wide AppSnackBar from its Shared Presentation adaptation using the global navigator key in App configuration. It imports those two wiring dependencies and receives the container as an argument; it does not own the container or implement notification behavior.

`routing_di.dart` imports the AppRouter entrypoint to register the application router and its disposal callback after feature registration. It receives the container as an argument; route composition stays in App routing rather than this helper.

## Allowed Direct Children

- none

## Allowed Files

- `features_di.dart`
- `core_di.dart`
- `presentation_di.dart`
- `routing_di.dart`

## Naming

- Files: the exact filenames listed above
- Feature helper: `registerFeatures`
- Core helper: `registerCoreDependencies`
- Presentation helper: `registerPresentationDependencies`
- Routing helper: `registerRoutingDependencies`

## Blueprint Required

- no

## Public Entrypoints

- `features_di.dart`: `registerFeatures`
- `core_di.dart`: `registerCoreDependencies`
- `presentation_di.dart`: `registerPresentationDependencies`
- `routing_di.dart`: `registerRoutingDependencies`

These helpers are private to `/lib/app/di.dart`. Other files in `/lib/app` are not consumers of these entrypoints.

## May Be Imported By

- /lib/app

## Forbidden

- importing the global container from `/lib/app/di.dart`
- direct imports from feature Domain, Data, Infrastructure, Presentation, or internal registration files
- constructing feature implementations or implementing business, navigation, or authentication policy
- registering feature dependencies through the Core helper
