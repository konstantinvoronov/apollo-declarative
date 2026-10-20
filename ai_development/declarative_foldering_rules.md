# Declarative Foldering Rules

## Authority

This document defines the default foldering architecture: ownership, scope, layers, responsibilities, and dependency directions. Apply it before interpreting project or local `AGENTS.md` declarations.

`AGENTS.md` is the scoped override mechanism, not a second copy of the architecture. Explicitly declared and approved differences replace the corresponding defaults within that guide's scope. Omitted fields inherit; a missing guide inherits and does not require creating another file. Preserve unrelated inherited rules.

Architectural-rule changes still require approval. A conflicting historical declaration is not automatically an intentional override: report it rather than silently choosing whichever rule permits the current code.

## 1. Project Levels and Ownership

```text
app                         composition, configuration, and startup
 ├── core                   app-wide foundation
 └── features/<feature>      individual functionality
       └── may depend on core through permitted layers
```

This is a responsibility/scope relationship, not a proposal to nest Core or features physically inside App.

`app` constructs and connects application parts. `core` is the app-wide root scope. Each feature has its own scope. Core is not a library-name container, and it does not give every feature unrestricted access to its implementations.

`libs` and `shared` are not additional levels above or below these scopes:

```text
libs/<library>/<architectural path>    reusable ownership
shared/<architectural path>            project adaptation
```

Library names establish ownership, not a new architecture. The architectural path inside the library retains its scope, layer, responsibility, and dependency rules. App-wide scope becomes library-wide scope inside a reusable library.

Shared adaptations preserve the architectural meaning of the path being adapted. Unchanged library source needs neither a Shared copy nor a mandatory project re-export.

Libraries may depend on each other and on project App or Core when the participating architectural paths permit it in both directions. Library ownership does not itself prohibit these dependencies or grant blanket access: scope, layer, responsibility, and public-entrypoint rules still apply. Library Domain may consume permitted Core Domain declarations, not App wiring. Library Presentation may consume App routing and DI through permitted entrypoints. A library that consumes project App or Core is project-coupled; that is an accepted dependency, not automatically an architectural violation.

## 2. Layers and Responsibilities Within a Scope

```text
<scope>/
├── domain/
│   ├── entities/
│   ├── models/
│   ├── params/
│   ├── repositories/       repository interfaces
│   ├── use_cases/          use-case interfaces
│   ├── services/           service interfaces
│   └── validators/         pure validation operations and abstract bases
├── data/
│   ├── dtos/
│   ├── mappers/
│   └── data_sources/       data-source interfaces
├── services/               concrete capability integrations
├── infrastructure/
│   ├── data_sources/       concrete data integrations
│   ├── repositories/       repository implementations
│   └── use_cases/          use-case implementations
└── presentation/
    ├── controllers/        Controllers, Cubits/Blocs, and companion States
    ├── models/             Presentation values
    ├── mixins/             UI interaction support
    ├── sheets/
    ├── screens/            pages
    └── widgets/
```

Pure Domain Validators and Formatters retain their role definitions. Supporting responsibilities follow their owner's layer as defined below; the tree is not an instruction to delete or relocate them.

Create only the folders needed by the responsibility being implemented. This structure does not require artificial Domain/Data layers or empty folders for a minimal screen.

| Folder | Default responsibility |
|---|---|
| `domain` | Pure contracts, values, and Domain rules; no dependency on implementation or UI layers |
| `domain/entities` | Domain concepts with identity |
| `domain/models` | Domain value structures and models |
| `domain/params` | Typed inputs for Domain operations |
| `domain/repositories` | Repository interfaces, not persistence implementations |
| `domain/use_cases` | Use-case interfaces |
| `domain/services` | Service interfaces, not concrete integrations |
| `domain/validators` | Pure, stateless validation operations and pure abstract Validator bases |
| `data/dtos` | External data representations |
| `data/mappers` | Representation conversion between DTOs and Domain values |
| `data/data_sources` | Data-source interfaces |
| `services` | Concrete capability integrations, alongside Data rather than inside Domain |
| `infrastructure/data_sources` | Concrete external data integrations |
| `infrastructure/repositories` | Implementations of Domain repository contracts |
| `infrastructure/use_cases` | Implementations of Domain use-case contracts |
| `presentation/controllers` | Per-screen UI logic and companion State declarations |
| `presentation/models` | Presentation values and representations, including theme and sizing values |
| `presentation/mixins` | Reusable Presentation interaction behavior |
| `presentation/screens`, `presentation/sheets`, `presentation/widgets` | UI rendering and interaction through the designated Controller |

