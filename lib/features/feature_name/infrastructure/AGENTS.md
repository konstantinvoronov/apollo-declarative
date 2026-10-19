# AI Agents Guide (`AGENTS.md`)

## Folder

`/lib/features/feature_name/infrastructure`

## SRP

Contains concrete implementations of this feature's Domain contracts and integrates the feature's Data layer.

## Allowed Direct Children

- `data_sources`
- `extensions`
- `mixins`
- `repositories`
- `shared`
- `use_cases`

## Allowed Files

- `di.dart`: optional private helper that binds Data Source and Domain repository interfaces to their concrete Infrastructure implementations

## Naming

- Folders: `snake_case`
- Files and declarations follow the applicable child-folder rules.

## Public Entrypoints

- `shared/*`

## Forbidden

- none beyond cumulative rules and the allow-lists above
