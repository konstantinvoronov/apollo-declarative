# AI Agents Guide (`AGENTS.md`)

## Folder

`/lib/features/feature_name/data`

## SRP

Defines external data contracts and their mapping boundary. Data owns DTOs, mappings between DTOs and Domain representations, and interfaces that isolate individual external data services. It contains no concrete service integrations and does not implement Domain repositories.

## Allowed Direct Children

- `dtos`
- `mappers`
- `data_sources`

## Allowed Files

- none

## Naming

- Folders: `snake_case`
- Files and declarations follow the rules in the applicable child folder.

## Public Entrypoints

- none
