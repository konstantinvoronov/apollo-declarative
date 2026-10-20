Apply `/ai_development/declarative_foldering_rules.md` first. This template defines the section schema for scoped AGENTS overrides, not a replacement copy of the default architecture. Include only approved differences or role details not already covered by the document.

A missing local guide or omitted section inherits the applicable blueprint and general rules; it is not an undeclared case by itself. A local guide records only the uncovered difference, using the template's applicable section names and order. Do not populate every section or enumerate ordinary consumers merely to make a guide complete. An explicitly present empty dependency list still denies all paths; it is not a substitute for an omitted, inherited section.

Dependency sections are foldering rules, not prose conditions. `May Import From` and `May Be Imported By` contain absolute repository-relative folder paths only, one per list item, optionally prefixed with `!` for exclusion. Do not put filenames, package names, entrypoint descriptions, or vague conditions in these lists. An empty list grants no paths.

- `/path/folder`: files directly in that folder only.
- `/path/folder/*`: that folder and all its descendants.
- `!/path/folder`: exclude files directly in that folder.
- `!/path/folder/*`: exclude that folder and all its descendants.

Unlisted paths are denied. Within the governing list, explicit exclusions win over matching inclusions. A separately declared, more-specific folder dependency rule governs its subtree instead of the broader rule, independently for each direction. Do not fall back to a broader permission for that subtree. An import or export requires permission from both the importing/exporting folder's outbound list and the target folder's inbound list. Public entrypoint and visibility restrictions still apply; a permitted folder is not permission to bypass them.

Keep responsibilities in `SRP`, entrypoint declarations in `Public Entrypoints`, and structural prohibitions in `Forbidden`. Dependency exclusions belong in the path lists.

Declare SDK imports and external packages separately in `External Dependencies`, using exact SDK import URIs such as `dart:convert` and exact package names such as `dartz`. List identifiers only, without prose conditions. An empty list permits no external dependencies. Package versions remain in the dependency manifest. Template examples do not grant permissions to production folders; existing guides require explicit review before conversion.

Existing dependency lists require explicit review before conversion to this syntax. Do not silently reinterpret a legacy path as direct-only or recursive, translate prose into permissions, or expand file-specific permissions to a whole folder. Report unresolved legacy cases for a rule decision.

## Folder
`/path/to/folder`

## SRP
One short paragraph.

## Allowed Direct Children
- `child_name`
- `child_name`
- none

## Allowed Files
- `special.dart`
- `*_pattern.dart`
- none

## Naming
- Folders: `snake_case`
- Files: `snake_case`
- Classes: `ExampleName`

## Blueprint Required
- yes: use `/path/to/blueprint`
or
- no

## Public Entrypoints
- `di.dart`
- `routing.dart`
- `shared/*`
- none

## May Import From
- /lib/shared/*
- !/lib/core/managers/*

## External Dependencies
- dart:convert
- dartz

## May Be Imported By
- /lib/app
- /lib/core/managers

## Forbidden
- business logic
- direct imports from sibling features
- custom subfolders not listed above

## Allowed Direct Children 
any - folder name is name of the feature

## Allowed Files

di.dart, routing.dart, *_screen.dart, *_repository.dart
