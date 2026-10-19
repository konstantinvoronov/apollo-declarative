# Apollo Project Implementation Plan

## Purpose

Build Apollo as a working demonstration of `ai_declarative_foldering_architecture` and as a reusable Flutter scaffold for future applications.

Apollo will accumulate concrete, working examples of the architecture, base classes, reusable libraries, application wiring, and development practices. reference application and other projects connected later are sources of proven examples. They are not copied wholesale and are not architectural authorities.

## Confirmed Principles

### Repository roles

- `ai_declarative_foldering_architecture` defines the public AI-assisted development approach, declarative foldering rules, responsibilities, and skills.
- `apollo1` demonstrates that approach through a runnable application with concrete modules and examples.
- reference application and future connected projects provide candidate implementations and practical experience.

### Uniform architectural-part migration process

Work top-down by complete architectural part rather than beginning with isolated side files.

For every architectural part:

1. Select one complete architectural part.
2. Inventory every file in that part.
3. For each file:
   - propose its Apollo path;
   - run `resolve-declarative-responsibilities`;
   - determine its declared scope, role, layer, and implementation kind;
   - check `May Import From`;
   - check `May Be Imported By`;
   - check required import/export entrypoints;
   - compare the declared responsibility with the actual implementation behavior.
4. Decide whether the whole part logically belongs at the current point in the migration.
5. Present the complete source-to-destination list.
6. Request approval to copy the complete part.
7. Copy every approved file unchanged.
8. Review the copied part as a connected system.
9. Propose required changes individually.
10. Apply only explicitly approved changes.
11. Verify the approved result and record progress.

Do not select the next architectural part until the current part has been reviewed and its next actions have been explicitly decided.

### Copy before modification

Source files are copied before they are refactored.

For every copy operation:

1. Inspect the source without modifying it.
2. Propose the exact source and destination paths.
3. Request explicit approval for the copy operation.
4. Copy the approved files without changing their contents.
5. Review the copied files against Apollo's architecture and folder responsibilities.
6. Discuss every proposed modification.
7. Request explicit approval for every modification.
8. Apply only approved modifications.
9. Verify the result and record the progress.

Copying a file does not authorize any of the following:

- changing package imports;
- changing application or package names;
- formatting the source;
- renaming files or declarations;
- changing dependencies;
- fixing errors;
- adding wiring;
- editing comments or documentation;
- changing `AGENTS.md` files.

Temporary analyzer or compilation failures caused by an unchanged copy must be reported and discussed. They must not be fixed without approval.

### Architectural review

After a file is copied unchanged, review it separately to determine:

- whether its destination declares the correct responsibility;
- whether its name matches its actual and declared role;
- whether its dependencies are allowed;
- whether its consumers are allowed;
- whether it should remain intact, be split, be relocated, or be replaced;
- whether it is generic enough for Apollo;
- whether the architecture rules need clarification or improvement.

The review does not authorize implementation changes.

### Language

Apollo is an English-speaking project. Repository documentation, plans, specifications, instructions, code identifiers, and public code documentation must be written in English.

### Initial application example

The first application example will contain only:

- Screen;
- Controller;
- Routing;
- Dependency Injection.

The example will present a simple `Hello Apollo World` experience.

Domain, Data, Infrastructure, Repository, and Use Case objects will not be created unless the example gains a real responsibility that requires them.

### Candidate examples for later stages

Apollo may gradually accumulate approved examples of:

- routing patterns;
- toasts;
- different bottom-sheet types;
- declarative screen layouts;
- application themes;
- internationalization and localization;
- application bootstrap and startup;
- dependency injection;
- application sessions;
- logging;
- diagnostic logging;
- `AppFailure` handling;
- `stateful_data` usage;
- memory caching;
- additional reusable patterns discovered in reference application or future connected projects.

Each candidate must be discussed independently before it is copied or implemented.

## Progress Statuses

Use the following statuses to track every migration item:

| Status | Meaning |
|---|---|
| `DISCUSSING` | The responsibility, value, or destination is still being discussed. |
| `APPROVED_TO_COPY` | The exact source and destination were approved for an unchanged copy. |
| `COPIED_UNMODIFIED` | The approved source was copied without content changes. |
| `REVIEWED` | Architectural compatibility was reviewed without modifying the source. |
| `CHANGE_PROPOSED` | A specific modification was proposed and is waiting for approval. |
| `CHANGE_APPROVED` | The proposed modification was explicitly approved. |
| `CHANGED` | Only the approved modification was applied. |
| `VERIFIED` | The approved result was checked and its evidence was recorded. |
| `DEFERRED` | The item remains a candidate but is intentionally postponed. |
| `REJECTED` | The item will not be included in Apollo. |

## Migration Items

Track approved work in this table. Add one row for each independently reviewed item.

| Item | Source | Destination | Status | Approved action | Verification | Notes |
|---|---|---|---|---|---|---|
| Application entry | `reference_app/lib/main.dart` | `apollo1/lib/main.dart` | `CHANGED` | 1:1 copy, then approved `AEC-001` logger lifecycle and zone-handler change | Static source review; project verification pending missing dependencies | Initializes `AppLogger` before installing handlers and no longer imports a protected shared blueprint directly. |
| Root application widget | `reference_app/lib/app/app.dart` | `apollo1/lib/app/app.dart` | `CHANGED` | Initial 1:1 copy, then update import for the approved global DI relocation | DI import now targets `app/di.dart` | Remaining root-composition review pending. |
| Application bootstrap | `reference_app/lib/app/app_bootstrap.dart` | `apollo1/lib/app/app_bootstrap.dart` | `COPIED_UNMODIFIED` | 1:1 copy | SHA-256 source/destination match | Awaiting connected-part review. |
| Application shell | `reference_app/lib/app/app_shell.dart` | `apollo1/lib/app/app_shell.dart` | `COPIED_UNMODIFIED` | 1:1 copy | SHA-256 source/destination match | Awaiting connected-part review. |
| Application configuration adapter | `reference_app/lib/app/config/app_conf.dart` | `apollo1/lib/app/config/app_conf.dart` | `COPIED_UNMODIFIED` | 1:1 copy | SHA-256 source/destination match | Awaiting connected-part review. |
| Dependency injection composition | `reference_app/lib/app/di/di.dart` | `apollo1/lib/app/di.dart` | `CHANGED` | Initial 1:1 copy, then approved global DI relocation and helper-only project imports | Startup uses Core helper, readiness wait, then feature helper | GetIt dependency and final registration graph still pending. |
| Feature dependency registration | `reference_app/lib/app/di/presentation_di.dart` | `apollo1/lib/app/di/features_di.dart` | `CHANGED` | Approved helper split; use feature-root public DI entrypoints instead of Presentation internals | Imports target only `features/*/di.dart`; calls use `register<FeatureName>Feature` | Retains six pending reference application feature references; these features were not created. Replace the product graph through a separately approved change. |
| Core dependency bridge | Agreed app/Core DI boundary | `apollo1/lib/app/di/core_di.dart` | `CHANGED` | Add helper delegating to the public Core coordinator | Project import targets only `core/core_di.dart`; receives the container as an argument | Does not own the global container or registrations. |
| Core registration coordinator | `reference_app/lib/core/core_di.dart` | `apollo1/lib/core/core_di.dart` | `CHANGED` | Initial approved 1:1 copy, then approved CD-001/CD-002/CD-003 logger, haptic, and shake imports and interface registrations | Initial copy matched byte-for-byte; comparison contains only those approved import and registration changes | Existing feature registrations, App imports, routing/authentication policy, and unmigrated dependencies remain known review findings, not approved architecture. |
| Application router | `reference_app/lib/app/routing/app_router.dart` | `apollo1/lib/app/routing/app_router.dart` | `CHANGED` | Initial 1:1 copy, then approved logger and global DI import updates | Uses project logger export and `app/di.dart` | Remaining routing review pending. |
| Routing observer | `reference_app/lib/app/routing/observers.dart` | `apollo1/lib/app/routing/observers.dart` | `COPIED_UNMODIFIED` | 1:1 copy | SHA-256 source/destination match | Awaiting connected-part review. |
| Reusable error library | `reference_app/lib/libs/errors` | `apollo1/lib/libs/errors` | `COPIED_UNMODIFIED` | Complete 1:1 directory copy | Every source/destination file is byte-for-byte identical | Library `shared` files remain unused protected blueprints. |
| Reusable logger Service | `reference_app/lib/core/telemetry/app_logger.dart` | `apollo1/lib/libs/app_logger/services/app_logger_service.dart` | `CHANGED` | Initial 1:1 copy, approved rename, then separate Domain interface and Service implementation with project-facing exports | Static reference and source comparison; runtime verification pending dependencies | `AppLoggerService` implements `IAppLoggerService`; main and router import through `lib/core/services`. Behavior and protected error blueprints are unchanged. |
| Logger Service interface | Existing logger public API | `apollo1/lib/libs/app_logger/domain/services/i_app_logger_service.dart` | `CHANGED` | Extract the approved interface separately from implementation | Public signatures checked against implementation | Preserves the existing typed failure API, configuration, lifecycle, benchmarks, and log-file getter. |
| Project logger exports | Reusable logger library entrypoints | `apollo1/lib/core/services/app_logger/services/app_logger_service.dart` and `apollo1/lib/core/services/app_logger/domain/services/i_app_logger_service.dart` | `CHANGED` | Export-only project entrypoints mirror the library's layer and responsibility paths | Both files contain export directives only | Project consumers use these paths subject to their own layer rules. |
| English translation asset | `reference_app/assets/translations/en.json` | `apollo1/assets/translations/en.json` | `COPIED_UNMODIFIED` | Approved 1:1 copy; retain easy_localization and the existing translation format | Byte-for-byte comparison and SHA-256 source/destination match | Contains `{}`. Dependency and asset registration applied; easy_localization 3.0.8 resolved. Runtime verification remains pending. |
| Native splash resources | Original Apollo `assets/splash/splash.png` and approved generator configuration | Android launch resources and iOS launch assets/storyboard | `CHANGED` | Approved dependency fetching, splash generation, and generated-file review | Generator exited successfully; native XML, plist, and image-reference checks pass | Includes Android 12 and dark-mode variants. Device verification remains pending. |
| Haptic Service library and project exports | `reference_app/lib/libs/app_uikit/core/services/app_haptic.dart` | `apollo1/lib/libs/app_haptic/services/app_haptic_service.dart`, library Domain interface, and matching exports under `lib/core/services/app_haptic` | `CHANGED` | Initial unchanged copy, then approved marker removal, Service rename, interface extraction, mirrored exports, folder rules, and interface-typed lazy registration | Initial copy matched source byte-for-byte; scoped analyzer passes; method bodies and timing preserved | Three feedback patterns retained. Device and complete DI verification remain pending. |
| Shake detector Service | `reference_app/lib/core/services/shake_service.dart` | `apollo1/lib/libs/shake/services/shake_service.dart`, Domain interface, and mirrored exports under `lib/core/services/shake` | `CHANGED` | Initial approved 1:1 copy, then approved interface extraction and mirrored project exports | Initial copy matched byte-for-byte; comparison now confirms only interface import, implements declaration, and override annotations were added | Dependency declaration, lifecycle wiring, and DI adaptation remain pending. |

