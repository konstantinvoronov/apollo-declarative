# AI Agents Guide (`AGENTS.md`)

## Folder

`/lib/shared`

## SRP

Contains project-specific adaptations and extensions of reusable code from `/lib/libs`. Each adaptation preserves its architectural scope, layer, and responsibility path and follows the corresponding general rules. Core exports and app-wide coordination belong in Core, not in a separate Shared-only Manager or Repository hierarchy.

## Allowed Direct Children

- `assets`
- `core`
- `extensions`
- `mixins`
- `models`
- `presentation`
- `widgets`

## Allowed Files

- none

## Naming

- Folders and files: `snake_case`
- Adaptations retain the corresponding architectural role naming.

## Public Entrypoints

- adaptation entrypoints permitted by the corresponding general layer rules

## Forbidden

- modifying or duplicating the original protected library implementation without approval
- unrelated code that is not a project-specific adaptation
- using an adaptation or export to bypass architectural layer or consumer restrictions
