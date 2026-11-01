# About Apollo

## Purpose

Demonstrate a minimal declarative Flutter feature: Screen, Cubit/State, routing, and DI. The welcome shows localized Apollo artwork/text and installed version/build metadata through the existing Core service contract.

## Version-tap log sharing

Ten taps on the version/build label request the native share sheet with a timestamped password-protected ZIP containing Apollo's session_log.txt. The tap counter resets on the tenth tap; sharing status suppresses repeated requests until the native operation completes or fails. Dismissing the share sheet returns to idle, and another ten taps can request sharing again. The counter belongs to the current AboutApolloCubit instance.

ApolloWelcome forwards the gesture through its callback. AboutApolloCubit consumes IAppLogShareService; Core DI constructs AppLogShareService using IAppLoggerService. Logger snapshotLog is queued behind prior log writes, flushes the sink, and reads the snapshot before later queued writes resume. AppLogShareService packages the snapshot in temporary storage and invokes share_plus; export files remain available for native receivers. Existing AppHandleFailure processes failures emitted through the Controller's unhandledError entry.

Configure the archive password with --dart-define=APOLLO_LOG_ARCHIVE_PASSWORD=<value>. The scaffold default is ApolloSupport2026; this public development default and build-embedded passwords are not confidential credentials. The archive includes the existing application log contents. Native sharing leaves the destination choice to the user. Physical shake activation and external SDK collection retain their separate scope.

Acceptance: taps 1–9 retain the screen, tap 10 opens one share sheet, dismissal permits a new cycle, and export failures enter the existing error path. Verify that the archive opens with the configured password and includes preceding log writes. Android/iOS/macOS runtime behavior remains to be exercised.

## Bottom-sheet examples (existing)

AboutApolloScreen offers Legacy sheet and Alternative sheet actions. Both construct BottomSheetExampleSheet through this feature's public presentation/routing.dart entrypoint and resolve a fresh BottomSheetExampleCubit from feature DI.

- `/about-apollo/legacy-sheet`: ModalSheetPageWrapper constructs AppScreenLayouts.appModalBottomSheet with the existing constrained-height ModalSheetConfig from UIKit Presentation models.
- `/about-apollo/alternative-sheet`: AlternativeModalSheetPage, starting at 0.55 extent, with hidden/compact/full-screen stops and surface morphing.

The common feature content returns AppFlexibleLayouts directly. The legacy route applies the modal screen layout once; the alternative route supplies its own animated surface. Twenty localized items scroll through the route's PrimaryScrollController; Confirm and Cancel remain in the fixed bottom section. The Controller and State retain explicit initialize/ready status, typed errors, clearUnhandledError, copyWith, and equality.

## Inputs and completion

### Opening readiness

Each new sheet starts in initialize and displays a centered progress indicator. BottomSheetExampleCubit waits at least 200 ms from its creation on opening before transitioning to ready and revealing the current static content and actions. The Cubit checks isClosed before emitting. Future asynchronous content preparation must also finish before the ready transition; its data lifecycle remains distinct from this minimum display delay.

Current implementation note: the ready branch contains appBasicScreen again. The earlier direct-flexible-layout description above records the approved transformation; reconciling this restored wrapper and the observed viewport overflow remains a separate layout review.

Both routes accept optional BottomSheetExampleParams through extra. Its optional onSuccess callback uses AppOnSuccess<bool>. Confirm invokes callSuccessPop(context, true). A callback returning null consumes completion and keeps the sheet open; a non-null callback result permits the existing mixin to pop the original true value. The launch buttons provide a pass-through callback.

Cancel invokes callSkipPop without a skip callback. Cancel, barrier dismissal, back navigation, and drag dismissal return null. AboutApolloCubit records confirmed for true and cancelled for a dismissed route; its initial outcome is none. State copies preserve the outcome and include it in equality.

## Acceptance checks

1. Both launch actions open their designated container and preserve the welcome screen beneath it.
2. Scrolling keeps actions visible and hands off correctly to the sheet; the alternative moves between compact and full-screen stops.
3. Confirm closes the route and displays Sheet confirmed. Cancellation displays Sheet cancelled.
4. A caller-supplied consuming success callback keeps the route open.
5. Reopening creates a fresh sheet Cubit, with no stale errors or disposed controller access.
6. Content and actions remain usable across light/dark themes, supported window sizes, and insets.

## Current verification

Scoped Dart analysis of the feature passes. Runtime navigation, scrolling, cancellation, callback consumption, repeated opens, viewport fit, and theme appearance await Stage 7. Automated tests await a separate developer decision. Existing routing logs establish only partial navigation evidence; gesture and displayed-result correctness require runtime observation. The diagnostic specification has a separate text-approval gate in the bottom-sheet plan.

## Notification demonstration — 2026-11-01

On iOS and Android, About Apollo exposes Enable notifications, Show test notification and Cancel test notification. A configured build with `APOLLO_FIREBASE_PUSH_ENABLED=true` also exposes Enable push notifications. Permission and push registration are separate actions in the current implementation. Busy state prevents repeated explicit actions; permission outcomes and failures travel through the existing Controller/State and error listener.

`AboutApolloCubit` consumes Core Domain notification contracts. While it is alive, it observes foreground push messages and registration events, requests local presentation for notification content, and suppresses recent duplicate SDK message IDs. Data-only messages are not automatically displayed. Each example display uses native slot 1001 for cancellation and a new interaction ID so later examples can route again. App routing accepts the typed `home` destination after startup readiness and handles both live and cold-start interactions.

Acceptance: no startup permission prompt; explicit permission grant/denial is reflected; permitted display and cancellation work; repeated examples can each open home; configured push can register, receive and route on both platforms; closing the Controller disposes its subscriptions. Android compilation and scoped analysis pass; iOS simulator compilation also passes; visible presentation, permission interactions, signed provisioning and configured remote delivery remain unverified. Core setup and payload details are in [notifications_spec.md](../../../../ai_development/notifications_spec.md). The feature-specific [diagnostic procedure](about_apollo_logs_test_spec.md) distinguishes log evidence from device observations.
