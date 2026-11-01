# Notification Implementation Progress

## Accepted scope

The developer confirmed iOS and Android and authorized implementation while deferring issue creation. Implement immediate local display/cancellation, permission UX, typed interactions and opt-in Firebase push client reception/registration. Scheduling, server delivery and backend registration remain separate scope choices.

## Implemented

- Portable Core service contracts and value Models, concrete local/FCM adapters, and an integration payload Mapper.
- Existing Core DI initialization/disposal, first-frame App routing subscriptions, known-destination mapping and bounded interaction suppression.
- About Apollo permission/display/cancel/register actions and Controller-owned foreground presentation.
- Android permissions, channel/icon defaults, optional Google Services configuration and desugaring.
- iOS notification-center delegation, background modes, entitlement configuration and deployment target 15.0 through xcconfig. Frozen main.dart and protected library sources stay unchanged. The iOS build generated the normal CocoaPods project/workspace integration and Podfile.lock; the blueprint AGENTS.md approval rule was separately clarified and approved.

## Verification and remaining work

Changed-file Dart analysis and the Android debug APK build pass in the applied Apollo checkout. Repository-wide comparison found the same 192 diagnostics as the original source, with no added diagnostics. Xcode resolves deployment target 15.0 and Runner/Runner.entitlements in Debug, Release and Profile; APS environment is development in Debug and production in Release/Profile; plist validation passes. Full repository analysis has unrelated existing test/dependency errors and warnings. The iOS simulator debug build also passes after explicitly setting the Podfile platform to the existing iOS 15 target. No automated tests were added while the developer's test preference remains unanswered. No Android device was connected.

The earlier CocoaPods approval gate came from a generic native Xcode skill and was unnecessary for Apollo's established Flutter/CocoaPods workflow. The first simulator build exposed CocoaPods inferring iOS 13; the Podfile now explicitly matches the existing iOS 15 application requirement. Native dependency installation and the iOS simulator debug build now pass. Effective signed entitlements and configured two-platform device delivery remain unverified; each derived app supplies its own Firebase/APNs configuration.

The earlier plan's Manager was removed after target naming review: no multi-feature coordination exists. Delivery 1 (local) and Delivery 2 (push) remain distinct future commit boundaries; the implementation is uncommitted and no finalization PASS is claimed. Issue creation stays deferred by explicit developer instruction.

## Read-only source review

Core and App entrypoints, Domain/Service/Mapper roles, screen-to-Controller interactions, frozen/protected files and scoped routing patterns were checked against the applied source. No new naming, responsibility or dependency-boundary deviation was found in that scope. No developer-declared code violation was present to record. The planned local/push delivery split remains recommended; this is not a finalization or commit PASS. Diagnostic events and limitations are specified, while device observations remain unverified.

## Framework delivery verification boundary

For this framework-only delivery, verification comprises the source/architecture guards, scoped Dart analysis, Android debug compilation and iOS simulator debug compilation. These pass. The native/device matrix remains acceptance work for a configured derived app; no live Firebase/APNs delivery or device UI outcome is claimed by the framework build checks. Apollo itself receives no Firebase project. The setup workflow records app-specific configuration and verification separately.