## Architectural Part Progress

| Order | Architectural part | Included files | Status | Next action |
|---|---|---|---|---|
| 1 | Application Entry and Composition | `lib/main.dart` and all files under `lib/app` | `CHANGED` | Verify and close `AEC-001`, then continue with `AEC-002`. |
| 2 | Reusable Error Library | all files under `lib/libs/errors` | `COPIED_UNMODIFIED` | Keep library `shared` files unused; review this part before any project-local blueprint copy. |
| 3 | Reusable Logger Service | `lib/libs/app_logger/domain/services`, `lib/libs/app_logger/services`, and `lib/core/services` exports | `CHANGED` | Verify interface conformance and export boundaries; full analysis awaits project dependencies. |

Additional architectural parts will be added only as they are reached and approved.

## Current Stage

`CHANGED`

The Application Entry and Composition part was copied 1:1 before review. The approved `AEC-001` change is now applied to `lib/main.dart`. The supporting Error Library remains copied unchanged. The logger was copied unchanged first, then renamed to `AppLoggerService` with approval. Its interface now lives in the library's `domain/services`, its implementation in `services`, and main and router import through project-level `core/services` exports.

### Logger placement decision and remaining review

The library name defines reusable ownership. Its internal `domain/services` and `services` paths declare the interface and implementation responsibilities; telemetry does not introduce a parallel architectural category. Project wiring under `lib/core/services/app_logger` mirrors these paths rather than flattening them.

Approved changes include relocation, class and constructor naming, interface extraction, project-facing export-only files, required imports and caller updates, and the corresponding folder declarations. Existing logger behavior, the `apollo` default log name, comments, and error-library blueprints remain unchanged.

Reusable Service libraries use `domain/services` for interfaces and `services` for implementations, without an intermediate `core`. Matching library-local rules declare the existing `AppFailure` dependency specifically for this library; this is not a general permission for Domain to import arbitrary libraries. Apollo now has the canonical `core/services/AGENTS.md`, permits startup consumption, and allows app wiring to use project Service entrypoints. Feature consumers retain their own layer restrictions. The interface's `File?` getter preserves the existing API; reducing that filesystem exposure would require a separate decision. Full verification remains pending project dependencies and package identity migration.

Verification for the interface/export split: scoped `dart analyze lib/libs/app_logger lib/core/services` reported seven errors caused by unresolved Flutter and `path_provider` dependencies and their symbols; it reported no interface-conformance errors. Both project export files contain export directives only. No active app consumer directly imports the logger library. The error library remains byte-for-byte identical to reference application. Both repositories pass `git diff --check`. This evidence does not mark `AEC-001` as fully verified.

Follow-up wiring correction: moved project exports under `lib/core/services/app_logger/domain/services` and `lib/core/services/app_logger/services` to mirror the library. Main and router imports now use the nested implementation export. Added cumulative wiring rules and recorded the mirroring requirement in both projects' root architecture guides. Verified that both relative export targets exist, each wiring file still contains only an export, no active consumer references the old flat paths, and both repositories pass `git diff --check`. The library implementation was not changed by this wiring correction.

The developer accepted the declarative responsibility resolution for `lib/core/services/app_logger/domain/services/i_app_logger_service.dart`: project-wide Domain Service interface exposure, wiring-only implementation kind, exact library interface export, and consumers restricted by both dependency directions. Feature Domain access is not declared. This acceptance covers the declaration profile, not runtime verification. Proceed to `AEC-002` while keeping outstanding package and runtime verification visible.

### AEC-002 initial localization review

Existing copied wiring initializes `EasyLocalization` in `main.dart`, wraps `AppWidget` there, and binds the context locale, supported locales, and delegates in `app.dart`. This preserves the agreed startup ownership in main. Configuration uses `en_US`, language-only asset filenames, and `assets/translations`.

reference application's complete translation asset part currently contains only `assets/translations/en.json`, whose content is `{}`. It has now been copied unchanged into Apollo. With explicit approval, Apollo's `pubspec.yaml` now declares `easy_localization: ^3.0.8` and registers `assets/translations/`, matching reference application's declarations.

The developer chose to retain easy_localization and the same translation format and configuration rather than switch localization tooling. Approved copy completed: `reference_app/assets/translations/en.json` to `apollo1/assets/translations/en.json`; byte-for-byte comparison and SHA-256 match pass. The separately approved dependency and asset registration changes are applied. Startup code and translations were not changed. Adding a Hello Apollo translation key belongs to the later minimal example and is not implied by copying the empty asset.

Verification: reviewed the two pubspec additions against reference application, confirmed the registered translation file exists and remains identical to the source, and checked `git diff --check`. Dependency fetching has now completed successfully with easy_localization 3.0.8. Application runtime verification remains pending; `AEC-002` remains `CHANGED`, not `VERIFIED`.

### AEC-003 initial native splash review

Native splash lifetime belongs to startup coordination in `main.dart`: preserve during initialization, then remove after localization and DI finish. The copied code already declares these calls. Apollo now declares `flutter_native_splash: ^2.4.7` under dependencies and includes reference application's generator configuration, pointing to the original Apollo image at `assets/splash/splash.png`.

Source inventory: `reference_app/assets/splash/splash.png`; the `flutter_native_splash` configuration block in reference application's `pubspec.yaml`; and its `flutter_native_splash: ^2.4.7` package declaration (currently under dev dependencies in reference application). The source configuration specifies a white background in both modes, the same source image for Android and iOS including Android 12, centered Android alignment, `scaleAspectFit` for iOS, and web disabled. The inspected source image contains reference application branding.

The developer chose to generate an original Apollo Declarative splash asset instead of copying reference application branding. Generated with the built-in image-generation tool and saved at `assets/splash/splash.png`: a segmented Apollo A with an orbital gesture, transparent PNG, 1254 × 1254 pixels. The generated file and project asset match byte-for-byte; PNG format and alpha metadata were checked. The exact prompt is stored in `ai_development/splash_generation.md`. Generator configuration, dependency registration, dependency fetching, and native-resource generation were separately approved and are now applied. Native generation updated Android launch resources and iOS launch assets and storyboard using Apollo branding.

The package is registered under normal dependencies because Apollo calls `preserve` and `remove` at runtime, as approved. This deliberately differs from reference application's dev-dependency placement, following the package guidance: https://pub.dev/packages/flutter_native_splash .

Configuration verification: parsed both pubspec files as YAML, confirmed Apollo's splash configuration equals reference application's, checked the approved dependency constraint and every configured image path, and passed `git diff --check`. No dependencies were fetched and no native resources were generated in this step.

Dependency and generation verification (2026-10-17): the initial online fetch downloaded and resolved packages but stalled on a remaining network connection; stopped only that invocation's confirmed processes and completed `flutter --suppress-analytics pub get --offline` successfully using the fetched packages. The lockfile records easy_localization 3.0.8 and flutter_native_splash 2.4.7. `dart run flutter_native_splash:create` exited successfully and generated Android default/dark/Android-12 images and launch XML/styles, plus iOS default/dark image catalogs, a launch background, and storyboard updates. Web generation was disabled as configured.

Reviewed the native diffs and inspected a generated iOS logo image. All nine Android resource XML / iOS storyboard files parse. Every referenced image in the iOS launch catalogs exists and has a PNG signature. `Info.plist` passes lint; semantic comparison confirms only `UIStatusBarHidden=false` was added, with existing bundle identity and other settings preserved. Dependency resolution also generated standard iOS/macOS Podfiles, added optional CocoaPods xcconfig includes, and registered the transitive shared_preferences macOS plugin; these tooling changes were reviewed. No CocoaPods installation, application build, or device run was performed. `git diff --check` passes. Native generation is checked, but end-to-end splash lifetime remains unverified pending startup correction and the remaining application migration.

Startup follow-up `AEC-009` is now applied: moved Flutter binding initialization into the same guarded-zone callback as `runApp`, following https://docs.flutter.dev/release/breaking-changes/zone-errors . Splash preservation now precedes asynchronous logger initialization. After logger initialization succeeds, install the framework error callback, initialize localization and DI, release the splash, and run the existing application wrapper. All coordination remains in `main.dart`.

The zone callback logs failures through the initialized logger without awaiting callback logging. Before a logger is available, it reports errors to the Flutter console instead of trying to log through an uninitialized or failed logger. This changes startup error reporting only; no error screen or failure recovery flow was introduced.

Verification: inspected binding initialization and `runApp` in the same closure, and the sequence binding -> splash preservation -> awaited logger initialization -> error-hook installation -> localization -> DI -> splash removal -> runApp. `git diff --check` passes. Scoped `dart analyze lib/main.dart` still reports unresolved `package:ai_declarative_foldering_architecture` and `equatable` imports and their consequent errors; it does not report an error for the zone correction or logger availability branch. Application execution remains pending the remaining dependency and package migration. `AEC-009` is `CHANGED`, not runtime `VERIFIED`.

### AEC-004 initial DI review

`main.dart` invoking and awaiting app-owned DI initialization is the correct startup responsibility. The declaration profile is app-wide wiring: compose approved registration entrypoints and await explicitly registered asynchronous dependencies before starting consumers. This does not authorize product-specific registration or business policy in global wiring.

Initial review compared the two unchanged copied files, `lib/app/di/di.dart` and `lib/app/di/presentation_di.dart`, against reference application. After the agreed DI boundary decision, relocated the initializer to `lib/app/di.dart` and the feature helper to `lib/app/di/features_di.dart`. Copied `reference_app/lib/core/core_di.dart` unchanged to `lib/core/core_di.dart` and verified it byte-for-byte.

Approved declaration update: global `lib/app/di.dart` owns GetIt and startup ordering, with project imports restricted to `app/di`. The feature helper imports only public feature-root DI entrypoints; the Core helper imports only `lib/core/core_di.dart`. Matching `app/di/AGENTS.md` files and root, App, Core, and feature boundary declarations were updated in the architecture repository and Apollo. This explicitly permits the `app/di` helper folder while retaining the flat global entrypoint.

The unchanged copied `core_di.dart` is not only Core Service wiring: it also registers product features, API clients, settings/session, toasts, router, and an authentication/onboarding redirect. These feature registrations, App imports, and product policy conflict with the agreed Core-only responsibility and remain for review. Copying it does not approve migrating these product features. reference application declares `get_it: ^8.2.0`; Apollo has not yet declared it.

Applied the approved placement and helper split. Updated main, AppWidget, and AppRouter imports to the relocated global entrypoint. `registerCoreDependencies` delegates to the copied Core coordinator; `registerFeatures` replaces internal Presentation imports with six public feature DI references. None of these product features or public entrypoints has been created. The copied Core coordinator also registers overlapping features, so duplicate registration would need resolution before this graph could run. These pending references and the duplicate-registration risk are migration findings, not a working Hello Apollo graph. A minimal Hello Apollo graph should eventually include the existing logger instance under its interface, the app router, and Hello Apollo's public feature DI; changes to the registration contents require separate approval.

Static verification: global DI project imports are helper-only; helpers receive the container instead of importing it, the feature helper has no internal-layer imports, and the Core helper delegates only to Core DI. The copied Core coordinator is byte-for-byte unchanged. Both repositories pass `git diff --check`; helper rules match across repositories. Overall DI migration remains `CHANGED`, not `VERIFIED`, due to the unchanged coordinator's declaration conflicts and missing dependencies/feature entrypoints.

