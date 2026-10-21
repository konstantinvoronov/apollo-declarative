# Bottom-Sheet Implementation Plan

Current example feature (renamed with developer approval on 2026-10-21): lib/features/about_apollo, AboutApolloScreen/Cubit/State, and /about-apollo/legacy-sheet and /about-apollo/alternative-sheet. Earlier Hello Apollo names and paths below remain historical migration evidence. Current specifications live in lib/features/about_apollo/ai_development.

## Task and approval

Include both Uber Babysitter bottom-sheet approaches in Apollo: the AppModalBottomDialog family and AlternativeModalSheetPage. The developer approved this staged plan on 2026-10-20 and requested context-checker review at each stage. The separately approved 47-file unchanged copy and dependency setup are complete. Adaptations and example wiring receive their own exact-scope approvals.

Source project: `/Users/konstantinvoronov/AndroidStudioProjects/uber_babysitter_app`. Target: `/Users/konstantinvoronov/AndroidStudioProjects/apollo1`. Footunion supplies comparison evidence; Uber Babysitter supplies the selected implementations. Apollo's local harness and declarative rules govern target placement.

## Architectural intent

The reusable sheet family belongs to library-owned Core Presentation. Modal widgets render surfaces; Page adapters construct presentation routes; configuration values describe presentation. Concrete product content stays in its feature. Feature presentation/routing.dart owns sheet construction; App composes the public feature entrypoint.

Existing navigation mixins, themes, sizing, and flexible layouts are reuse candidates. Domain, Data, Infrastructure, and startup remain outside this presentation task. Additional layers enter the proposal only when an actual responsibility requires them.

## Stages and progress

| Stage | Deliverable | Status | Context check |
|---|---|---|---|
| 1. Inventory and placement | Complete source inventory, role/path profiles, and proposed application-file copy map | REVIEWED; dependency copy scope continues in Stage 2 | HEALTHY for inventory/placement; integration unverified |
| 2. Dependencies | Compatible modal_bottom_sheet and sheet integration, dependency destination, and license/test-file scope | RESOLVED; approved manifest setup complete | HEALTHY for dependency setup; target pub resolution passed; runtime unverified |
| 3. Unchanged copy | Approved full copy set with byte-for-byte verification | COPIED_UNMODIFIED; 47/47 files match | HEALTHY for unchanged-copy scope; compilation/runtime unverified |
| 4. Legacy adaptation | AppModalBottomDialog family connected to Apollo | ADAPTED; approved substitutions applied; behavior review retained | HEALTHY for scoped adaptation; analysis has zero errors; runtime unverified |
| 5. Alternative adaptation | Snapping/expansion/scroll behavior connected to Apollo | ADAPTED; diagnostics import/wrapper removed | HEALTHY for scoped adaptation; analysis has zero errors/warnings; runtime unverified |
| 6. Working examples | Approved minimal examples, route inputs, result/cancel handling, and feature documentation | IMPLEMENTED; feature spec/plan/history added; diagnostic-spec text awaits approval | HEALTHY for implemented scope; scoped analysis passes; runtime unverified |
| 7. Verification and closure | Recorded evidence, limitations, and finalization audit | Pending | Pending |

Use Apollo's local context-checker on each stage's proposal before edits. Resolve confirmed context corrections, present the exact scope for approval, perform approved work, and record the result. A healthy context report establishes only that stage's supported context coverage; technical verification is recorded separately. This is the developer-requested workflow for this task.

### Stage 1 — Inventory and architectural placement

The following copy destinations are proposals. Original source files remain intact during intake; any later split, rename, or behavior change is discussed after copying.

All source paths below are relative to Uber Babysitter. Destinations are relative to Apollo.

| Source | Proposed unchanged-copy destination | Declarations and roles |
|---|---|---|
| lib/src/App/Core/widgets/app_modal_sheet.dart | lib/libs/uikit/core/presentation/sheets/app_modal_sheet.dart | AppModalBottomDialog and AppSheet: concrete modal widgets; DialogShape: clipping helper; ModalSheetPage: route Page adapter; ModalSheetConfig: Presentation configuration value |
| lib/src/App/Core/widgets/alternative_modal_sheet_page.dart | lib/libs/uikit/core/presentation/sheets/alternative_modal_sheet_page.dart | AlternativeModalSheetPage: concrete route Page adapter; private surface widget and scroll behavior remain implementation helpers |
| lib/sheet/ | packages/sheet/; all 45 tracked source-package files proposed | Separate third-party Flutter package; 15 library files, 23 existing test files, 7 support files; artifact folders remain outside the copy set |

Resolver profile: UIKit ownership; library-wide Core scope; Presentation layer. These declarations render/configure sheets rather than own business operations. Public sheet widgets and Page adapters expose the reusable family; underscore-prefixed helpers remain private. No supporting role adds a layer or changes dependency permissions.

Permitted outbound project dependencies are corresponding UIKit Presentation declarations, such as `/lib/libs/uikit/core/presentation/models/*`, `/lib/libs/uikit/core/presentation/widgets/*`, and same-family files. App routing/DI access, if a later approved adaptation requires it, is evaluated against the explicit Presentation permissions at both endpoints. External dependencies are Flutter/Dart, modal_bottom_sheet for legacy routes, and sheet for alternative routes. Source kiddodo_app imports remain unresolved until separately approved adaptation.

