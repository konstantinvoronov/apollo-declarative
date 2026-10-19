# AI Agents Guide (`AGENTS.md`)

## Folder

`/lib/features`

## SRP

Contains feature-specific functionality as independent, isolated features. Cross-feature communication and coordination is performed by `/lib/core/managers`.

## Allowed Direct Children

- `<feature_name>`

## Allowed Files

- none

## Naming

- Folders: `snake_case`
- Each folder name describes one app feature.

## Blueprint Required

- yes: use `/lib/features/feature_name` according to the blueprint definition in `/lib/AGENTS.md`

## Public Entrypoints

- entrypoints explicitly allowed by the feature blueprint

## Forbidden

- direct imports from sibling features
- cross-feature repository access