Scoped `dart analyze lib/app/di.dart lib/app/di` reports 21 findings: missing GetIt dependency, absent feature-root DI files, their consequent undefined types/functions, and dependency-declaration notices. These findings are recorded rather than repaired outside the agreed migration step. The Core coordinator's feature registrations, application-policy behavior, and old package references remain separately unresolved.

### Core registration review: CD-001 Logger

Reviewed `core/core_di.dart`'s first registration: `di.registerLazySingleton<AppLogger>(() => AppLogger())`, still using reference application's old logger path and concrete type. Its declared responsibility is Core DI wiring, consumed only through `app/di/core_di.dart`. Logger contract and implementation must be imported through the mirrored project Core Service entrypoints; both explicitly permit Core consumers. Registration itself belongs in Core DI, while explicit asynchronous logger initialization remains in main before app DI startup.

`AppLoggerService()` is a factory returning one static instance, already initialized by main before `initDI`. With explicit approval, replaced the old reference application logger import with project `services/app_logger/domain/services/i_app_logger_service.dart` and `services/app_logger/services/app_logger_service.dart`, and changed registration to `di.registerSingleton<IAppLoggerService>(AppLoggerService())`. This exposes the existing instance through its interface without initializing it again. Other registrations, library behavior, disposal policy, and startup callbacks were not changed.

| ID | Registration | Status | Next action |
|---|---|---|---|
| `CD-001` | Logger | `CHANGED` | Approved imports and interface-typed singleton registration applied; runtime verification awaits the pending DI dependencies and graph. |
| `CD-002` | Haptic feedback | `CHANGED` | Approved copy and adaptations applied; scoped static analysis passes. Device and full DI verification remain pending. |
| `CD-003` | Shake detection | `CHANGED` | Approved interface, mirrored exports, interface-typed DI registration, and sensors_plus dependency applied and fetched. Scoped analysis has no errors or warnings; lifecycle and device verification remain pending. |
| `CD-004` | TokenStore / SecureTokenStore | `DEFERRED` | Not needed by the initial Hello Apollo example; retain as a future authentication candidate. Copied Core DI references have not been removed. |
| `CD-005` | SharedPreferences and settings/session dependency chain | `DISCUSSING` | Decide reusable module ownership for settings and session separately before proposing copy paths; no source copied or registration changed yet. |

Static verification: comparison with reference application contains only replacement of the logger import by the two project-facing imports and replacement of its registration. Both import targets exist, the Service implements the registered interface, and `git diff --check` passes. GetIt is not declared in Apollo, and Core DI's other copied imports and registrations remain unresolved; runtime verification remains pending. Next inspect `AppHaptic` separately.

### Core registration review: CD-002 Haptic feedback

Source: `reference_app/lib/libs/app_uikit/core/services/app_haptic.dart`. It exposes three device-feedback patterns: click (light impact), attention (two light impacts with a delay), and positive feedback (light, medium, and heavy impacts with delays). Its source dependencies are Flutter's platform services and `app_uikit/core/abstractions/app_element.dart`. `AppElement` is an empty UI-oriented marker base class; it contributes no executable behavior to haptics. Copied the source unchanged to `lib/libs/app_haptic/services/app_haptic_service.dart` before adapting it; byte-for-byte comparison passed, with source and initial-copy SHA-256 `bac723076512afd54451c5c974deb76c64be4624cdfa63882fa7cc88aadb479b`.

The intended architectural responsibility is a reusable, feature-independent device Service. The source name `AppHaptic` lacks the declared Service suffix, and the UI marker inheritance is a separate adaptation decision. Its existing reference application consumers include feature UI, Controllers, and shared UI, frequently importing the library directly and resolving the concrete type from app DI. Those usages are source evidence, not approved Apollo consumer boundaries.

Applied approved adaptation after the unchanged copy: removed the `AppElement` import and inheritance, renamed the concrete class to `AppHapticService`, implemented `IAppHapticService`, and added override annotations. All three method bodies and their timing remain unchanged. reference application source was not edited.

Approved ownership and wiring are now applied: dedicated `libs/app_haptic` library with `domain/services/i_app_haptic_service.dart` and `services/app_haptic_service.dart`, exposed through matching export-only paths under `core/services/app_haptic`. Matching cumulative rules declare Domain as interface-only, implementation dependencies as Dart/Flutter platform services plus its own interface, and project access through the mirrored exports. Core DI imports the project interface and implementation exports and registers `di.registerLazySingleton<IAppHapticService>(() => AppHapticService())`. Unlike the logger, this Service has no asynchronous initialization requirement. No reference application consumer was migrated or created.

Verification: `dart analyze lib/libs/app_haptic lib/core/services/app_haptic` exits successfully with no issues. Comparison against the source confirms only the approved import, class/interface, and override changes in the implementation; feedback calls and delays are preserved. Project export targets resolve and expose only their named types. `git diff --check` passes. Device feedback and the complete Core DI graph remain unverified because GetIt and other registration dependencies are still pending. Next review `ShakeService` as `CD-003`.

### Core registration review: CD-003 Shake detection

