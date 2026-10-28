# About Apollo Development History

## 2026-10-21 — Version-tap log sharing

The developer approved the same ten-version-tap entrypoint found in the reference settings screen. Added a Core Domain Service interface and a concrete Core Service for Apollo-only password-protected ZIP export and native sharing. Core/feature DI provide the Service through its interface. HelloApolloState owns tap count and idle/sharing status; HelloApolloCubit resets after ten taps and preserves failures as a ControllerFailure chain for the existing UI handler. ApolloWelcome forwards taps through a callback.

The logger now queues write operations and its snapshot operation in order. Snapshot flushes prior writes and captures text while later queued operations wait. Logger interfaces expose AppResult<String>; archive/plugin/platform-window types stay inside the concrete sharing Service. Sharing uses a window anchor for native popover support. reference settings application's settings screen, SDK collection, physical-shake activation, and global startup remain outside this implementation. The public scaffold password is configurable through APOLLO_LOG_ARCHIVE_PASSWORD and is not a confidential credential.

Verification: Android debug APK build succeeded; scoped analysis has zero errors, one pre-existing logger warning and 15 informational notices. Dependency resolution preserved existing package versions. No device is connected; native sharing, archive contents/decryption, and error-path runtime verification remain pending. Automated tests were not added or run.

## 2026-10-20 — Minimum opening delay

The developer clarified that content appears at least 200 ms after opening. Replaced the animation-completion approach with a 200 ms delay during BottomSheetExampleCubit initialization, guarded by isClosed. Removed the private opening widget and its animation subscription; the sheet keeps the existing loader/ready rendering. Current content is static; future asynchronous preparation must complete alongside the minimum delay before ready.

## 2026-10-20 — Loading during sheet opening

Approved two-source-file change: BottomSheetExampleCubit retains initialize until completeOpening; BottomSheetExampleSheet observes the route animation, shows a loader during opening, then reveals the existing ready layout. The private Presentation widget owns listener subscription and disposal. Existing callbacks, error processing, ready content, startup, and library implementations retain their behavior.

Scoped feature analysis passes and Android hot reload succeeded. Device logs still report a RenderFlex overflow in fixed_visible_bottom_with_scrollable_expanded_content.dart, including after reload. Visual loader timing and both route flows remain to be verified; this check establishes deployment rather than runtime acceptance. The existing ready branch includes appBasicScreen, unlike the earlier layout decision, and remains a separate review item.

## 2026-10-20 — Bottom-sheet examples

The developer approved Stage 6 examples after the bottom-sheet source application library intake and adaptations. The agreed subset is a constrained legacy ModalSheetPage and compact-to-full-screen AlternativeModalSheetPage, reusing one feature-owned sheet rather than duplicating content. Content-sized legacy and imperative-show examples remain candidates.

An endpoint review found Apollo's App guide omitted feature consumers. The developer separately approved that specific guide change, exposing App DI/router entrypoints to feature Presentation while preserving private registration helpers. Example implementation followed that approval.

Added the sheet, its Cubit/State and Params, feature DI registration, two routes, host launch actions/result state, and localized content. The sheet follows the established BlocConsumer builder/listener, AppHandleFailure, typed success/skip mixins, AppScreenLayouts, AppFlexibleLayouts, and .tr().p4() conventions. Startup and imported libraries retain their content.

Scoped feature analysis passed. Runtime sheet behavior and automated tests remain unverified. The diagnostic-spec text has a separate approval gate; this job adds no logging-only runtime behavior.

## 2026-10-20 — Modal screen-layout correction

The developer clarified that the modal container is a Sheet, ModalSheetPage is its routing wrapper, and AppModalBottomDialog corresponds to a screen layout exposed as AppScreenLayouts.appModalBottomSheet. This supersedes the intermediate Widget-suffix classification as the intended final design. The approved four-file transformation introduces AppModalBottomSheetLayout, relocates its existing AppSheet/clipping helpers alongside it, connects the route to the factory, and removes the nested appBasicScreen from the example. Feature content now returns AppFlexibleLayouts directly for both containers. Original comments and helper bodies are preserved; runtime checks remain pending.

## 2026-10-20 — Routing wrapper and configuration separation

Following explicit approval, renamed ModalSheetPage to ModalSheetPageWrapper and moved it into UIKit core/presentation/wrappers/modal_sheet_page_wrapper.dart. Moved the unchanged ModalSheetConfig declaration into core/presentation/models/modal_sheet_config.dart and updated feature routing imports/construction. Removed the unused static show method and its package import from the screen layout, leaving route creation to the wrapper. The original app_modal_sheet.dart was removed after its declarations were relocated. Existing routed behavior is preserved; runtime verification remains pending.

## 2026-10-21 — Feature renamed to About Apollo

The developer approved hello_apollo → about_apollo, HelloApollo → AboutApollo, feature DI/routing entrypoint names, localization keys, and /about-apollo sheet routes. The root route / and displayed Hello Apollo World greeting retain their behavior. This file preserves earlier names as historical evidence; current code and specifications use About Apollo. Existing uncommitted version-tap sharing work moved with the feature intact.