Permitted inbound consumers include matching Core/Shared/feature Presentation paths and approved App routing composition. App reaches feature content through `/lib/features/<feature>/presentation/routing.dart`; it may construct generic presentation adapters. Domain/Data/Infrastructure remain outside this family’s consumer boundary. Feature-specific content and repository dependencies stay outside reusable UIKit source. Resolver result: RESOLVED for the proposed application-file intake; dependency placement remains open in Stage 2.

Snapshot SHA-256 values, 2026-10-20:

- app_modal_sheet.dart: `7bed5e54c1cafe482f771ca21854bc8cd55e74dc00977cdd7276249c27fa6a22`
- alternative_modal_sheet_page.dart: `595bcd66dbe59bc64b9a0185c2044fcefe5cf60e07ef416c3453064596de8fd5`
- alternative_modal_sheet_diagnostics.dart (inspected reference, excluded from copy): `3eb2c8b38dc82e12470a9fba4ba551f1bd92e0a99ed44fb05dcfea0033770242`
- sheet/pubspec.yaml: `9e8ab9ef0dff29e01a89e6ffb228f4cdc1e487e3b8a7fac933513e88c52062b6`

Source pubspec.yaml has an existing developer modification. Preserve it and recheck source hashes before any copy. Apollo has unrelated uncommitted scaffold/native-identity work; preserve that work independently.

### Stage 2 — Dependency decisions

