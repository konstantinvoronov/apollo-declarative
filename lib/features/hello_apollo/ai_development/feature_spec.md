# Hello Apollo

## Purpose

Demonstrate a minimal declarative Flutter feature: Screen, Cubit/State, routing, and DI. The welcome shows localized Apollo artwork/text and installed version/build metadata through the existing Core service contract.

## Bottom-sheet examples

HelloApolloScreen offers Legacy sheet and Alternative sheet actions. Both construct BottomSheetExampleSheet through this feature's public presentation/routing.dart entrypoint and resolve a fresh BottomSheetExampleCubit from feature DI.

- `/hello-apollo/legacy-sheet`: ModalSheetPageWrapper constructs AppScreenLayouts.appModalBottomSheet with the existing constrained-height ModalSheetConfig from UIKit Presentation models.
- `/hello-apollo/alternative-sheet`: AlternativeModalSheetPage, starting at 0.55 extent, with hidden/compact/full-screen stops and surface morphing.

The common feature content returns AppFlexibleLayouts directly. The legacy route applies the modal screen layout once; the alternative route supplies its own animated surface. Twenty localized items scroll through the route's PrimaryScrollController; Confirm and Cancel remain in the fixed bottom section. The Controller and State retain explicit initialize/ready status, typed errors, clearUnhandledError, copyWith, and equality.

## Inputs and completion

### Opening readiness

Each new sheet starts in initialize and displays a centered progress indicator. BottomSheetExampleCubit waits at least 200 ms from its creation on opening before transitioning to ready and revealing the current static content and actions. The Cubit checks isClosed before emitting. Future asynchronous content preparation must also finish before the ready transition; its data lifecycle remains distinct from this minimum display delay.

Current implementation note: the ready branch contains appBasicScreen again. The earlier direct-flexible-layout description above records the approved transformation; reconciling this restored wrapper and the observed viewport overflow remains a separate layout review.

Both routes accept optional BottomSheetExampleParams through extra. Its optional onSuccess callback uses AppOnSuccess<bool>. Confirm invokes callSuccessPop(context, true). A callback returning null consumes completion and keeps the sheet open; a non-null callback result permits the existing mixin to pop the original true value. The launch buttons provide a pass-through callback.

Cancel invokes callSkipPop without a skip callback. Cancel, barrier dismissal, back navigation, and drag dismissal return null. HelloApolloCubit records confirmed for true and cancelled for a dismissed route; its initial outcome is none. State copies preserve the outcome and include it in equality.

## Acceptance checks

1. Both launch actions open their designated container and preserve the welcome screen beneath it.
2. Scrolling keeps actions visible and hands off correctly to the sheet; the alternative moves between compact and full-screen stops.
3. Confirm closes the route and displays Sheet confirmed. Cancellation displays Sheet cancelled.
4. A caller-supplied consuming success callback keeps the route open.
5. Reopening creates a fresh sheet Cubit, with no stale errors or disposed controller access.
6. Content and actions remain usable across light/dark themes, supported window sizes, and insets.

## Current verification

Scoped Dart analysis of the feature passes. Runtime navigation, scrolling, cancellation, callback consumption, repeated opens, viewport fit, and theme appearance await Stage 7. Automated tests await a separate developer decision. Existing routing logs establish only partial navigation evidence; gesture and displayed-result correctness require runtime observation. The diagnostic specification has a separate text-approval gate in the bottom-sheet plan.