Controller, Cubit, and Bloc state companions may live alongside their owner in `presentation/controllers` as `<screen_name>_state.dart`, named `<ScreenName>State`. These are Presentation declarations, not Domain models.

Pure abstract Validator bases may define the `validate` contract in `domain/validators`; concrete Validators implement pure validation operations. Neither kind owns mutable state, I/O, or service access. Presentation models and mixins follow their owning Presentation scope and layer. These additions do not change dependency directions, public entrypoints, consumer visibility, or external-package permissions.

Interfaces belong under their architectural responsibility, not in a generic `interfaces` collection. A Repository contract and Repository implementation have the same role but different layers and implementation kinds.

Core additionally contains `managers` for app-wide business coordination and `flows` for navigation coordination. Cross-feature coordination uses deliberately public feature contracts, not feature implementation internals.

Names and files identify their architectural roles according to the applicable responsibility definitions. Do not invent role suffixes for value declarations. A capability name such as logging or telemetry does not create another architectural layer.

### Supporting Responsibilities and Owner-Based Naming

Wrappers, Formatters, Validators, and Mappers are responsibilities, not architectural layers. They live in the same layer as the object or code they serve. Their responsibility folders (`wrappers`, `formatters`, `validators`, and `mappers`) belong within that owning layer; the usual placements shown above are not exclusive layer assignments for these roles.

| Responsibility | Purpose |
|---|---|
| Wrapper | A simple tool that extends and unifies common code patterns |
| Formatter | A pure, stateless operation producing a text representation |
| Validator | A pure, stateless operation checking values against rules |
| Mapper | Representation conversion without data retrieval or business decisions |

These helpers retain their owner's scope and layer dependency boundaries in both directions. A responsibility folder does not grant additional imports, exports, or consumers.

Names identify the owner and the supporting responsibility. A Wrapper retains the owner's architectural role before the `Wrapper` suffix: `<Name><OwnerRole>Wrapper` in `<name>_<owner_role>_wrapper.dart`. For example, `SomeNameRepositoryWrapper` in `some_name_repository_wrapper.dart` belongs to its Repository's layer; a wrapper serving an Infrastructure Repository stays in Infrastructure. Use the corresponding `Formatter`, `Validator`, or `Mapper` suffix for those responsibilities.

## 3. Layer Dependency Directions

Here `→` means “may depend on,” subject to scope, role, entrypoint, and both dependency directions. This lists cross-layer relationships, not unrestricted permission to consume every object in a target layer.

```text
Data           → Domain entities/models
Services       → Domain service contracts
Infrastructure → Domain + Data + Services
Controllers    → Domain contracts / Managers
Screens/Sheets → designated Controller
```

Domain does not depend outward on Data, concrete Services, Infrastructure, Presentation, Managers, Flows, or App wiring. App composition may reference implementations to construct and connect them; composition is not permission to put business implementations into App.

Repositories consume collaborators through their permitted contracts, rather than depending on another repository's concrete implementation. Responsibilities and scope still constrain same-layer dependencies.

## 4. Scope Dependency Directions

Scope and layer are independent checks. Being in the same layer does not by itself grant cross-scope access.

```text
Feature Domain → Core Domain       allowed
Core Domain    → Feature Domain    forbidden
```

Feature Domain may use Core Domain contracts and values. Core Domain may use its own Domain declarations and permitted reusable-library Domain declarations, not feature declarations or non-Domain implementations.

