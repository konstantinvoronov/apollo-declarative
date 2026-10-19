# AI Agents Guide (`AGENTS.md`)

## Folder

`/lib/features/feature_name`

## SRP

Contains one feature's functionality using only the architectural folders needed under the governing document. The feature-root `di.dart` is the feature's single public DI entrypoint and composes every feature-local registration.

## Allowed Direct Children

- `ai_development`
- `data`
- `domain`
- `infrastructure`
- `presentation`
- `services`

## Allowed Files

- `di.dart`

## Naming

- Folders: `snake_case`
- DI file: `di.dart`
- DI registration function: `register<FeatureName>Feature`

## Public Entrypoints

- `di.dart`: the only public feature DI entrypoint; `/lib/app/di/features_di.dart` imports and explicitly calls its `register<FeatureName>Feature` function
- `presentation/routing.dart`: the public feature routing entrypoint used by global App routing
- `domain/shared/*`: selected Domain exports for permitted cross-feature consumers
- `infrastructure/shared/*`: selected Infrastructure exports for other features' Infrastructure layers
- `presentation/shared/*`: selected Presentation exports for permitted cross-feature consumers

## Forbidden

- additional files at the feature root
- direct imports of another feature's internal files
