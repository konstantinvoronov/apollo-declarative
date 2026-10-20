# AI Agents Guide (`AGENTS.md`)

## Folder

`/lib/libs`

## SRP

Contains protected, reusable multi-project source. Library ownership does not replace architectural scope, layer, responsibility, or dependency boundaries. Apply the general architectural rules in `/lib/AGENTS.md`; do not repeat them for each library.

## Shared Blueprints

A `shared` folder inside a library contains protected project-integration blueprints. These files are not production entrypoints and are not customized or used directly from `/lib/libs`. Copy a required blueprint to `/lib/shared/<library_name>/` and configure the project-local copy there.

Unchanged reusable source may be imported directly when its architectural layer permits it. Project-specific adaptations belong in Shared; copies or re-exports are not mandatory for unchanged source.

## Allowed Direct Children

- `<library_name>`

## Allowed Files

- none

## Naming

- Library folders: `snake_case`
- Descendants use the corresponding architectural scope, layer, and responsibility rules.

## Forbidden

- modifying protected source without explicit approval
- dependencies on feature implementations
- importing protected `shared` blueprints directly into production code