The source package declares Dart >=2.17.0 <3.0.0 while Apollo uses Dart 3.10.8. Dart pub reinterprets this null-safe SDK range as allowing Dart 3; its upper bound alone is not a compatibility blocker. Preserve the source manifest during intake. Source/API compatibility and fresh target dependency resolution are separate checks. See [Dart 3 migration guide](https://dart.dev/resources/dart-3-migration#dart-3-backwards-compatibility).

Propose the external package destination and exact file set, preserving its MIT license and attribution. A project-local vendored dependency is a candidate; its directory and manifest connection require approval. Select modal_bottom_sheet's compatible version with the source API in view. Runtime development in Apollo should use target-owned dependencies after integration.

The developer chose the sheet implementation without AlternativeModalSheetDiagnostics. Copy only the two selected application files. Preserve alternative_modal_sheet_page.dart unchanged during intake and record its temporarily unresolved diagnostics import. During Stage 5 adaptation, remove that import and render the child directly inside the existing ScrollConfiguration. Its current debug collector remains reference evidence only. Existing dependency tests are inventoried separately; test copying/execution and newly authored tests receive explicit developer decisions.

Exit: complete dependency/source copy map, compatibility assessment, and exact proposed manifest changes. Run context-checker before copy approval.

#### Stage 2 findings and proposed dependency layout — 2026-10-20

Legacy dependency: propose the hosted stable modal_bottom_sheet 3.0.0, pinned for this intake. Uber Babysitter resolves that exact release. Its cached published manifest permits Dart >=3.3.0 <4.0.0, and its exported ModalSheetRoute/showMaterialModalBottomSheet APIs match the selected legacy file. See [release metadata](https://pub.dev/packages/modal_bottom_sheet/versions/3.0.0). Root pubspec/pubspec.lock remain unchanged during this review.

Alternative dependency: propose the existing customized sheet package at `packages/sheet/`, consumed through `package:sheet/sheet.dart` and `package:sheet/route.dart`. This is an external Flutter dependency package with its own manifest/license, separate from Apollo's UIKit presentation adapters. Preserve its package name and source layout. Current runtime imports use Flutter/Dart and the package itself; the package does not import Uber Babysitter application source.

The local package contains required behavior changes: resizable/minResizableExtent in the route/page API, configurable snapSpring, and snapToDragDirection coordinated with inner scroll handling. Git commit d87f047 records the route/physics/scroll-controller changes, and AlternativeModalSheetPage directly supplies resizable, snapSpring, and snapToDragDirection. The [hosted SheetPage API inspected](https://pub.dev/documentation/sheet/latest/route/SheetPage-class.html) does not expose those same constructor parameters; preserve the local implementation rather than assuming a hosted replacement is equivalent.

Proposed dependency declarations, applied only after the unchanged-copy step and separate approval of dependency setup:

```yaml
  modal_bottom_sheet: 3.0.0
  sheet:
    path: packages/sheet
```

Complete Stage 3 copy proposal: the two application files in the Stage 1 table plus all 45 tracked files under source `lib/sheet/`, mapped by identical relative path into target `packages/sheet/`. This totals 47 files. The dependency set is exactly its 15 library files, 23 existing tests, and seven support files: `.gitignore`, `CHANGELOG.md`, `LICENSE`, `README.md`, `analysis_options.yaml`, `pubspec.lock`, and `pubspec.yaml`. Preserve existing dependency tests as source history; their execution and newly authored tests receive separate approval. Preserve MIT attribution. Recheck the complete file list and per-file hashes before copying. Source-local `.dart_tool`, build output, and nested repository metadata are outside this tracked copy set. The application diagnostics file remains excluded.

Verification evidence: ran Apollo's Dart 3.10.8 analyzer against the existing local package using its existing package configuration, whose Flutter path matches Apollo's SDK. Package library analysis: zero errors/warnings and 16 informational notices, including deprecated APIs. The two selected application files: zero errors, five existing legacy unused-variable warnings, and 15 informational notices; the alternative page has no reported finding. These commands inspect the source project and do not establish fresh Apollo pub resolution, build success, or gesture correctness. No tests were run. Source package/application hashes remain unchanged; the source root pubspec retains its pre-existing developer modification.

#### Context-checker result — Stage 2

Task/stage: dependency investigation and exact copy proposal for the selected Apollo Presentation part. Observed context includes the local context-checker, target harness/ancestor guides and plan, source package manifest/configuration/public APIs/license, package Git changes, source application imports, exact tracked inventory, analyzer results, and official Dart/package documentation. The dependency package is framework-only and separate from App/feature content; its application-facing integration remains in UIKit Presentation.

Interpretation correction: the original SDK upper-bound concern required checking Dart pub's null-safe compatibility rule. That check corrected the assumption; the proposal preserves the source SDK constraint. Existing source dependency resolution is evidence of source configuration, rather than proof of fresh target resolution. A hosted version number alone does not establish equivalence to the customized local API.

Confirmed missing context: none identified for the supported dependency/copy proposal. Unnecessary context: none identified in this scoped investigation. Unverified coverage: fresh target dependency resolution, builds, runtime sheet/scroll interactions, and back/keyboard behavior. Context-checker performed a read-only self-review; no separate reviewer execution or hidden-context claim is asserted.

Result at review: HEALTHY for Stage 2's proposed scope after the SDK-interpretation correction. The developer subsequently approved the dependency destination and 47-file copy set; dependency installation and adaptations retain their later approval boundaries.

### Stage 3 — Copy unchanged

After exact-copy approval, copy the complete selected set and verify each file against the source snapshot. Preserve original comments, declarations, imports, and formatting. Record expected unresolved dependencies and compare source changes before proceeding to adaptations.

#### Stage 3 result — 2026-10-20

Copied the two application files to `lib/libs/uikit/core/presentation/sheets/` and all 45 approved tracked package files to `packages/sheet/`. All 47 destinations match their sources byte-for-byte. Source hashes match the pre-copy snapshot. Package documentation, MIT license, existing tests, comments, and formatting are preserved; the destination package contains exactly 45 files.

Apollo's root pubspec.yaml, pubspec.lock, and lib/main.dart match their pre-copy hashes. AlternativeModalSheetDiagnostics remains excluded; the copied alternative page retains its original unresolved diagnostics reference for Stage 5. Legacy kiddodo_app imports and pending dependency registration remain adaptation/integration work. No formatting, dependency resolution, builds, or test execution were performed. git diff --check passes for tracked changes.

Context-checker: the approved copy set, source inventory, source hashes, destination paths, target library/ancestor rules, local harness, governing foldering document, and planning rules cover this stage. Observed checks confirm copy identity and preservation boundaries. Confirmed missing context, unnecessary context, and interpretation conflicts: none identified for this copy. Target compilation and runtime behavior remain unverified. This is a read-only self-review using Apollo's local skill, with no separate reviewer execution or hidden-context claim.

Result: HEALTHY for Stage 3's approved unchanged-copy scope. Next: approve the exact dependency setup from Stage 2, then proceed to the Stage 4 legacy-adaptation proposal.

#### Approved dependency setup result — 2026-10-20

Added modal_bottom_sheet 3.0.0 and the path dependency `sheet: packages/sheet` to Apollo's root pubspec.yaml. Flutter pub get --offline completed successfully using the existing cache. The lockfile adds exactly these two dependencies; every existing package entry is unchanged. Generated package configuration resolves modal_bottom_sheet to its cached 3.0.0 release and sheet to Apollo's own packages/sheet, retaining Dart language version 2.17 for that package.

The copied 47 files and lib/main.dart retain their pre-resolution hashes. Tracked generated platform files are unchanged by resolution; git diff --check passes. Verification covers dependency resolution, with application compilation, runtime behavior, and tests reserved for subsequent approved stages.

Context-checker: the developer's exact dependency approval, Stage 2 package/API evidence, local harness and foldering authority, current target/source manifests, and before/after lockfile evidence cover this setup. Confirmed missing context, unnecessary context, and interpretation conflicts: none identified for the supported scope. Application imports and the excluded diagnostics reference remain planned adaptations rather than dependency-resolution failures. Result: HEALTHY for approved dependency setup; sheet runtime behavior remains unverified. Review used Apollo's local read-only skill as a self-review.

Next: Stage 4 legacy-adaptation review and exact change proposal.

### Stage 4 — Legacy adaptation

Review AppConsts/AppTheme/AppElement against Apollo's existing sizing, theme, and marker declarations. Propose exact substitutions or marker decisions. Preserve both routed and imperative entrypoints initially. Present behavior decisions individually: routed dismissible is currently ignored; title rendering is commented out; legacy padding/backSupport behavior needs explicit review. Approval determines each adaptation and any file separation.

#### Stage 4 review and exact proposal — 2026-10-20

Principal responsibility: render reusable modal surfaces and construct their Presentation routes. Scope remains library-owned Core Presentation. Reuse AppModalBottomDialog, AppSheet, DialogShape, ModalSheetPage, and ModalSheetConfig in `lib/libs/uikit/core/presentation/sheets/app_modal_sheet.dart`; this proposal introduces no objects or responsibility changes. Widgets, the clipping helper, route Page adapter, and Presentation configuration retain their intake names and roles.

Resolver result: RESOLVED for this dependency-substitution proposal. Governing evidence: declarative_foldering_rules.md:31 establishes library-path semantics; :89 identifies sizing/theme as Presentation values; :91 defines UI responsibility; :95 preserves Presentation model scope; :160 onward defines both endpoint checks. lib/AGENTS.md supplies the governing document and approval safeguard; lib/libs/AGENTS.md:9 and :28 inherit layer rules, and :32 requires explicit approval for protected-source edits. No narrower UIKit guide was found.

Permitted outbound endpoints are `/lib/libs/uikit/core/presentation/models/layout`, `/lib/libs/uikit/core/presentation/models/themes`, and `/lib/libs/uikit/core/presentation/widgets`: existing public sizing/theme values and the marker permit same-scope Presentation consumers, including `/lib/libs/uikit/core/presentation/sheets`. External imports remain Flutter and modal_bottom_sheet. Feature implementations, App startup, and Domain/Data/Infrastructure consumers remain outside this sheet-family responsibility. Permitted inbound paths retain `/lib/core/presentation/*`, `/lib/shared/core/presentation/*`, `/lib/features/<feature>/presentation/*`, matching library Presentation paths, and generic `/lib/app/routing` composition subject to public routing entrypoints. Domain/Data/Infrastructure paths may neither import nor export these Presentation declarations. This is a scoped role/endpoint result, not blanket access to every same-layer object.

Exact proposed source edits, confined to app_modal_sheet.dart:

1. Replace the Kiddodo AppConsts import with `../models/layout/app_sizes.dart` and replace its one AppConsts.gap8x use with AppSizes.gap8x.
2. Replace the Kiddodo AppElement import with `../widgets/app_element.dart`; retain the existing implements AppElement declaration and empty marker.
3. Replace the Kiddodo AppTheme import with `../models/themes/app_theme.dart`; retain both existing AppTheme.theme color reads.

Sizing decision requiring approval: the source AppConsts.gap8x is 40.0, while Apollo's AppSizes.gap8x is 32.0. Recommend Apollo's 32.0 fallback top spacing when MediaQuery top padding is zero. The explicit difference is part of this proposal, rather than a claimed value-equivalent substitution. Preserve source comments, formatting, route behavior, title/backSupport/padding behavior, and existing global-theme strategy for this step.

Context-checker result: HEALTHY for this proposal. Observed context includes Apollo's local resolver/checker, harness, governing document and ancestor library guides, selected source and target declarations, source constant definition, installed package APIs from Stage 2, and the staged approval record. Endpoint declarations and actual collaborator values were checked separately. The source-spacing comparison corrected the assumption that matching gap names imply matching values. Confirmed missing context, unnecessary context, and unresolved interpretation conflicts: none identified for the proposed substitutions. Compilation and runtime remain unverified; diagnostics removal belongs to Stage 5. This is a read-only self-review, with authorized plan recording performed separately.

After approval, apply only these substitutions and run scoped analysis. Present any subsequent behavior changes separately.

#### Stage 4 approved adaptation result — 2026-10-20

Applied the developer-approved three import replacements and one AppSizes.gap8x substitution in app_modal_sheet.dart. The fallback spacing is now 32.0. Comparison with the original source confirms exactly these four changed lines; comments, formatting, declarations, global theme access, and remaining behavior are preserved.

Scoped Dart analysis reports zero errors, five existing unused clipper-variable warnings, and four informational notices. git diff --check passes. Existing warnings remain review evidence rather than an approved cleanup. Runtime behavior and tests remain unverified. The routed dismissible flag, commented title rendering, and padding/backSupport behavior retain their recorded review items.

Context-checker follow-through: the implementation matches the exact approved proposal and existing endpoint declarations. Result: HEALTHY for this adaptation scope, retaining the runtime limitation. Next: Stage 5's alternative-page diagnostics import/wrapper removal proposal.

### Stage 5 — Alternative adaptation

Integrate the selected dependency and preserve compact/full-screen/hidden stops, startsExpanded, drag and barrier controls, surface morphing, scrolling, and safe-area behavior. Apply the developer's diagnostics-exclusion decision by removing the source diagnostics import/wrapper and keeping its child directly. Compare the actual package controller/route API with callers before changing code. Verify compatibility before claiming working gesture behavior.

#### Stage 5 approved adaptation result — 2026-10-20

Removed the diagnostics import and replaced AlternativeModalSheetDiagnostics(child: child) with child inside the existing ScrollConfiguration in alternative_modal_sheet_page.dart. Comparison with the original source confirms only these two approved line changes. Existing comments, compact/full-screen/hidden stops, spring settings, surface morphing, scrolling, safe-area behavior, and declarations are preserved.

Scoped target Dart analysis reports zero errors/warnings and one informational super-parameter suggestion. git diff --check passes. The target-owned sheet package exposes the selected resizable, snapSpring, snapToDragDirection, and SheetMediaQuery APIs. Tests, builds, and runtime gestures remain unverified.

Context-checker: the developer's exact approval, diagnostics-exclusion decision, staged plan, local harness/ancestor library rules, source comparison, installed package API evidence, and target analyzer cover this narrow Presentation change. The existing AlternativeModalSheetPage role and location remain unchanged. Confirmed missing context, unnecessary context, and interpretation conflicts: none identified for this scope. Result: HEALTHY for this read-only self-review; runtime coverage remains unverified. Progress recording is separate from the checker.

Next: Stage 6 proposal for minimal feature-owned examples, exact objects/paths, routing, and success/cancellation behavior.

### Stage 6 — Minimal Apollo examples

Propose exact feature ownership, object roles/names/paths, and routing changes using the resolver. Candidate demonstrations: content-sized legacy dialog, constrained legacy sheet, and compact-to-full-screen alternative with scrollable content and a fixed action. Agree the minimal subset and test expectations before implementation. Reuse the established screen/sheet callback, failure, Controller/State, layout, localization, and typography patterns where applicable.

Keep concrete content inside its feature and compose through its public routing entrypoint. Document input, success, callback-consumed events, cancellation, and returned values. Add approved feature specification, implementation progress, history, and diagnostic-log expectations alongside the example feature.

#### Stage 6 proposal — 2026-10-20

Principal responsibility: demonstrate the two reusable modal containers through feature-owned Presentation. Reuse Hello Apollo as the example host, with two buttons and a localized last-result label. Propose a constrained legacy ModalSheetPage and a compact-to-full-screen AlternativeModalSheetPage. Both routes reuse one content sheet with a scrollable example list and fixed Confirm/Cancel actions. Content-sized legacy and imperative-show examples remain additional candidates rather than required implementation in this step.

New objects and exact paths, relative to Apollo:

- BottomSheetExampleSheet: concrete feature Presentation sheet in `lib/features/hello_apollo/presentation/sheets/bottom_sheet_example_sheet.dart`. Use EventOnSuccess<bool>, EventOnSkip<bool>, AppHandleFailure, BlocProvider/Builder/BlocConsumer, and separate mainBuilder/mainListener with the established failure-processing path. Render through AppScreenLayouts and AppFlexibleLayouts.FixedVisibleBottomLayoutWithScrollableExpandedContent; use the route's PrimaryScrollController for inner scroll handoff. Both selected package implementations expose a PrimaryScrollController.
- BottomSheetExampleCubit: feature Presentation Controller in `lib/features/hello_apollo/presentation/controllers/bottom_sheet_example_cubit.dart`. Retain the standard status/errors/clearUnhandledError foundation.
- BottomSheetExampleState: Controller companion in `lib/features/hello_apollo/presentation/controllers/bottom_sheet_example_state.dart`, with BottomSheetExampleStatus initialize/ready, BottomSheetExampleErrorType unhandledError, immutable status/errors, copyWith, and equality props.
- BottomSheetExampleParams: Presentation route input in `lib/features/hello_apollo/presentation/models/bottom_sheet_example_params.dart`, carrying an optional AppOnSuccess<bool> callback. Route configuration selects the container; the content sheet remains common.

Existing files proposed for update:

- `lib/features/hello_apollo/presentation/routing.dart`: add `/hello-apollo/legacy-sheet` and `/hello-apollo/alternative-sheet` through pageBuilder, keyed with state.pageKey, using typed optional extra parameters and the example Cubit factory. Keep route ownership inside the feature.
- `lib/features/hello_apollo/di.dart`: register the example Cubit factory.
- `lib/features/hello_apollo/presentation/screens/hello_apollo_screen.dart`: add the two localized launch actions, await AppRouter push<bool> through DI, pass Params, and forward the returned outcome to the existing Cubit.
- `lib/features/hello_apollo/presentation/controllers/hello_apollo_cubit.dart` and `hello_apollo_state.dart`: record/display the latest sheet outcome with HelloApolloSheetResult none/confirmed/cancelled. This is UI state, retained through copyWith and equality.
- `assets/translations/en.json`: add titles, descriptions, list-item template, actions, and outcome labels, rendered with the existing .tr().p4() pattern.

Completion contract: Confirm calls callSuccessPop(context, true); an optional callback returning null consumes success and keeps the route open. Cancel calls callSkipPop(); barrier/back/drag dismissal also yields null. The host reports true as confirmed and null as cancelled. The example does not add a separate cancellation callback. Existing mixin callback return semantics remain unchanged.

Feature documentation proposed under `lib/features/hello_apollo/ai_development/`: feature_spec.md, implementation_plan.md, development_history.md, and hello_apollo_logs_test_spec.md. Record existing routing-log evidence and runtime/diagnostic limits; present the exact diagnostic-spec text for approval before writing it. Automated tests receive a separate developer decision; scoped analysis and manual runtime verification are the proposed verification approach.

Resolver result: RESOLVED for the proposed roles, names, and placements. Domain/Data/Infrastructure remain outside this example. Rule evidence: declarative_foldering_rules.md:58–64 and :88–95 define Presentation roles and companion States; :163–168 requires both dependency endpoints. lib/features/AGENTS.md:7–9 defines isolated feature scope; the feature blueprint's Public Entrypoints selects presentation/routing.dart for App composition; its Presentation guide defines models/controllers/sheets/screens and routing. Controller naming follows the controllers blueprint. Scope/implementation kind and naming agree for each object; supporting responsibility and owner-role fields are not applicable. Visibility is feature-internal except the public routing entrypoint.

Permitted outbound paths: same-feature `/lib/features/hello_apollo/presentation/*`, corresponding UIKit `/lib/libs/uikit/core/presentation/*`, and project adapters `/lib/shared/core/presentation/*`. The existing DI/AppRouter entrypoints are permitted for library/feature UI navigation under their scoped rules. Cubits consume their companion State and permitted Domain contracts rather than route/widget implementations. Inbound consumers: the sheet is constructed by its feature routing; the Cubit by feature DI and its designated sheet; Params by its feature screen/routing/sheet; State by its Cubit and sheet. App imports only the public feature routing entrypoint, already wired. Sibling feature internals and Domain/Data/Infrastructure consumers of these UI declarations remain excluded. main.dart, App routing, startup, library implementations, and rules retain their current content.

Context-checker: HEALTHY for this proposal. Read evidence covers the active task/approval history, local harness and skills, governing architecture, feature and controller blueprints, Hello Apollo's current DI/routes/screen/Cubit/State, navigation callback semantics, layout implementation, package PrimaryScrollController exposure, translations, and scoped routing catalog. The catalog governs App routing only; its demonstrated navigation contract is consistent with the developer's existing project-wide instruction and mixins. Confirmed missing context, unnecessary context, and interpretation conflicts: none identified for this proposal. Gesture behavior, callbacks under runtime navigation, viewport fit, and light/dark output remain unverified. This read-only self-review establishes proposal coverage, with plan recording performed separately. Exact implementation approval remains pending.

#### Stage 6 endpoint correction

The final App-endpoint check corrects the proposed direct DI/AppRouter access above: lib/app/AGENTS.md:27–33 lists library, Shared, App, root lib, and Core Flows consumers, while feature Presentation is absent. The proposed feature screen therefore cannot directly import App DI/router under the current rule. The earlier RESOLVED/HEALTHY statements cover the proposed object roles/placement only and are superseded for the complete dependency proposal: resolver result CONFLICT; context-checker result CORRECTION NEEDED. Existing navigation mixins remain permitted library consumers of App. Choose an approved permitted navigation entrypoint or approve a specific App rule change before implementing launch actions. Source and AGENTS files remain unchanged during this review.

#### Approved App entrypoint permission — 2026-10-20

The developer approved the exact single-file change to lib/app/AGENTS.md: add `/lib/features/*` to May Be Imported By, and identify `/lib/app/di.dart` plus `/lib/app/routing/app_router.dart` as feature Presentation entrypoints for dependency resolution and navigation. Other feature layers retain their existing boundaries, and registration helpers retain private wiring scope. This supersedes the preceding endpoint conflict. The architecture-project guide already includes feature consumers and remains unchanged. Application source remains unchanged; Stage 6 example implementation still awaits approval.

#### Stage 6 implementation and read-only reviews — 2026-10-20

The developer approved the two examples after the App endpoint correction. Added the four proposed Presentation source files, registered BottomSheetExampleCubit in feature DI, added both routes, and connected localized launch actions and last-result state in Hello Apollo. The sheet uses the approved shared content, typed Params/callbacks, AppScreenLayouts/AppFlexibleLayouts, route PrimaryScrollController, fixed actions, BlocConsumer builder/listener, AppHandleFailure, status/errors/copyWith/equality, and clearUnhandledError path.

Added feature_spec.md, implementation_plan.md, and development_history.md under the feature's ai_development folder. The diagnostic-spec text remains a proposal below, preserving its separate approval gate. Content-sized/imperative examples and automated tests remain outside this implemented subset.

Verification: scoped Dart analysis of lib/features/hello_apollo passes with no issues. A static JSON/key check confirms all ten referenced sheet localization keys exist. Formatting was applied only to the four newly authored Dart files; existing source comments and formatting were preserved. git diff --check passes. Before/after hashes confirm main.dart, App routing, App guide, dependency manifests, both imported adapter files, and all 45 package files are unchanged by this example implementation. Runtime sheets/gestures, callback consumption, viewport fit, repeated opens, and theme appearance remain Stage 7 checks.

Read-only audits of this example scope:

- Declarative rules: PASS for placement, names, feature DI/routing entrypoints, both dependency directions, and approval/protected-file boundaries. Feature Presentation uses the separately approved App entrypoints; App still consumes only feature routing/DI entrypoints.
- Naming: PASS. Sheet/Cubit/State/Params names describe their destination and Presentation roles; enums identify UI lifecycle, errors, and recorded outcomes.
- Responsibility leaks: PASS. Rendering/navigation remains Presentation-owned; result recording belongs to the host Controller, and State retains UI outcomes. Domain/Data/Infrastructure and cross-feature behavior remain outside the change. Resolver profiles remain RESOLVED after the approved App override; existing-object responsibilities match the approved proposal.
- Pattern keeper: PASS with the empty project-wide catalog and no applicable descendant catalogs. The App routing catalog remains scoped to its subtree. Independently checked the developer-approved conversation patterns against the new sheet's builder/listener, typed completion, layouts, localization/style calls, failure listener, and Controller/State foundations.
- Context checker: HEALTHY for the approved implementation scope. Available approval history, current endpoint rules, target-local skills, source/caller reads, diffs, analyzer output, and preservation hashes support this result. Confirmed missing/excess context and interpretation conflicts: none identified for this scope. Runtime behavior remains unverified; this is a self-review, with no independent-agent or hidden-context claim.

#### Proposed diagnostic specification text — awaiting approval

Destination: lib/features/hello_apollo/ai_development/hello_apollo_logs_test_spec.md.

```markdown
# Hello Apollo Diagnostic Checks

Scope: legacy and alternative bottom-sheet examples.

Capture the Flutter console while opening each example, confirming, cancelling,
dismissing through supported barrier/back/drag actions, and repeating each flow.
Use available GoRouter diagnostics and navigator observer output as route evidence.
Record missing events as a coverage limitation, separately from runtime failures.

Confirm visually that the correct container opens, content scrolls while actions
remain visible, alternative snapping works, and the host shows the correct result.
Check light/dark appearance, supported viewport sizes, and insets. Exercise an
onSuccess callback returning null and confirm that the sheet remains open.

Diagnostic limit: existing logs do not establish result values, dismissal cause,
callback consumption, scroll handoff, snapping, or layout correctness. Pair route
evidence with direct runtime observation. Report Flutter exceptions, overflow,
missing PrimaryScrollController, and disposed-controller errors separately.

Verification status: runtime checks pending. Automated tests await developer approval.
```

Next: approve this diagnostic-spec text and proceed to Stage 7's runtime verification.

#### Developer-approved declaration suffix correction — 2026-10-20

Renamed AppModalBottomDialog to AppModalBottomDialogWidget, including its constructor and both construction sites in app_modal_sheet.dart. The Widget role identifies reusable rendering of supplied content without an owned Controller. The developer authorized this specific declaration-naming correction; filename, folder, App prefix, other declarations, comments, and runtime behavior retain their current form for separate review. Historical intake records above retain the source name. The sole remaining exact old-name occurrence under lib/test is the preserved original constructor comment. Scoped analysis of this file and Hello Apollo reports zero errors, five existing unused-variable warnings, and four informational notices; git diff --check passes. This suffix correction establishes neither full foldering compliance nor runtime verification.

#### Developer-approved modal screen layout — 2026-10-20

The developer clarified the intended roles: Sheet is the container, ModalSheetPage is the routing wrapper, and the imported AppModalBottomDialog corresponds to AppScreenLayouts.appModalBottomSheet. This explicit correction supersedes the earlier classification of the container as feature-like Sheet content requiring its own Controller, and the intermediate Widget rename as the final design. Screen layout follows the existing AppScreenLayout family; the narrower glossary description of a pure Layout is not used to replace the developer's stated screen-layout responsibility.

Applied the approved four-source-file scope:

- Added concrete UIKit Core Presentation AppModalBottomSheetLayout extends AppScreenLayout at lib/libs/uikit/core/presentation/widgets/layouts/screen_layouts/app_modal_bottom_sheet_layout.dart. Moved AppSheet and DialogShape alongside it without changing their bodies. Preserved original comments and the existing static show method for its separate pending decision.
- Added AppScreenLayouts.appModalBottomSheet to the existing Shared Core Presentation extension, forwarding layout inputs and returning AppScreenLayout.
- Retained ModalSheetPage and ModalSheetConfig in the original app_modal_sheet.dart; the route now constructs the public layout factory once.
- Removed the appBasicScreen wrapper and its import from BottomSheetExampleSheet; common content returns AppFlexibleLayouts directly. The alternative route retains its own surface.

Resolver profile: UIKit/library Core scope, Presentation layer, concrete screen-layout role for AppModalBottomSheetLayout; Shared Core Presentation factory for the existing AppScreenLayouts extension; existing Presentation routing wrapper and configuration roles retained. Layout dependencies are UIKit Presentation models/widgets, Flutter, and the retained modal package. The routing wrapper consumes the matching Shared Presentation adaptation entrypoint; Shared constructs the reusable layout, with no reverse import from that layout to the wrapper. Feature routing consumes the wrapper, while feature content consumes flexible layouts. Domain/Data/Infrastructure, feature implementation dependencies from libraries, and private App registration helpers remain outside this change. Developer approval covers this exact role/path transformation and protected-source edits; no rule files were changed.

Scoped analysis of the layout, wrapper, extension, and Hello Apollo reports zero errors, six existing warnings (five moved unused clipper variables and the pre-existing extension import), and three informational notices. Two new wiring-related informational notices were corrected within the approved change. Comparison confirms every original comment is preserved and the moved AppSheet/DialogShape bodies are unchanged. Before/after hashes confirm main.dart, manifests, App guide, alternative adapter, feature routing declarations, and the entire vendored package are unchanged. git diff --check passes. Runtime verification and the diagnostic-spec approval remain pending.

Context-checker: HEALTHY for the approved transformation scope. The explicit developer role correction, current layout base/factory declarations, ancestor library/Shared rules, caller search, source split comparisons, and analyzer/preservation evidence cover this change. The earlier interpretation that every modal surface must be screen-like content with a Controller is superseded by the developer's definition. The existing imperative show entrypoint remains a recorded separate review item; this report does not claim full import compliance or runtime correctness.

Next: review the remaining routing-wrapper/configuration names and the retained imperative show entrypoint separately, then continue runtime verification under Stage 7.

#### Approved routing wrapper/configuration cleanup — 2026-10-20

Renamed ModalSheetPage to ModalSheetPageWrapper and moved it to lib/libs/uikit/core/presentation/wrappers/modal_sheet_page_wrapper.dart. Its role is a concrete Core Presentation Page wrapper, with owner role Page and supporting responsibility Wrapper. Moved ModalSheetConfig unchanged into lib/libs/uikit/core/presentation/models/modal_sheet_config.dart as a Presentation configuration value. The wrapper imports that model and the existing Shared screen-layout factory; the model imports only Flutter. Hello Apollo's public routing entrypoint imports both declarations and constructs the wrapper. Dependency direction and public consumer roles are unchanged by the moves.

Removed the developer-approved unused AppModalBottomSheetLayout.show method, its method-specific comments, and the modal package import from the layout. This closes the earlier imperative-navigation leakage finding for that layout. All remaining comments and render bodies are retained. Removed the emptied app_modal_sheet.dart after relocating both declarations; original intake remains recoverable from the Uber Babysitter source and the recorded migration history. A preserved historical comment in AppRouter still illustrates the old ModalSheetPage name; it is not an executable reference and was outside this edit approval.

Scoped analysis of the new wrapper/model, layout, and Hello Apollo reports zero errors, five existing clipper-variable warnings, and two informational notices. git diff --check passes. The configuration declaration matches its pre-move body. Existing route behavior, including the separately recorded dismissible/title/padding limitations, remains unchanged. Runtime behavior is unverified; tests were not run. No AGENTS, startup, alternative adapter, or package changes were made in this step.

Read-only scope review: names/paths now explicitly identify the legacy Page wrapper, configuration model, and screen layout. Supporting Wrapper placement follows the Presentation owner layer. The approved moves and deletion match the proposed scope; remaining alternative naming and configuration behavior are separate reviews. No complete-import or runtime-verification claim is made.

### Stage 7 — Verification and closure

2026-10-20 clarification: the approved 200 ms minimum delay supersedes the animation observer below. BottomSheetExampleCubit initializes asynchronously and checks isClosed before ready; BottomSheetExampleSheet retains loader/ready rendering with the private opening widget removed. Future asynchronous content must also be ready. Verify timing on fresh route opens.

2026-10-20: approved opening-loader change implemented within BottomSheetExampleSheet and BottomSheetExampleCubit. The route animation completes initialize → ready; the private sheet observer releases its listener on disposal. Scoped feature analysis passes and Android hot reload succeeded. Both-route visual timing remains unverified. Android reports a fixed-footer RenderFlex overflow; the restored appBasicScreen in ready content differs from the earlier layout correction and awaits a focused review. Stage 7 remains open.

Record analysis and build results plus observed behavior: opening/closing, repeated opens, typed results, callback-consumed completion, barrier/drag/back cancellation, compact/full-screen transitions, scrolling with fixed actions, keyboard/insets, supported viewport sizes, and light/dark appearance. Record platform coverage explicitly; earlier mobile deferral applies to earlier work and does not establish coverage for this new part.

Use the local finalization audits after approved implementation and corrections. Keep unexercised paths and diagnostic limitations explicit. Close this architectural part through the developer's decision.

## Context-checker evidence — Stage 1, 2026-10-20

Task: plan and inventory both Uber Babysitter approaches for Apollo. Stage approval covers planning/source inspection; code copies and adaptations remain proposed.

Authority consulted: Apollo lib/AGENTS.md, ai_development/ai_harness.md, ai_development/declarative_foldering_rules.md, relevant library/Core/Shared/App/feature blueprint guides, ai_development/AGENTS.md, and the established copy/review process in implementation_plan.md. The named architecture-project skill and Apollo's local context-checker were read; execution follows the target project's local harness.

Observed source evidence: all three candidate application files, their direct imports and declarations, source route examples, navigation mixins, the local package file inventory/manifest/public exports/license, and existing Apollo Presentation collaborators. The inspected Uber Babysitter lib/AGENTS.md governs reference-project inspection; Apollo's guides govern destination placement. Project patterns are empty; the routing catalog is scoped to App routing and is loaded only for its planned boundary.

Confirmed missing context: none identified for inventory and the application-file placement proposal. Unnecessary context: none identified for those supported decisions. Interpretation correction retained: source behavior is evidence rather than Apollo authority; dependency existence, SDK compatibility, architectural permission, and runtime verification are separate claims. Footunion's optional wrapper/title behavior is comparison evidence rather than an implicit addition to the selected source.

Unverified coverage: local package Dart/Flutter compatibility, package destination, diagnostics integration choice, and runtime gestures remain Stage 2 onward work. Existing source bodies were inspected for inventory/behavior; they were not used to redefine the resolver's declared layer. This self-review has no separate reviewer execution trace or access to hidden model context.

Result: HEALTHY for Stage 1 inventory and application-file placement. The complete copy approval gate remains after Stage 2.

## Developer decision — Diagnostics excluded, 2026-10-20

The developer declined AlternativeModalSheetDiagnostics. The current application-file copy map contains two files. Copy-first behavior is preserved: the alternative page retains its original diagnostics reference in the unchanged intake, then the reference and wrapper are removed during adaptation. The diagnostics file remains in the source project. This decision resolves the diagnostics integration choice listed in the earlier context-checker record; dependency compatibility and runtime behavior remain unverified.
