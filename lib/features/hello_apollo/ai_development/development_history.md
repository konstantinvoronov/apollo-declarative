# Hello Apollo Development History

## 2026-10-20 — Minimum opening delay

The developer clarified that content appears at least 200 ms after opening. Replaced the animation-completion approach with a 200 ms delay during BottomSheetExampleCubit initialization, guarded by isClosed. Removed the private opening widget and its animation subscription; the sheet keeps the existing loader/ready rendering. Current content is static; future asynchronous preparation must complete alongside the minimum delay before ready.

## 2026-10-20 — Loading during sheet opening

Approved two-source-file change: BottomSheetExampleCubit retains initialize until completeOpening; BottomSheetExampleSheet observes the route animation, shows a loader during opening, then reveals the existing ready layout. The private Presentation widget owns listener subscription and disposal. Existing callbacks, error processing, ready content, startup, and library implementations retain their behavior.

Scoped feature analysis passes and Android hot reload succeeded. Device logs still report a RenderFlex overflow in fixed_visible_bottom_with_scrollable_expanded_content.dart, including after reload. Visual loader timing and both route flows remain to be verified; this check establishes deployment rather than runtime acceptance. The existing ready branch includes appBasicScreen, unlike the earlier layout decision, and remains a separate review item.

## 2026-10-20 — Bottom-sheet examples

The developer approved Stage 6 examples after the reference application library intake and adaptations. The agreed subset is a constrained legacy ModalSheetPage and compact-to-full-screen AlternativeModalSheetPage, reusing one feature-owned sheet rather than duplicating content. Content-sized legacy and imperative-show examples remain candidates.

An endpoint review found Apollo's App guide omitted feature consumers. The developer separately approved that specific guide change, exposing App DI/router entrypoints to feature Presentation while preserving private registration helpers. Example implementation followed that approval.

Added the sheet, its Cubit/State and Params, feature DI registration, two routes, host launch actions/result state, and localized content. The sheet follows the established BlocConsumer builder/listener, AppHandleFailure, typed success/skip mixins, AppScreenLayouts, AppFlexibleLayouts, and .tr().p4() conventions. Startup and imported libraries retain their content.

Scoped feature analysis passed. Runtime sheet behavior and automated tests remain unverified. The diagnostic-spec text has a separate approval gate; this job adds no logging-only runtime behavior.

## 2026-10-20 — Modal screen-layout correction

The developer clarified that the modal container is a Sheet, ModalSheetPage is its routing wrapper, and AppModalBottomDialog corresponds to a screen layout exposed as AppScreenLayouts.appModalBottomSheet. This supersedes the intermediate Widget-suffix classification as the intended final design. The approved four-file transformation introduces AppModalBottomSheetLayout, relocates its existing AppSheet/clipping helpers alongside it, connects the route to the factory, and removes the nested appBasicScreen from the example. Feature content now returns AppFlexibleLayouts directly for both containers. Original comments and helper bodies are preserved; runtime checks remain pending.

## 2026-10-20 — Routing wrapper and configuration separation

Following explicit approval, renamed ModalSheetPage to ModalSheetPageWrapper and moved it into UIKit core/presentation/wrappers/modal_sheet_page_wrapper.dart. Moved the unchanged ModalSheetConfig declaration into core/presentation/models/modal_sheet_config.dart and updated feature routing imports/construction. Removed the unused static show method and its package import from the screen layout, leaving route creation to the wrapper. The original app_modal_sheet.dart was removed after its declarations were relocated. Existing routed behavior is preserved; runtime verification remains pending.