Across ordinary features, use the public entrypoints allowed for the consuming layer. Feature `domain/shared` exposes selected Domain declarations; it does not expose the whole feature. Core Managers are the designated cross-feature business-coordination boundary.

A path is interpreted as a combination:

```text
ownership → scope → layer → responsibility
```

For example:

| Path | Meaning |
|---|---|
| `lib/core/domain/repositories` | Project-owned, app-wide repository contracts |
| `lib/core/infrastructure/repositories` | Project-owned, app-wide repository implementations |
| `lib/libs/app_settings/core/domain/repositories` | Reusable, library-owned Core repository contracts |

## 5. Imports, Exports, and Entrypoints

An import or export requires all of the following:

1. The importing/exporting folder permits the outbound dependency.
2. The target folder permits the inbound consumer.
3. Both architectural layer and scope permit the relationship.
4. Public-entrypoint and responsibility restrictions are satisfied.

Exports expose existing declarations; they do not change ownership, layer, or dependency permissions. Domain exports expose Domain declarations, not Infrastructure implementations.

Project-facing Core exports use matching layer/responsibility folders without another library-name folder. Features may import permitted library entrypoints directly; Core exports are added when project integration needs them, not as mandatory aliases for every library file.

A library's protected `shared` blueprints are not production entrypoints. Copy a required blueprint into project Shared before configuring it. This is distinct from importing unchanged reusable source directly.

## 6. AGENTS.md Scoped Overrides

Resolve the document defaults first, then applicable root and ancestor `AGENTS.md` declarations, including any explicitly approved local differences. A guide governs only its declared scope.

- Do not repeat ordinary inherited structure or consumers merely to complete a guide.
- State only uncovered requirements, deliberate restrictions, or approved replacements.
- A replacement affects only the declared field and scope; other defaults remain active.
- Resolve outbound and inbound dependency declarations independently.
- A more-specific dependency list replaces the broader list for its governed subtree and direction. Do not merge the replaced list back in.
- An explicitly empty dependency list permits no paths. An omitted list inherits.
- Preserve existing blueprint guides; do not create an `AGENTS.md` for every folder or object.
- If no applicable default or approved override resolves a case, report it for a rule decision rather than inventing permission.

Dependency sections are foldering rules. `May Import From` and `May Be Imported By` contain absolute repository-relative folder paths, not prose conditions, filenames, or package names:

| Entry | Meaning |
|---|---|
| `/path/folder` | Direct files only |
| `/path/folder/*` | Folder and all descendants |
| `!/path/folder` | Exclude direct files |
| `!/path/folder/*` | Exclude the subtree |

Within the governing list, exclusions win; unlisted paths are denied. Keep responsibility in `SRP`, public exposure in `Public Entrypoints`, and SDK/package identifiers in `External Dependencies`. Package versions belong in the manifest.

Legacy dependency prose must be reviewed explicitly before conversion. Do not silently interpret a legacy path as recursive, broaden a file exception to a whole folder, or turn an old contradiction into an approved override.

## 7. Existing Declarations and Source

This document is an architecture contract, not authorization to move or rewrite source. Existing code and guides must be reviewed against it; valid placement alone does not prove valid dependencies or behavior.

Contradictory legacy rules, including a blanket prohibition on Feature Domain consuming Core Domain, must be identified and reconciled rather than copied as general defaults. Do not add extra guides to reproduce a missing or conflicting general rule.

## 8. Image Asset Formats

Prefer SVG for suitable vector artwork such as icons and simple illustrations. Prefer WebP instead of PNG or JPEG for raster images wherever the consuming platform and tooling support it. Use PNG or JPEG when a required consumer cannot use SVG/WebP, including native asset pipelines where their required format must be preserved.

## 9. Scoped Implementation Patterns

Follow the catalog discovery, cumulative subtree overrides, and finalization/maintenance separation in [AI Harness](ai_harness.md). The project-wide catalog is /ai_development/patterns.md. Optional patterns.md coding contracts may live in any folder alongside source; their presence does not require an AGENTS.md or override unrelated inherited rules. No catalog is required for every folder. These files do not change architectural layer or dependency boundaries.
