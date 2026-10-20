# AI Agents Guide (`AGENTS.md`)

## Folder

`/lib/features/feature_name/domain`

## SRP

Contains this feature's Domain declarations, structures, and pure rules. Repository and use-case contracts live in their matching Domain folders. Validators include pure, stateless operations and pure abstract validation bases; Formatters remain concrete, stateless Domain operations.

## Allowed Direct Children

- `entities`
- `formatters`
- `models`
- `params`
- `repositories`
- `services`
- `shared`
- `use_cases`
- `validators`

## Allowed Files

- none

## Naming

- Folders: `snake_case`

## Public Entrypoints

- entrypoints declared by child-folder rules

## Forbidden

- concrete repository implementations
- concrete use-case implementations
- DTOs
- framework code
- Data, Infrastructure, or Presentation dependencies
