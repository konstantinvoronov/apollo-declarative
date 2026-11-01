# About Apollo Implementation Progress

## Current job

Version-tap log sharing: Core Domain contract and Service, ordered logger snapshot, Core/feature DI, and Presentation tap/sharing state. The earlier bottom-sheet migration remains recorded below.

## Version-tap sharing progress — 2026-10-21

Implemented the approved ten-tap trigger, counter reset, idle/sharing state, IAppLogShareService/AppLogShareService, and queued snapshotLog operation. Added the optional ApolloWelcome gesture callback and reused the screen's existing Controller error listener. Core DI supplies the Apollo archive password through a build-time setting. Dependencies resolve offline with share_plus 12.0.1 and the already-resolved archive 4.5.2; generated macOS/Windows plugin registration updates accompany resolution. Existing dependency versions remain unchanged.

Scoped analysis reports zero errors, one existing unused-import warning and 15 existing logger informational notices. Android debug APK build succeeded in 215.7 seconds. No Android device is connected. Next verify ten taps, native dismissal/retry, archive decryption/content, and failure handling. Automated tests await a separate developer decision. Existing logs expose consumed failure chains; successful tap thresholds and native destination selection require direct observation, with diagnostic-spec approval retained separately.

## Implemented

- Added BottomSheetExampleSheet, BottomSheetExampleCubit/State, and BottomSheetExampleParams in feature Presentation.
- Registered the Cubit factory in the feature-root DI entrypoint.
- Added legacy and alternative routes to the existing public Presentation routing entrypoint.
- Added launch actions and last-result display to AboutApolloScreen, backed by AboutApolloCubit/State.
- Added English localization for content, actions, and outcomes.

## Verification and remaining work

Opening loader implemented in the sheet and Cubit: initialize → at least 200 ms from creation on opening → ready for current static content. The developer-approved delay supersedes the animation observer. Next verify timing on both routes and review the observed fixed-footer RenderFlex overflow separately. Current ready content retains its appBasicScreen wrapper for that review.

Scoped feature Dart analysis passes. Keep Stage 7 open for runtime navigation, confirm/cancel, callback consumption, sheet/scroll handoff, repeat opens, viewport/inset behavior, and theme coverage. Preserve the imported libraries and startup throughout this example job. The feature diagnostic-spec text awaits its own approval before writing. Automated test creation/execution remains a separate developer decision.

The project plan at `/ai_development/bottom_sheets_implementation_plan.md` owns migration stages and broader library behavior-review items.

## Notification demonstration — 2026-11-01

Implemented the explicit permission/local display/cancel controls and conditional push registration through Core service contracts. Controller/State retain action progress, permission and registration outcomes, failure chains, foreground message presentation and subscription cleanup. App startup/routing owns live and cold interaction consumption; the supported destination remains home.

Android debug and iOS simulator debug builds pass. Remaining: both-platform device permission/display/cancel/tap checks, signed provisioning checks, and remote delivery using a configured derived app. Apollo is a framework and has no assigned Firebase project. The approved setup workflow collects each derived app's iOS/Android Firebase/APNs details and records pending registration ownership when there is no backend. Scheduling, backend sending/storage and other destinations remain separate scope. No automated-test preference was supplied. iOS compilation uses the existing Flutter/CocoaPods workflow; the prior separate tooling-approval gate was unnecessary.

Reuse unchanged scoped analysis and Android build evidence. Follow [about_apollo_logs_test_spec.md](about_apollo_logs_test_spec.md) for notification QA and the [full available task transcript](../../../../ai_development/notifications_conversation_transcript.md) for decisions. Older sheet/sharing verification items above retain their own scope.

## Framework delivery verification boundary

For this framework-only delivery, verification comprises the source/architecture guards, scoped Dart analysis, Android debug compilation and iOS simulator debug compilation. These pass. The native/device matrix remains acceptance work for a configured derived app; no live Firebase/APNs delivery or device UI outcome is claimed by the framework build checks. Apollo itself receives no Firebase project. The setup workflow records app-specific configuration and verification separately.