Inspected `reference_app/lib/core/services/shake_service.dart` and its consumers. It observes Flutter app lifecycle, subscribes to user accelerometer events, detects repeated direction reversals in the X-Z plane using configurable thresholds and timing, applies cooldown/debounce, and invokes a supplied callback. Dependencies are Dart SDK, Flutter widgets/lifecycle, and `sensors_plus` (`^7.0.0` in reference application's pubspec). It does not import project DI, routing, logger, toast UI, or failure handling. Diagnostic/application response belongs to the supplied callback's owner, not the detector.

The declared role fits a reusable device Service. Approved ownership is now `libs/shake`, with interface `domain/services/i_shake_service.dart`, implementation `services/shake_service.dart`, and mirrored project exports under `core/services/shake`. The interface uses Dart `void Function()` for the callback and exposes configuration getters/setters, enabled state, init, enable, disable, and dispose. Flutter lifecycle observation and sensor event types remain implementation details. `ShakeService` implements `IShakeService`; the concrete callback may retain Flutter's equivalent `VoidCallback` alias without introducing a platform dependency into Domain.

Initial approved unchanged copy completed: `reference_app/lib/core/services/shake_service.dart` to `apollo1/lib/libs/shake/services/shake_service.dart`. This is the complete local detector implementation; Flutter and sensors_plus are package dependencies, not additional project source to copy. Initial source and destination SHA-256 matched at `f33aa5566156431b434736ffca322cccfdb49ef5c404d94377e4c8ed5bea4c9d`. After separate approval, added only the interface import, implements declaration, and override annotations to the detector; its method bodies remain unchanged. Added Domain and mirrored project wiring rules. Core DI still refers to the old reference application path; it was not modified in the interface/export step.

Verification: comparison against reference application confirms unchanged detection/lifecycle method bodies, thresholds, timing, and debug output. Interface has no platform imports; both mirrored wiring files contain only an export of the matching named type. `git diff --check` passes. Scoped `dart analyze lib/libs/shake lib/core/services/shake` reports four errors caused by missing sensors_plus/types, its dependency-declaration notice, and five existing source-style/debug-print notices (ten findings total). It reports no interface-conformance error. Full analysis and runtime verification remain pending sensors_plus and later integration.

Applied the separately approved DI change: Core DI imports `services/shake/domain/services/i_shake_service.dart` and `services/shake/services/shake_service.dart`, and registers `di.registerLazySingleton<IShakeService>(() => ShakeService())`. Removed only the old reference application shake import and concrete-type registration. This keeps construction lazy and does not initialize or enable detection. Core is a permitted consumer of both project entrypoints, and Core DI's outbound rules allow those public Core imports.

DI-step verification: reviewed the changed imports and interface registration, checked the coordinator against reference application plus the already approved logger/haptic changes, and passed `git diff --check`. Full DI analysis/runtime verification remains pending GetIt, resolved sensors_plus, and the other unmigrated registration dependencies.

Applied the separately approved dependency declaration `sensors_plus: ^7.0.0` in Apollo's normal dependencies, matching reference application's constraint. YAML parsing, constraint comparison, and `git diff --check` pass. No dependency fetch, lockfile update, detector behavior change, or native-platform configuration change was performed in this step. Next discuss fetching the dependency, enable/init/dispose ownership, and existing debug output (`print("aa ...")`) separately.

Approved follow-up completed: `flutter --suppress-analytics pub get` exited successfully and resolved sensors_plus 7.1.1 within the approved `^7.0.0` constraint. Lockfile additions are sensors_plus 7.1.1, sensors_plus_platform_interface 2.0.2, and logging 1.3.0. The existing constraint was not changed.

Scoped `dart analyze lib/libs/shake lib/core/services/shake` now exits successfully with no errors or warnings. Six informational findings remain: the inherited lifecycle parameter naming, two missing-braces notices, the deprecated `userAccelerometerEvents` getter, the existing debug print, and unnecessary interpolation braces. Inspected the installed package source to confirm the deprecated getter's recommended replacement is `userAccelerometerEventStream()`. No detector source or lifecycle behavior was changed while fetching or analyzing. `git diff --check` passes. Cleanup, API migration, and init/enable/dispose ownership require separate decisions; device testing and full DI verification remain pending.

Lifecycle review: no detector initialization call supplying `onShake` was found in reference application or Apollo. reference application's error-handler blueprint only resolves the Service, checks `enabled`, and may disable it; that blueprint is unused in Apollo. Registration alone neither attaches the lifecycle observer nor starts the accelerometer subscription. Once configured and enabled, the Service itself handles foreground/background subscription changes.

Proposed ownership: keep startup configuration in main after DI, as already agreed for app startup; keep shake-triggered diagnostic/UI policy outside the reusable detector. Any future activation must identify the app runtime owner that disposes the configured Service. Apollo currently has no approved diagnostic action for `onShake`. Recommend leaving the lazy registration inactive until a real diagnostics example is selected, then wiring initialization, callback, activation, and teardown together. This recommendation is pending approval; no placeholder callback or lifecycle code was added. If deferral is accepted, proceed to the next Core registration (`TokenStore` / `SecureTokenStore`) while keeping CD-003 runtime verification pending.

### Core registration review: CD-004 Token storage

Inspected reference application's `core/auth/abstractions/token_store.dart` and `core/auth/secure_token_store.dart`. The interface reads access/refresh tokens, saves the pair, and clears them. The implementation delegates to flutter_secure_storage. API clients and auth interceptors consume it; token storage itself does not perform login or token refresh requests.

After this explanation, the developer accepted leaving authentication token storage out of the initial Hello Apollo example. Marked as deferred rather than rejected for the reusable scaffold. No token-storage source or package was copied or added. The already-copied Core DI import and registration remain unresolved; removing those lines requires a separately approved change. Shake activation remains inactive with no callback or lifecycle wiring added. Next inspect the SharedPreferences registration and its settings/session consumers before deciding what to include.

### Core registration review: CD-005 Preferences, settings, and session

Inspected the async SharedPreferences registration and its settings/session consumers as a connected dependency chain: SharedPreferences -> AppSettings -> AppSession. SharedPreferences is the third-party persistence mechanism, AppSettings is reference application's wrapper, and AppSession adds session identity and memory caching. These are distinct responsibilities, not three names for the same storage object. The session here is a settings/cache namespace, not authentication token storage. Apollo already resolves shared_preferences 2.5.5 transitively through easy_localization but does not declare it directly.

Source inventory for later placement decisions:

- `reference_app/lib/libs/app_uikit/core/settings/data/datasources/local/app_settings.dart`: includes SettingsKeyType, SettingsKey, JSON conversion, defaults, typed reads/writes, session-key namespacing and deletion, and AppFailure/Either results. Imports Dart JSON, shared_preferences, dartz, and errors.
- `reference_app/lib/libs/app_uikit/core/session/domain/repositories/app_session.dart`: IAppSession contract; depends on session Params, errors, dartz, and resources.
- `reference_app/lib/libs/app_uikit/core/session/infrastructure/repositories/app_session.dart`: restores/creates a UUID session, caches values in memory, persists through AppSettings, and emits Resource<String> updates.
- `reference_app/lib/libs/app_uikit/core/session/params/app_session_params.dart`: session-aware key declarations and params; currently imports the concrete settings file to obtain key types.

Architectural review against target rules: the AppSettings implementation performs external persistence and JSON conversion, so its source `data/datasources/local` path does not match the target's interface-only Data Source responsibility. The session Domain interface also reaches the concrete settings file through Params, mixing contract/key declarations with storage implementation. These are placement and dependency decisions to resolve; do not silently classify or repair them. Session implementation additionally depends on the not-yet-migrated resources library and UUID; neither copying the package registration nor keeping the settings wrapper approves that entire chain automatically.

Recommendation pending developer decision: treat reusable settings persistence and session/cache behavior as separate connected modules, with their own contracts and implementations, instead of putting them into UI kit. Start with AppSettings responsibility and target layout before proposing an unchanged copy, then review session separately. No settings/session source, dependencies, or DI registration was changed by this read-only review. Other registrations such as AppSnackBar remain pending and have not been implicitly skipped or approved.

## Current Scope

- Project application ID: `com.kvoronov.apollo`.
- Apollo is a reusable scaffold and architectural demonstration, not a reference application product clone.
- Product features from reference application are outside the initial scope.
- The first feature is the minimal `Hello Apollo World` example.

## Current Review Queue

The following reference application couplings were observed before copying. They are numbered resolution items, not approved changes. Resolve them one at a time in this order so the review follows the application startup trajectory from the top.

| ID | File or boundary | Resolution item | Status | Approved resolution |
|---|---|---|---|---|
| `AEC-001` | `lib/main.dart` | Resolve whether global Flutter error conversion, failure handling, and diagnostic logging belong in the application entrypoint or behind an app-owned startup entrypoint. | `CHANGED` | `main.dart` remains the top-level startup owner; initialize `AppLogger` before installing handlers; keep callback logging fire-and-forget; use an inline guarded-zone logger instead of importing the protected `libs/errors/shared` blueprint directly. |
| `AEC-002` | `lib/main.dart` | Resolve ownership of localization initialization and the root localization wrapper. | `CHANGED` | Retain easy_localization, existing configuration, and startup ownership in main. Translation asset copied unchanged; approved dependency and asset registration applied. Dependencies resolved; runtime verification pending. |
| `AEC-003` | `lib/main.dart` | Resolve ownership of native splash preservation and removal across asynchronous startup. | `CHANGED` | Startup owner remains main. Original Apollo image, normal dependency declaration, and generator configuration applied with approval. Dependencies resolved and native generation checked; device verification pending. |
| `AEC-004` | `lib/main.dart` and app DI wiring | Resolve DI startup ownership, canonical entrypoint placement, and registration boundaries. | `CHANGED` | Global DI moved to `app/di.dart`; Core/feature helpers follow the agreed public-entrypoint boundaries. Core coordinator copied unchanged. Registration-content review and dependency migration remain pending. |
| `AEC-005` | `lib/app/app.dart` | Resolve ownership of root theme, localization bindings, router binding, application bootstrap, and UI scaling composition. | `OPEN` | None |
| `AEC-006` | `/app/di` boundary | Resolve direct imports of `app/di/di.dart` from features, shared code, libraries, repositories, core interceptors, and other lower-level implementations. | `OPEN` | None |
| `AEC-007` | `/app/routing` boundary | Resolve direct imports of `app/routing/app_router.dart` from features, shared code, libraries, and core. | `OPEN` | None |
| `AEC-008` | `lib/app/routing/app_router.dart` | Resolve direct application-router imports of feature screens, feature sheets, and feature route builders against the permitted app wiring entrypoints. | `OPEN` | None |
| `AEC-009` | `lib/main.dart` | Correct the Flutter binding/runApp zone mismatch introduced by the earlier AEC-001 change; review binding, splash, and logger initialization order together. | `CHANGED` | Applied on developer instruction to proceed: binding and runApp share the guarded zone; preserve splash before logger initialization; use console reporting before logger availability and fire-and-forget failure logging afterward. Static checks completed; runtime verification pending. |

For each item:

1. Resolve the declared responsibility from the proposed Apollo path and name.
2. Check actual behavior and owned side effects.
3. Check `May Import From`, `May Be Imported By`, and required import/export entrypoints.
4. Decide whether the current implementation already fits or whether a change is needed.
5. If a change is needed, propose it separately and wait for explicit approval.
6. Record the approved resolution and verification before moving to the next item.

Additional resolution items may be added as the connected-part review discovers them. No uncoupling change is implied or approved by this queue.

### Approved architecture decision: Shared Managers

The developer approved placing project-specific cross-feature Managers in `lib/shared/core/managers` in both Apollo and the architecture repository. Shared remains for library adaptations; Managers are the sole explicit additional responsibility. This does not authorize other Core objects in Shared.

Moved the Manager declarations from `lib/core/managers/AGENTS.md`, added the Shared Core parent boundary, and updated active placement and dependency references. Managers consume feature Domain contracts only through `domain/shared`; consumers remain permitted App wiring, Core Flows, and feature Controllers, subject to both dependency directions. Data, Infrastructure, Domain, and UI widgets cannot consume Managers, including through Shared re-exports. Removed the legacy Apollo Data/Infrastructure Manager-consumer exception to preserve Domain-only Manager access.

Both old Manager folders contained only rule files: no Manager Dart implementations, runtime imports, or registrations were moved. reference application and settings/session code remain unchanged. This decision settles Manager placement only; CD-005 settings/session classification remains open.

Verification: the Shared, Shared Core, and Manager declarations match between the two repositories. Reviewed cumulative scope, naming, both dependency directions, and Domain shared entrypoints; active Manager placement references now use the new path. The old path remains only in explicit placement prohibitions and historical context. Both repositories pass `git diff --check`. No runtime tests were run because this step changes documentation only. App and Flow permissions remain subject to their narrower existing wiring rules; this decision does not add a DI registration route or a runtime consumer.

### Approved architecture decision: Core Repositories

The developer confirmed that AppSettings and AppSession are reusable Core Repositories, not features or feature-owned repositories. Ownership remains in `libs/app_settings` and `libs/app_session`, with separate Domain contracts/value declarations and Infrastructure implementations. Project-facing exports and approved adaptations belong in `shared/core/repositories/<library_name>`, mirroring library architecture.

Feature Infrastructure repositories, Controllers, and Shared Managers may consume these Domain contracts and values directly. A Manager is not required merely to access settings or session storage. The prohibition on accessing another feature's repositories remains unchanged. Concrete implementations are reserved for permitted DI construction and approved adaptations; feature Domain, Data, and UI widgets do not gain repository access.

Applied the general placement and directional dependency declarations in both repositories, including the Shared Core Repository boundary. Actual library-local folder rules, exact DI construction entrypoints, and unchanged source-copy inventory still require review. No source was copied, split, renamed, or modified, and no registration or dependency was changed. The original `AppSettings` and `IAppSession`/`AppSession` names do not yet satisfy the agreed Repository naming pattern; preserve them during any separately approved unchanged copy, then discuss adaptation.

Verification: Shared, Shared Core, and Core Repository boundary guides match between repositories and follow the required guide section schema. General contract-consumer permissions and implementation restrictions were checked cumulatively; both repositories pass `git diff --check`. This is a policy-level check, not a claim that the existing source is compliant: the resolver still needs concrete library-local declarations before resolving individual objects. Runtime verification is not applicable to this documentation-only step.

### Corrective review: blueprint-first rules and redundant guides

The developer rejected the agent-added requirement for every descendant folder to have its own rules. Approval of architectural boundaries did not authorize that additional structural requirement. This review supersedes the earlier instruction to create complete AppSettings rule files folder by folder; the models draft was never saved.

Reviewed 34 added or moved production-folder guides across both repositories: 30 in Apollo and four in the architecture repository, together with the modified architecture-rule diffs. Existing feature blueprint guides were not created by this detour and are preserved. Retained the DI helper, Manager relocation, Shared/Core Repository boundary, Service library roots, Service contract/implementation leaves, and export leaves because they declare actual approved scope, layout, dependency, naming, or visibility differences. Their legacy dependency syntax remains a separate explicit review; this cleanup does not silently convert it.

Removed seven redundant guides from Apollo:

- `lib/libs/app_settings/domain/repositories/AGENTS.md`
- `lib/libs/app_logger/domain/AGENTS.md`
- `lib/core/services/app_logger/domain/AGENTS.md`
- `lib/libs/app_haptic/domain/AGENTS.md`
- `lib/core/services/app_haptic/domain/AGENTS.md`
- `lib/libs/shake/domain/AGENTS.md`
- `lib/core/services/shake/domain/AGENTS.md`

The AppSettings guide was the module-specific placeholder created during this rule-driven detour. Its recorded naming and Core Repository decisions remain valid; its bespoke consumer list is withdrawn as an active rule. The six Service Domain intermediary guides repeat library/project parent and surviving Service-leaf declarations without adding an independent exception. Their removal leaves all Dart files, export leaves, interface/implementation separation, and retained dependency restrictions unchanged.

Exact copies of the seven removed guides are recoverable in `/private/tmp/apollo-rule-cleanup.AFXtyJ`; backup filenames encode the original relative paths using double underscores. The user authorized this scoped cleanup. No source implementation, package manifest, lockfile, registration, native asset, or reference application file was changed.

Removed mandatory per-descendant wording from both root and library guides and the Shared Core Repository boundary. Added the approved blueprint-first principle to both roots and the template. The template no longer requires repeating every section: omitted sections inherit applicable rules; explicitly empty dependency lists still deny access.

Cleanup verification: all seven backup files match their removed originals exactly. The forbidden mandatory-per-descendant phrases and references to the deleted intermediary guides are absent from production-folder rules. Retained canonical and Apollo Core Service and Core Repository boundary guides match. All Dart source path/SHA-256 pairs in both repositories are unchanged; both repositories pass `git diff --check`. Runtime tests were not run because only documentation changed. The migration remains stopped after this corrective review; no new AppSettings declarations or source copies were made.

## Next Decision

### Hello Apollo: four-file feature and feature DI implemented

Implemented the approved four-file feature under `lib/features/hello_apollo`: public `di.dart` with `registerHelloApolloFeature`, public Presentation `routing.dart` with `buildHelloApolloRoutes`, private `HelloApolloController`, and private `HelloApolloScreen`. The Controller supplies the greeting `Hello Apollo World`; the Screen renders it with standard Flutter widgets. The DI entrypoint registers a factory, so each route-created Screen receives a fresh Controller. This stateless Controller owns no resources and needs no disposal hook. Routing receives the container explicitly; neither the Controller nor Screen imports App wiring or resolves global DI.

Replaced the six missing reference application feature DI imports/calls in `lib/app/di/features_di.dart` with Hello Apollo's feature-root entrypoint. Added `go_router: ^17.5.0`; Flutter's dependency dry run selected this compatible version for the installed SDK instead of requiring an SDK upgrade for 18.1.0. Package resolution added only go_router and retained all existing resolved versions. No Domain/Data folders, repositories, artificial data lifecycle, state-management dependency, or AGENTS files were added.

Verification: scoped analysis of the new feature, global App DI, both App helpers, and Core DI reports no issues. Naming and dependency review confirms App uses only the feature-root DI entrypoint; routing accesses its own Screen/Controller; the Screen imports only its Controller and Flutter; no sibling features or protected Shared blueprints are dependencies. `git diff --check` passes. Source inventory confirms exactly four new Dart files and only the approved existing feature-helper modification. No runtime tests or full application build were run. Global App routing still contains the reference application route graph and does not yet call the Hello Apollo builder; theme, UI scaling, and bootstrap remain pending. Original feature helper, manifest, and lockfile are preserved in `/tmp/apollo-hello-feature-kWZuDC`.

### Hello Apollo: minimal feature map reviewed, implementation pending

Reviewed the existing feature, Presentation, Controller, and App-DI declarations against the governing document. Proposed four source files: `lib/features/hello_apollo/di.dart`, `presentation/routing.dart`, `presentation/controllers/hello_apollo_controller.dart`, and `presentation/screens/hello_apollo_screen.dart`. The feature shows Hello Apollo World; no repository, Domain/Data layer, Manager, artificial data lifecycle, or additional state-management package is required.

The feature-root DI function is `registerHelloApolloFeature(GetIt di)`, consumed only through App's feature helper. The routing entrypoint exposes `buildHelloApolloRoutes`, consumed by global App routing. Feature routing constructs its own screen and supplies the Controller through injection; the Screen does not import the global DI container. The Controller is screen-scoped, not an app-wide singleton. App imports neither Screen nor Controller directly. No new AGENTS files are proposed.

Pending approval: create these four source files, replace six missing reference application feature registrations in App's feature helper with Hello Apollo's public DI entrypoint, and declare the existing router technology's missing go_router dependency. Global App-router adaptation, theme, UI scaling, and bootstrap remain separate subsequent work; this feature step alone does not make Apollo runnable.

Review finding: the architecture project's legacy feature AI-development blueprint still requests an AGENTS file for every feature AI folder. That instruction conflicts with the approved governing rule against redundant local declarations. It will not be copied; correcting that legacy declaration is separate from creating the feature. No source, dependency, or architecture-rule changes were made in this review.

### Core DI: minimal Apollo registrations applied

Applied the proposed Core-only cleanup when the developer directed proceeding to the next step. `lib/core/core_di.dart` now contains only the existing Logger, Haptic, Shake, SharedPreferences, Settings, and Session registrations. Removed reference application API clients, secure token storage, RTC registrations, product-feature registration calls, toast, authentication redirect policy, and AppRouter registration, together with their imports. Preserved the complete original coordinator and its comments in `/tmp/apollo-core-di-cleanup-X6owZg/core_di.dart` before removing those blocks.

The six retained registration blocks are unchanged: SharedPreferences precedes Settings, Session initializes after Settings, failures still propagate through AppResult folds, and Session disposal remains registered. No Logger reinitialization or Shake activation was added. Core no longer imports App, features, or AppConf. Its sole production importer remains the existing App Core-DI helper. All other Dart source files are unchanged.

Verification: scoped analysis of the Core coordinator and App Core-DI helper reports no issues; `git diff --check` passes. No runtime tests or full application build were run. The App feature helper still references six absent reference application feature entrypoints, and Apollo router composition is not yet implemented after removing its product-specific Core registration. These remain subsequent App/feature wiring work, not a verified application startup. No architectural rules or AGENTS files changed.

### Core DI review: minimal Apollo graph proposed

Reviewed `lib/core/core_di.dart`, the global App DI entrypoint, and both App registration helpers. The Core coordinator still mixes Core registrations with reference application API clients, secure token storage, RTC services, feature registration, UI toast, and authentication-dependent router configuration. The existing Core guide already excludes feature registration, routing, and authentication policy from this coordinator; no new architectural rule is needed.

Proposed keeping the six existing scaffold registrations only: IAppLoggerService, IAppHapticService, IShakeService, SharedPreferences, IAppSettingsRepository, and IAppSessionRepository. Preserve the current initialization order SharedPreferences -> Settings -> Session, existing AppResult failure propagation and Session disposal, and App's readiness wait. Logger remains initialized in main; Shake remains lazy without a new callback or automatic activation.

Pending implementation approval: remove the reference application-only imports and registration blocks from the Core coordinator after preserving its complete original, including comments. Do not move router policy into Core or redirect Core to AppConf. App-owned router composition and replacement of the six old feature DI references remain separate subsequent steps; this Core-only cleanup will not make the full application runnable. No source or rule changes were made during this review.

### AppConf: Apollo adaptation complete

The developer requested completing AppConf adaptation and explaining the result. Kept the project-owned declaration at `lib/app/config/app_conf.dart`; the root widget already imports this local file. Removed six reference application backend/LiveKit configuration objects, ten wallet/chain environment settings, and the two missing backend configuration imports. Did not introduce replacement endpoints or copy backend modules solely to satisfy those dependencies.

Preserved all eleven generic defaults and their values: design dimensions, animation durations, text scaling, modal fractions, map zoom, image quality, fetch limit, and preload extent. Preserved the existing comment, class/field names, and const-only structure. AppConf now depends only on Flutter and contains no reference application endpoint, wallet setting, or product configuration type. It remains App-owned configuration, not a dependency for reusable libraries or Core implementations; future integrations should receive their required values through composition.

Verification: scoped analysis of AppConf and main reports no issues; the root widget has no remaining AppConf diagnostics and still has five unrelated theme/UI-scaling errors. Other Dart source hashes are unchanged, and `git diff --check` passes. No runtime tests or full application build were run. Core DI still retains its pre-existing reference application configuration import and backend registrations; those were not redirected to App configuration and remain the next separate wiring review. No AGENTS files, manifests, or architecture rules changed. Pre-adaptation AppConf is recoverable in `/tmp/apollo-app-conf-cleanup-RtlHd2/app_conf.dart`; the earlier placeholder remains preserved separately.

### Root App widget: approved project AppConf import

Changed only `lib/app/app.dart`'s configuration import from reference application's UI Kit path to `config/app_conf.dart`. Values, comments, and wiring behavior are unchanged. Scoped App-widget analysis no longer reports the missing configuration import or undefined AppConf symbols; five errors remain for the missing theme and UI-scaling dependencies. AppConf's own unresolved backend types remain a separate issue. `git diff --check` passes.

### AppConf: approved unchanged source copy

Copied reference application's complete `lib/libs/app_uikit/app/config/app_conf.dart` unchanged into Apollo's existing `lib/app/config/app_conf.dart`. The previous placeholder, including its comment, is preserved in `/tmp/apollo-app-conf-5HoDFv/app_conf_placeholder.dart`. Byte comparison and SHA-256 match the source (`aa9ef1a264450c0ad17ba4ab111b692c50fd04bc64261de4176736e03875d296`). No import consumers, configuration values, comments, or reference application files changed.

Scoped analysis reports fourteen errors caused by the unresolved RestApiConfig/LiveKitConfig imports and constructors, plus one package-reference notice. These are retained for the separately approved adaptation stage; the copy is verified, not the runnable configuration. `git diff --check` passes. Next proposed step: point the root App widget's configuration import at its new local AppConf; backend, wallet, and reusable UI defaults remain separate review decisions.

### Root App widget: approved local App imports

Updated only the two stale reference application imports in `lib/app/app.dart` to Apollo's existing `app_bootstrap.dart` and `routing/app_router.dart`. No comments or runtime behavior changed. Scoped analysis no longer reports those missing imports or the resulting missing AppBootstrap/AppRouter symbols. Eight errors remain in this file for the still-missing theme, UI scaling, and configuration dependencies; this is not a clean App-widget or full-application analysis result. `git diff --check` passes. Those supporting dependencies remain separate review decisions.

### Entrypoint: remove unused Flutter Services import

With developer approval, removed only the unused `package:flutter/services.dart` import from `lib/main.dart`. Comments and startup behavior are unchanged. Scoped analysis of `lib/main.dart` reports no issues, and `git diff --check` passes. Application-wide compilation and runtime startup remain unverified.

### Entrypoint: remove unused Equatable setup

With developer approval, removed the unresolved Equatable import and both duplicate `EquatableConfig.stringify = true` assignments from `lib/main.dart`. No current Apollo declarations use Equatable. Existing comments and all other startup code are preserved; no dependency was added. Scoped analysis of `lib/main.dart` reports zero errors and one unused `flutter/services.dart` import warning, left unchanged because it was outside the approved three-line removal. `git diff --check` passes. This does not verify the imported application/DI/routing graph or runtime startup.

### Logger: approved path_provider dependency

Added the approved `path_provider: ^2.1.6` dependency to Apollo and resolved it to hosted version 2.1.6. Package resolution added path_provider and eleven transitive packages; existing resolved package versions were retained. The lockfile's effective Flutter minimum changed from 3.38.0 to 3.38.4. No application platform settings were changed.

Scoped analysis of the Logger library and its Core interface/Service exports now reports zero errors. The existing unused `dart:developer` warning and fifteen informational notices remain intentionally untouched; this is not a warning-free analysis result. Dart source and AGENTS path/content hashes are unchanged. `git diff --check` passes. No runtime or device tests were added or run, and this does not mark the full application startup graph verified. Pre-edit manifest and lockfile are recoverable in `/tmp/apollo-path-provider-nXi34k`.

### Resolver: supporting roles and both dependency directions

The developer approved updating `resolve-declarative-responsibilities` to distinguish an owner's architectural role from a supporting Wrapper, Formatter, Validator, or Mapper responsibility. The skill now loads the target project's governing document first, checks compound suffix ordering and owner-layer placement, and explicitly reports permitted/forbidden outbound dependencies and inbound consumers as folder paths with controlling rule evidence. Candidate relationships require both endpoints, scope/layer boundaries, and public entrypoints to permit them; unresolved cases do not become permissions. No new architectural permission or local AGENTS declaration was introduced.

Corrected `apiDataSourceWithVoidResponseWrapper` to `apiWithVoidResponseDataSourceWrapper`, keeping `DataSourceWrapper` as the complete suffix. No behavior, comments, imports, or other declarations changed. No callers referenced the former function name. The existing skill's metadata and discovery settings are preserved.

### API wrapper owner-role naming

The developer approved fixing the existing wrapper naming. Renamed `api_call_wrappers.dart` to `api_data_source_wrapper.dart` under `lib/libs/errors/core/infrastructure/wrappers`. Renamed its two public helper functions to `apiDataSourceWrapper` and `apiDataSourceWithVoidResponseWrapper`. They wrap API Data Source operations, not Repository operations; the names now identify that owner role and their supporting Wrapper responsibility. Kept the existing function-based structure, callback parameters, helpers, dependencies, and behavior unchanged. No callers or imports referenced the former names or filename. Scoped analysis and the naming/declarative-rule checks pass for this change; no AGENTS files or architecture rules changed.

### API wrappers: approved Infrastructure path correction

Moved `lib/libs/errors/core/infastructure/wrappers/api_call_wrappers.dart` to `lib/libs/errors/core/infrastructure/wrappers/api_call_wrappers.dart` with identical contents. No production imports reference the old path; no caller changes were needed. Scoped analysis passes. Supporting-responsibility naming remains the next review; this move does not rename functions or change behavior. No AGENTS files were added or edited.

### Supporting responsibilities follow their owner's layer

Approved Wrappers, Formatters, Validators, and Mappers as supporting responsibilities, not architectural layers. Recorded their definitions and owner-layer placement in the governing document in both projects. Their folder names do not grant broader dependency permissions. Names preserve the owner and supporting role, including the approved example `SomeNameRepositoryWrapper` in `some_name_repository_wrapper.dart`.

This records the rule only: no Dart files were moved, renamed, or edited, and no AGENTS files were added or changed. Existing API wrapper naming and the `infastructure` spelling still need a separate source review against this rule.

### Errors library: published AppFailure migration

The developer requested removal of local failure definitions in favor of the published `app_failure` package. Removed the nine duplicate failure-model files from `lib/libs/errors/core/domain/models`. Startup, routing, Logger's interface/implementation, and the unused presentation blueprints now reference `package:app_failure/app_failure.dart`. Updated factory names, fatality comparisons, and the former `DioFailure` branch to the package's `HttpFailure`. Existing comments in retained source are unchanged. The errors barrel now exports the package only, not protected presentation blueprints.

The existing API wrappers return `AppResult<T>` instead of dartz `Either`. Success, empty payloads, non-success HTTP responses, mapper exceptions, and Dio exceptions retain explicit outcomes. HTTP failures preserve request/response snapshots, exception kind, original error, nested AppFailure cause, and the caught stack trace using published package types, not a local failure hierarchy. Added the already-used but undeclared Dio dependency (`^5.9.2`); offline resolution added Dio and its three missing transitive packages without upgrading existing packages. `app_failure` remains the hosted package at version 1.0.1. Marked the original reference application manual as historical and linked the existing AppFailure usage rules rather than silently rewriting its examples or comments.

Verification: scoped analysis of the migrated wrappers, package barrel, Logger contract, Core Domain/Infrastructure, and AppSettings exits successfully with only two existing AppSettings documentation notices. No local failure subclasses, FatalLevel enum, old failure factories, local failure imports, or dartz imports remain in Dart source. Broader analysis still fails on unfinished reference application routing/UI blueprint imports and missing Logger `path_provider`; it is not a full application pass. Resolving blueprint failure types also exposes missing `trEx` extension diagnostics from their unchanged reference application localization import. No runtime tests were added or run.

Responsibility review: failure values come from the package; wrappers adapt transport failures without UI or project-wiring dependencies; Logger consumes the same pure failure type through its Domain contract. Existing `core/infastructure/wrappers` spelling/role placement is not declared by the general Infrastructure tree and remains a separate foldering decision, not silently normalized here. Protected presentation blueprints remain unused and retain their pre-existing project-specific integration dependencies. No new AGENTS files or architectural rules were added. Deleted definitions and pre-edit consumers are recoverable in `/tmp/apollo-published-failures-ARIh0m`. reference application and the architecture repository were not changed by this migration.

### Dependency-section normalization: reviewed paths applied, external allowances pending

The developer approved normalizing remaining dependency overrides while preserving intent. Reviewed all 59 production-folder guides across both projects. Removed redundant Shared inheritance sections and ordinary Controller consumer restatements. Replaced reviewed role-folder references with absolute repository-relative paths: named layers use subtree paths; leaf responsibility folders use direct-folder paths. Converted Core exclusions into explicit exclusion paths. Empty feature-documentation dependency lists retain deny-all behavior without a `none` pseudo-path.

Preserved precise entrypoint/caller gates outside directory lists: DI helpers remain private to global App DI; Core Flows remain limited to global routing; Infrastructure implementations remain private to their feature's Infrastructure DI helper; cross-feature shared exports retain their consumer-layer restrictions. App wiring project dependencies inherit the composition default with the existing narrower DI and public-entrypoint rules retained. Apollo's actual App visibility/layout was not replaced by the architecture template's stricter file layout. Existing SDK/GetIt wiring remains governed by root instructions; no new package permission or dependency was invented.

Four canonical outbound sections remain unchanged pending an external-policy decision: Data Source interfaces refer to an unspecified generated API package, DTOs to unspecified serialization libraries, and Formatters/Validators to the Dart standard library. Their project-path and external wording are still legacy and must not be silently interpreted as normalized allow-lists. The question is whether these blueprint roles should inherit project SDK/package policy, with concrete external dependencies declared by the consuming project, instead of granting unnamed package categories.

Verification: 32 of the 36 remaining dependency sections contain only folder paths (or explicit empty deny-all lists); the four deferred outbound sections are identified by the read-only syntax check. Both projects pass `git diff --check`. Production-source paths/content, the 59-guide inventory, and both governing documents are unchanged; only existing guide contents and this progress record changed. No runtime tests or commits were made. Guide backups are at `/var/folders/gb/d8blpv3n759bw5kzlt8p_wf80000gn/T/dependency-path-normalization-uB3sEg`.

### Existing AGENTS declarations aligned with the governing document

The developer requested reflecting the approved declarative foldering rules in existing AGENTS files. Removed the blanket Feature Domain/Core Repository prohibition and redundant default Core structure from both Core guides, retaining the narrower Manager and Core-DI boundaries. Feature Domain guides now inherit general dependencies; removed their generic interfaces bucket and mandatory guide-per-child wording. Canonical Domain Models, Repository contracts, Params, and Use-case contracts no longer repeat dependency lists that exclude Core Domain. Naming and pure-value/contract responsibilities remain intact.

Aligned the existing Data, Infrastructure, Presentation, Controller, feature-root, and Features guides across both projects. Data declares DTOs, mappers, and data-source interfaces, not concrete integrations; Controllers inherit contract/Manager dependencies rather than an implementation import allowance. Infrastructure leaf guides no longer permit App wiring imports. Feature structure includes optional Services and Presentation's screen/sheet/widget folders, without requiring unused layers. Removed the root prerequisite to instantiate every blueprint folder and guide. Updated the existing local template to resolve document defaults first. The existing Apollo Flow guide now uses the established navigation/routing definition, and App permits its corresponding global-routing boundary. No new AGENTS files or source changes were made.

Removed the obsolete Apollo `lib/features/feature_name/data/api/AGENTS.md`, which duplicated the incorrect Infrastructure description and contained no production source, then removed its empty directory. Recoverable copies of changed/removed guides are at `/var/folders/gb/d8blpv3n759bw5kzlt8p_wf80000gn/T/agents-contract-align-uAV13w`. The governing document itself was not changed. Remaining role-specific legacy dependency-list syntax has not been silently converted; this is not a whole-project source-compliance or runtime pass.

Verification: both projects pass `git diff --check`; all 49 production Dart path/content hashes are unchanged, no new AGENTS files were created, and the intended obsolete Data/API guide is the only removed guide. The aligned Core, Flows, Features, feature-root, Domain, Data, Infrastructure, Presentation, and Controller guides match between the two projects. Both governing-document copies still match. Runtime tests were not run for this documentation-only update.

### Declarative foldering document and AGENTS override mechanism

The developer approved the structural model and requested a governing document with AGENTS.md as the scoped override mechanism. Created identical `ai_development/declarative_foldering_rules.md` documents in the architecture repository and Apollo. The document defines ownership/scope, the layer/responsibility tree, Domain interfaces versus Infrastructure implementations, dependency directions, Feature-to-Core Domain access, library independence, import/export checks, and field-scoped AGENTS overrides. Missing guides and omitted sections inherit defaults; no per-object guides are required. Existing canonical Domain roles such as Validators and Formatters remain recognized.

Both root `lib/AGENTS.md` files now load the document first rather than carrying competing general architectural summaries. Retained project-specific development instructions, DI composition rules, and Apollo's AppFailure/StatefulData requirements. No additional AGENTS files, production code, package changes, source moves, or commits were included. Prior roots are backed up at `/var/folders/gb/d8blpv3n759bw5kzlt8p_wf80000gn/T/foldering-contract-wbYnIp`.

Verification: both document copies are byte-for-byte identical, both projects pass `git diff --check`, and all 49 production Dart files match the pre-change path/content snapshot. No AGENTS files were added or removed. Naming and scope checks cover the new snake_case documentation path and root links; runtime tests are not applicable to this documentation-only step.

The document is the default architecture contract. Contradictory historical guides are not automatically approved overrides. Next review and reconcile those existing declarations against it, particularly the blanket Feature Domain/Core Repository prohibition, feature-local Domain visibility inherited into Core, and Apollo's legacy Data definition. Scope-specific intentional overrides must be distinguished from stale repeated defaults before editing; this document creation does not claim full-project compliance.

### Approved root architectural concept and rule authority

The developer located the existing Global Layering Limits Dependency Rules and approved distinguishing ownership, scope, architectural layer, and responsibility at the top of both root guides. Added the same opening concept and authority order to the architecture repository and Apollo: root path interpretation, root global dependency directions, canonical responsibility definitions, and explicit local exceptions/restrictions. Distinguished rule inheritance from code dependencies and exports. No new AGENTS files were created.

Moved each project's existing Domain, Data, Infrastructure, and Presentation dependency directions beneath the opening concept under one `Global Layering Limits Dependency Rules` heading. Removed the competing App/Core summary and Apollo's obsolete four-layer enumeration; retained the existing Shared-modifier rule and other specific rules. Existing dependency permissions were preserved, apart from whitespace cleanup. This is a concept/authority consolidation, not approval of a new dependency matrix. No production code, library source, package dependency, or registration changed. Root-guide backups are at `/var/folders/gb/d8blpv3n759bw5kzlt8p_wf80000gn/T/architecture-concept-pePbzX`.

Next compare the existing declarations against this source-of-truth structure and discuss concrete contradictions before correcting them: feature Domain access to Core Domain, older Core Repository consumer restrictions, and Apollo's legacy Data rules versus the newer architecture blueprint. Do not invent another Core Domain layer or add per-folder guides to resolve these conflicts.

### Approved Session ownership move into Core

The developer selected project Core ownership for AppSession rather than a reusable Session library and explicitly authorized the move. Replaced the three existing export-only Core files with the Session source: `lib/core/domain/repositories/i_app_session_repository.dart`, `lib/core/domain/params/app_session_params.dart`, and `lib/core/infrastructure/repositories/app_session_repository.dart`. Removed the former library copies and their empty directories. Settings remains reusable in `lib/libs/app_settings`; Session now consumes its existing Core Domain exports. Core DI already used the destination entrypoints, so registrations and runtime behavior are unchanged. No Manager or AGENTS file was added, and no architecture-rule change was included.

Exact-content verification confirms the contract is unchanged and the parameters/implementation differ only in their relocated Settings import paths. Existing comments, including the original Session class comments, are preserved verbatim. No Dart import/export references the retired Session library path. Scoped analysis of Core parameters, models, repository contracts and implementations, and the Settings library exits successfully with no errors or warnings; only the two existing Settings documentation notices remain. No runtime tests were added or run. Original source and export files are recoverable from `/var/folders/gb/d8blpv3n759bw5kzlt8p_wf80000gn/T/apollo-session-move-Caq0mu`. No Git commit was made.

The separate clarification that feature Domain may consume Core Domain while Core Domain must not depend back on features or higher layers remains pending rule alignment; the previous Core guide still contains the older feature-Domain restriction. Do not treat this source move as a full dependency-policy compliance pass.

### Approved Core root-scope rules and declaration cleanup

The developer approved the exact App/Core general-rule wording and authorized updating both Apollo and the architecture repository, removing redundant declarations, and creating no additional AGENTS files. App owns composition and startup wiring; Core is the app-wide root scope with Domain, Data, Services, Infrastructure, Presentation where needed, Managers, and Flows. Core exports follow layer/responsibility paths without library-name nesting. Cross-library dependencies follow general layer boundaries; libraries do not depend on project wiring. The prior Shared-only Manager placement, Abstractions guide, flattened library-layout exceptions, and library-name-nested Core exports are superseded.

Applied the approved wording to both roots. Aligned the existing Core, Service, Libraries, and Shared guides; updated existing feature-blueprint and template references from Shared Managers to Core Managers and from Abstractions to Domain. Retained feature isolation, Core Repository contract-versus-implementation boundaries, protected Shared blueprints, and explicit-approval safeguards. Removed twelve obsolete or repetitive guides: the architecture Abstractions guide, six Shared/Core hierarchy guides across both projects, and five Apollo library guides. The Shake root guide retains only its detector/callback policy boundary. No new AGENTS files or production-source changes were made in this rule-cleanup step. Backups of the prior guides are at `/var/folders/gb/d8blpv3n759bw5kzlt8p_wf80000gn/T/core-rule-cleanup-PRr0Wq`.

Verification: both projects pass `git diff --check`; no new AGENTS files were added, and active rules/templates no longer reference the retired Shared Manager/Repository hierarchy, Core Abstractions, or the intermediate-Core exemption. Core, Service, Libraries, and Shared guides match across the two projects. Dart content hashes match the pre-cleanup snapshot; a concurrent developer move of the errors API-wrapper file was observed and left untouched. All twelve removed guides have recoverable backup copies. No runtime tests were run for this documentation-only change.

The earlier relocation import/export repairs remain separate from this documentation-only step. The two projects still have legacy dependency-list syntax and other unmigrated source; this cleanup does not claim a full-project compliance or runtime pass. Next review remaining source placement and dependencies against the approved general Core model, without generating per-object guides.

The developer explicitly selected changing disposal behavior rather than rewriting the original AppSession comments. `dispose()` now invalidates the current scoped cache, awaits `IAppSettingsRepository.clearSession(currentId)`, and closes only after cleanup succeeds. Cleanup failure is returned as a contextual AppFailure, emitted through StatefulData Failure with the previous ID, and leaves the repository open for retry; partial deletions cannot be rolled back. Disposal before an active session is available closes without targeting any unknown persisted session. Repeated successful disposal remains idempotent, and mutation ordering is unchanged. Global persisted settings, including the stored identity key, are not deleted; this change targets only the current session namespace. Updated the interface documentation to match; preserved the original class comments verbatim. Earlier preservation-only disposal entries below are superseded. No global clear operation, AppSettings implementation change, or architecture-rule change was made. Runtime deletion/failure tests remain unrun under the existing approval policy; the previous folder-permission wording and Core DI audit findings remain open.

Added the developer-requested comment-preservation rule to Apollo's root `lib/AGENTS.md`: existing comments, particularly those not authored by the agent, must not be removed, rewritten, or translated without explicit approval. Report outdated comments rather than silently changing them; English-language conventions do not authorize rewriting historical comments. Restored the two original AppSession class comments verbatim. No executable code changed. The restored comment says closing/renewing removes session data, whereas current disposal preserves persisted data; this mismatch is recorded for discussion, not silently corrected in either code or comment.

### StatefulData package correction

The developer rejected both the generated AppSessionState lifecycle hierarchy and the old Resource type, explicitly selected the published stateful_data package, and provided its usage instructions. Saved the supplied text byte-for-byte at `ai_development/stateful_data_usage_rules.md` and added the direct usage requirement/reference in Apollo's `lib/AGENTS.md`. The rule applies to single-value data lifecycles, not replacement of screen/Controller states. This is an Apollo package-selection rule; no unrelated architectural repository rules were changed.

Resolved stateful_data 1.0.7 from pub.dev. Inspected its published source: `stateful_data.dart` exports pure Dart types; Flutter builders have a separate entrypoint and are not imported into Domain. The lockfile comparison shows stateful_data is the only added package and no existing resolved packages changed. Package source: https://pub.dev/packages/stateful_data.

Removed the generated `domain/models/app_session_state.dart`. AppSession's snapshot and broadcast stream now expose `StatefulData<String, AppFailure>`. Initialization transitions through Loading to Ready or Failure; renewal uses Updating and emits Failure with its previous session ID on error. Previous IDs are consumed only through explicit Failure-with-previous matching, not implicit nullable extraction. Initialization can retry a Failure by reading storage again. Disposal emits Empty (no active in-memory session) and closes the stream; repository disposal is tracked by the controller's actual closed status, not a custom data variant or new lifecycle flag. AppResult remains the operation success/failure contract alongside the StatefulData lifecycle snapshots.

Cached parameter values also use StatefulData: Ready values remain readable, a persisted write marks only its own cache entry Updating, and completion invalidates that entry so subsequent reads use canonical storage values. Writing one parameter no longer marks the session ID Updating or blocks reads of unrelated parameters. All seven package variants are explicitly handled in lifecycle switches. Session scope separation, mutation ordering, failure chains, and non-transactional renewal limitations remain unchanged. No DI registration or AppSettings implementation changed in this correction.

Verification: attachment/file cmp passes; scoped AppSession analysis has no findings; AppSession plus App DI-helper analysis passes; formatting and git diff --check pass. No production AppSessionState/Resource/reference application references remain in this library. Naming, pure-Domain imports, both dependency directions, and the scoped rule-change review pass. Runtime tests were not added or run under the existing approval policy. Earlier custom-state decisions below are historical and superseded by this correction.

### AppSession completed implementation for review

The developer explicitly delegated the remaining AppSession implementation decisions and requested a finished result rather than separate approvals for each source change. This supersedes the pending parameters-import, Resource/UUID, and session-behavior decisions below for this module only; it does not authorize new architecture rules or unrelated migrations.

AppSession now has a pure Domain interface (`IAppSessionRepository`), typed Domain parameters (`AppSessionParams` and concrete `*Params` declarations), a Domain state model, and the library-owned Infrastructure implementation. Parameter imports target AppSettings Domain values; storage depends only on `IAppSettingsRepository`. Removed the reference application Resource dependency instead of importing its Flutter and legacy-error coupling or starting another reusable-library migration. The four explicit snapshot states are Uninitialized, Ready, Updating, and Closed. The broadcast stream reports changes without replay; `state` supplies the current snapshot. No Shared exports or new AGENTS files were needed, and no architecture rules changed.

Initialization returns AppResult<String>, restores existing IDs, is idempotent, and creates an ID only when the stored identity is absent or empty using an explicit empty-string default. Read failures are preserved rather than being treated as missing sessions. All failure-capable public operations return AppResult, keep layer context and cause, and do not log or decide UI policy. Initialization failures retain app-fatal severity. The global sessionId key is repository-owned metadata, not an ordinary session parameter.

Writes, initialization, renewal, and disposal are ordered through one mutation queue. Reads return failure before initialization, during persisted updates/renewal, or after disposal. Cache keys distinguish session scope, global scope, and memory-only versus persisted access. Nullable memory values remain valid. Memory-only parameters read their defaults without touching storage. Persisted writes invalidate cache and await storage; they never cache an uncommitted caller value, and later reads observe AppSettings' existing null normalization. Removed unused integer/boolean constructor parameters.

Renewal invalidates the old scoped cache, awaits deletion of old scoped storage, persists the new UUID, updates the active ID, and emits state. Global values survive renewal. Cleanup/persistence failure returns a contextual failure and does not publish a new active ID; partial old-data deletion is not rolled back because SharedPreferences is not transactional. Disposal is idempotent, ordered after pending writes, closes notifications, clears memory, and preserves persisted storage.

Core DI now registers IAppSessionRepository directly from the library, waits on IAppSettingsRepository, bridges initialization failure to GetIt's failed async registration, and supplies disposal. Added uuid ^4.6.0 and get_it ^8.2.0, retaining reference application's GetIt major version. Pub get resolved uuid 4.6.0 and get_it 8.3.0 plus crypto/fixnum; comparison against the pre-job lockfile confirms no existing resolved packages changed. Package references: https://pub.dev/packages/uuid and https://pub.dev/packages/get_it.

Verification: scoped AppSession analysis passes with no findings. Combined AppSession/AppSettings/App DI-helper analysis has zero errors or warnings and only the two pre-existing AppSettings documentation notices. Analysis of the complete Core DI file still reports 79 findings in the unmigrated reference application graph; none are in the changed AppSession registration block, and GetIt now resolves. Direct comparison confirms all other Core DI registrations are unchanged. Naming, responsibility, outbound/inbound dependency, approval-scope, and protected-source reviews pass for the AppSession changes. reference application's three source hashes remain unchanged. No runtime tests were added or run under the existing ask-before-tests policy; runtime session failure/concurrency paths and full-app startup are not verified. Next review this implementation with the developer and decide whether to add focused lifecycle/cache/DI tests before continuing the migration.

AppSession copy and approved adaptations are applied. Copied all three reference application session files unchanged first; `cmp` and SHA-256 verified the contract (`dc127f2eeb358807e432fe91f2cbd63447dfce5077a70f590522ebf9cba8216a`), implementation (`52af72f7a59dc598237811e3a93a61b5017118cdba0d683d3c68336ec2dd3517`), and parameters (`83d2a5703775924146bf6a2e707623286f357856a1f16cb352bba457540a00fb`). Then renamed the contract/file to `IAppSessionRepository`/`domain/repositories/i_app_session_repository.dart` and implementation/file to `AppSessionRepository`/`infrastructure/repositories/app_session_repository.dart`. Replaced dartz and legacy failure usage with the already installed published app_failure API, including success-first fold callbacks and lowercase repositoryFailure factories. Updated same-library contract/parameter imports and changed the implementation's storage dependency to `IAppSettingsRepository`, imported directly from AppSettings Domain. Exact-content comparison confirms only those substitutions plus the implementation's final newline changed. Existing branches, memory behavior, renewal behavior, diagnostics, initialization throws, and method parameter signatures remain unchanged.

The copied `domain/params/app_session_params.dart` remains byte-for-byte unchanged pending discussion: it imports the old concrete settings file solely for `SettingsKey` and `SettingsKeyType`; the proposed correction is to import the existing AppSettings Domain model files instead. Resource's reference application imports and UUID remain unresolved for the separately requested dependency review; neither dependency was copied, replaced, or added. Scoped AppSession analysis reports 33 errors and nine informational findings from the unresolved parameters/Resource/UUID dependencies and inherited missing override annotations. This is not a compile, naming, failure-flow, or full architectural compliance pass: singular Param declarations, initialization failure propagation, and other behavior remain for separate review. No DI, Shared exports, AGENTS files, existing AppSettings source, or package files changed. No runtime tests were added or run. Next discuss the parameters' Domain-value imports, then Resource and UUID, then the session behavior review before DI integration.

Applied the approved AppSettings DI adaptation in `lib/core/core_di.dart`: replaced the old settings import with direct library contract and implementation imports, registered `AppSettingsRepository` as `IAppSettingsRepository`, and changed this file's AppSession lookup and AppSession/RestApiClient readiness dependencies to the interface type. SharedPreferences initialization and registration ordering are unchanged. Exact-content comparison confirms only the approved imports and settings-type substitutions changed; no other registration, library implementation, manifest, or rule file was modified. Analysis including Core DI remains blocked by missing GetIt and unmigrated reference application dependencies, including AppSession; runtime DI readiness and AppSession constructor compatibility are not verified. Next review the AppSession source inventory before proposing its unchanged copy.

Applied the approved direct-library-import rule correction in Apollo and the architecture repository. Architectural paths inside Libraries and Shared retain their scope, layer, responsibility, and both dependency directions. Unchanged libraries require neither Shared copies nor mirrored re-exports; Shared is used for project-specific adaptations. Removed mandatory Core-export access restrictions from the Logger, Haptic, and Shake guides so the corresponding architectural rules govern consumers. Protected integration blueprints remain unavailable for direct production imports. Existing exports, source files, package dependencies, and DI registrations are unchanged. The proposed AppSettings Shared export files were not created. Next review AppSettings DI integration using its library entrypoints directly; implementation changes still require separate approval.

Applied the separately approved fail-fast clearSession behavior: if `_prefs.remove(k)` returns false, throw a RepositoryFailure with the failed key and stop the loop. The existing same-function catch preserves that failure as cause and returns AppResult.failure with clearSession context. Removals completed before the failure are not rolled back; no successful partial count is returned on failure. Exact-content comparison verifies only this removal-result handling changed. Scoped analysis has zero errors or warnings and the two existing documentation notices; `git diff --check` passes. No runtime tests were added or run, and no Shared exports or DI wiring changed.

Applied the separately approved failure-classification fix in AppSettings.newSession: replaced its single `AppFailure.apiFailure(...)` call with `AppFailure.repositoryFailure(...)` for a local persistence operation returning false. Exact-content comparison verifies this factory-name substitution is the only implementation change. Scoped AppSettings analysis has zero errors or warnings and the two existing documentation notices; `git diff --check` passes. The inherited clearSession behavior still skips removals returning false and returns a successful partial count. Next decide that behavior separately; no change to deletion semantics was included.

Applied the separately approved direct SharedPreferences dependency declaration, `shared_preferences: ^2.5.3`, matching reference application's source constraint. Pub get completed successfully: the existing resolved version remains 2.5.5, now marked direct main instead of transitive. No package version upgrade or implementation change was included. Scoped `dart analyze lib/libs/app_settings` exits successfully with zero errors or warnings; only the two inherited namespace-documentation notices remain. `git diff --check` passes. Next review remaining failure-handling and behavior concerns before Shared exports and DI integration; do not treat successful analysis as full runtime or architectural verification.

Applied the separately approved migration of AppSettings' interface and implementation to the published app_failure 1.0.1 API. Both files import `package:app_failure/app_failure.dart`; removed their dartz and copied-errors imports. Replaced `Either<AppFailure, T>` result forms with `AppResult<T>`, `Right` with `AppResult.success`, and `Left` with `AppResult.failure`. Existing RepositoryFailure and ApiFailure factory calls use the package's lowercase factory names. The existing ApiFailure branch in newSession was preserved rather than changing failure classification without approval. Storage calls, branching, defaults, namespace construction, removal counts, method parameters, and diagnostic-message arguments are unchanged. No other module's failures, logger, DI, Shared exports, package versions, or rule files were changed.

Verification: exact-content comparison confirms changes are limited to the approved API substitutions/imports. No dartz, Either, Left/Right, legacy errors import, or uppercase failure-factory reference remains in AppSettings. Scoped `dart analyze lib/libs/app_settings` exits successfully with zero errors and warnings and three informational findings: SharedPreferences remains transitive-only, and the inherited namespace documentation has two angle-bracket notices. Interface conformance now resolves. `git diff --check` passes. No runtime tests were added or run. Next separately approve the direct SharedPreferences declaration; documentation cleanup, the inherited ApiFailure classification, and remaining behavior review are separate decisions before integration.

The developer rejected dartz and selected the latest published app_failure package, explicitly excluding local-path and Git dependencies. Queried pub.dev's package API: latest published release is 1.0.1. Added the hosted dependency `app_failure: ^1.0.1`; `flutter --suppress-analytics pub get` completed successfully and reported exactly one added dependency, app_failure 1.0.1. The lockfile records pub.dev as source and SHA-256 `09e2bf2ecab4867b6d4618e7d90d38fb892443f782924f08df998a189cdf6a39`, matching the registry metadata. Inspected the fetched published source, not the local working copy: it exports AppResult, AppSuccess, AppFailureResult, and AppFailure. No dartz dependency or local/Git override was added. The existing AppSettings source still uses the previous result types; next separately approve migrating both its interface and implementation to the published AppResult/failure API. Do not mix the new package's failure type with copied legacy errors or migrate logger/global handlers implicitly. SharedPreferences' direct dependency declaration remains a separate pending item.

Applied the separately approved interface connection: added `domain/repositories/i_app_settings_repository.dart` with the four existing public signatures, added `implements IAppSettingsRepository` and four `@override` annotations, and replaced the implementation's reference application error import with the same relative errors-library import used by the interface. Exact-content comparison verifies all implementation signatures, method bodies, diagnostic strings, and existing value types are unchanged. The interface exposes no SharedPreferences type. No rule files, package declarations, Shared exports, or DI registrations changed.

Scoped `dart analyze lib/libs/app_settings` reports 31 errors and five informational findings. The errors are the two unresolved dartz imports and downstream Either/Left/Right resolution failures; dartz is not declared or resolved in Apollo. Information includes missing direct declarations for dartz and shared_preferences and two inherited documentation-comment notices. No interface-override error was reported, but full conformance remains unverified while dartz types are unresolved. `git diff --check` passes. Next propose declaring and resolving the existing package dependencies; do not add them without approval.

Applied the separately approved value-declaration extraction: moved `SettingsKey<T>` unchanged into `lib/libs/app_settings/domain/models/settings_key.dart` and `SettingsKeyType` unchanged into `settings_key_type.dart`. Added the same-folder enum import in the key file and the two relative Domain-model imports in `AppSettingsRepository`. Exact-content comparison confirms no declaration, constructor, repository method body, default, or diagnostic string changed. The dependency direction is Infrastructure to same-library Domain models, and model to same-folder model; neither model imports storage, project code, or an external package. No AGENTS files, Shared exports, DI registrations, package changes, or reference application edits were included. Scoped `dart analyze lib/libs/app_settings/domain/models` reports no issues. The repository's existing reference application error import and the missing interface remain unresolved. Next propose the `IAppSettingsRepository` interface and matching implements declaration separately.

Applied the separately approved naming adaptation: moved `lib/libs/app_settings/infrastructure/repositories/app_settings.dart` to `app_settings_repository.dart` and renamed only the class and constructor to `AppSettingsRepository`. Imports, settings key declarations, method bodies, and diagnostic strings remain unchanged. Existing copied DI references still target the old reference application module and were not migrated. No interface, model extraction, package change, Shared export, or additional rule file was included. Next review moving the two settings key/value declarations to Domain models; that source change still requires separate approval.

Current CD-005 progress: copied the complete one-file AppSettings source unchanged from `reference_app/lib/libs/app_uikit/core/settings/data/datasources/local/app_settings.dart` to `apollo1/lib/libs/app_settings/infrastructure/repositories/app_settings.dart` after explicit copy approval. `cmp` confirms byte-for-byte equality; both SHA-256 values are `720b25b2de09b023c4edec43abab1b8f9c50bbd2b5cd6cc5c0acc5b7ef87f72e`. No AGENTS files, interfaces, exports, packages, or registrations were added. reference application remains unchanged and the new Apollo path has no runtime importers. This is an unintegrated review baseline, not a compliance pass. No analyzer or runtime test was run at this copy-only step; the inherited reference application import and remaining design issues are intentionally unresolved.

Next source-change proposal: rename only the file to `app_settings_repository.dart` and its class/constructor from `AppSettings` to `AppSettingsRepository`, preserving imports, key declarations, method bodies, and diagnostic strings. Await explicit approval before applying it. Afterward review key/value extraction, the Domain interface, import corrections, genuine dependency exceptions, and compliance before Shared exports or DI integration. Earlier entries below are historical planning context; their superseded per-folder guide workflow must not resume.

Saved the explicitly approved AppSettings contract-folder declaration at `lib/libs/app_settings/domain/repositories/AGENTS.md`, unchanged from the reviewed draft. It permits the settings models and errors/core folders, declares `dart:async` and `dartz` separately, and names the library implementation, AppSession implementation, and matching Shared export folders as consumers. This approval covers the rule file only: no interface source, package dependency, implementation, or DI registration was created or changed. Library-root and Domain-parent declarations, the models boundary, counterpart permissions, and source-copy approval remain pending before implementation. Next review the settings key/value model folder.

Added a separate `External Dependencies` section to the architecture template, with matching instructions in both root guides. It lists exact SDK import URIs and package names separately from folder-only dependency lists. This changes declarations only; it does not add packages or approve AppSettings' concrete dependencies. Existing guides still require explicit conversion. Next complete the AppSettings folder declaration with its exact library paths and external dependencies for approval.

Approved folder dependency notation is now recorded in the architecture template and both root guides: exact folders are direct-only, a trailing `/*` includes the folder and all descendants, and `!` excludes a folder or subtree. Dependency lists contain paths only. Exclusions win within a governing list; a separately declared more-specific folder rule replaces the broader list for its subtree independently in each direction. Both dependency directions and entrypoint restrictions still apply. Legacy lists require explicit review rather than silent reinterpretation. The template examples were converted, but existing folder lists, source files, and registrations were not changed. Matching policy text and `git diff --check` were verified in both repositories. The AppSettings draft must use this notation before approval and writing.

Continue CD-005 using the existing blueprint and general layer rules first. Review only genuine uncovered Core Repository or external-dependency differences, then present the unchanged AppSettings source-copy inventory for approval. Do not resume per-folder guide generation. Review AppSession separately afterward. CD-004 token storage is deferred; removing its copied DI references still requires approval. CD-003 remains inactive pending callback/lifecycle decisions. Other Core registrations, feature/App policy separation, GetIt, and package identity migration remain pending.
