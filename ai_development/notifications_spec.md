# Flutter Notifications

## Scope

Apollo provides immediate local notification display/cancellation and an opt-in Firebase push client on both iOS and Android. The About Apollo screen demonstrates permission requests, a local test notification, cancellation, and push registration when the Firebase integration is enabled. Scheduling and backend sending remain separate work. Issue creation was explicitly deferred by the developer.

## Ownership and dependencies

`lib/core/domain/services/i_app_local_notification_service.dart` and `i_app_push_notification_service.dart` expose portable capability contracts. Domain Models represent local content, interactions, permission status, push messages, and registration events. SDK types remain inside concrete Core Services. `AppNotificationServiceMapper` in Services converts the versioned integration payload to Domain interactions.

Core DI initializes and disposes the Services through the existing App DI helper chain. `AboutApolloCubit` owns user permission actions and foreground notification presentation while that screen's Controller is alive. `AppBootstrap` starts notification routing after the first frame. `AppRouter` subscribes to live interactions and then consumes local and remote launch interactions, accepting only the known `home` destination. It suppresses repeated interactions using a bounded collection of the last 128 interaction identifiers. A Manager is unnecessary: this implementation does not coordinate multiple features. Core Flow rules stay unchanged.

## Local notifications

Initialization creates the Android `apollo_notifications` channel and configures iOS without prompting. Enable notifications requests permission following the user's action. The UI distinguishes authorized, provisional, denied, unavailable, and unread permission states; denied includes an instruction to use system settings. The permission adapter does not claim to distinguish never-requested from denied when the platform API cannot do so.

Show test notification checks OS permission and asks the plugin to display notification 1001. Each display has a new interaction ID, independent of the stable native ID used for cancellation. Tap opens the home route, including a cold launch. Cancellation removes the demonstration notification. A display-request success proves the platform call completed; a device observation must prove a visible alert.

On non-mobile platforms these Services report unsupported/disabled status and the screen hides mobile controls. Cross-platform generated plugin registrations accompany dependency resolution; additional notification platforms have not been verified.

## Firebase configuration

The default build uses `APOLLO_FIREBASE_PUSH_ENABLED=false`. Local notifications work without Firebase app configuration. Enable Firebase only after registering both native applications in the intended Firebase project:

1. Match the Android application ID and iOS bundle identifier, currently `com.kvoronov.apollo`.
2. Place the matching `google-services.json` in `android/app/`. The Google Services Gradle plugin is applied only when that file exists.
3. Add the matching `GoogleService-Info.plist` to the Runner target's bundled resources using the project's native configuration workflow. Merely placing the file on disk in this existing Xcode project is insufficient proof of resource inclusion.
4. Configure APNs in Firebase and use provisioning that supports push. Runner uses `Runner.entitlements` with development APS environment for Debug and production for Release/Profile. Remote-notification and fetch background modes are declared. Verify the signed application's effective entitlements.
5. Run with `--dart-define=APOLLO_FIREBASE_PUSH_ENABLED=true` after configuration. An enabled integration with missing configuration fails initialization visibly through the existing startup error handling.

Dependencies resolve as `flutter_local_notifications` 22.3.3, `firebase_core` 5.1.0 and `firebase_messaging` 17.0.1. The selected Firebase native integration requires iOS 15 or later; target xcconfig files and the Podfile set 15.0. Android compiles against API 36 with Java 17/desugaring. Flutter 3.38.9 / Dart 3.10.8 was used for dependency resolution and Android verification.

The current Firebase plugin uses `register` / `unregister` and registration events carrying a Firebase Installation ID. `AppPushRegistrationModel` identifies that value explicitly. It is not presented as a legacy FCM token. The registration stream exposes registered and unregistered outcomes to future trusted-server integration. Registration is explicit after notification permission; automatic initialization is disabled in the native configuration, enabled on registration, and disabled on unregistration. Existing registrations may persist across process restarts according to the SDK.

## Message and interaction contract

For routable remote notifications include notification title/body plus these string-valued data fields:

```json
{
  "version": "1",
  "notification_id": "a-unique-delivery-identifier",
  "destination": "home"
}
```

The notification ID identifies a delivery/interaction, rather than a native notification slot. Unknown schema versions, missing fields, and malformed interaction data produce typed failures. Unknown destinations are rejected in App routing; remote route strings never directly authorize navigation.

Foreground receipt emits a typed message. SDK automatic foreground display is disabled so the About Apollo Controller can request one local display for a notification payload. Repeated messages with the same SDK message ID are suppressed within that Controller's bounded history. A data-only message does not automatically become a visible alert. Background remote notification display belongs to the OS/SDK; the background callback does not create a second local alert or navigate.

`receiveAppBackgroundPush` is a top-level retained entrypoint. It initializes Firebase in its own execution context and records a redacted diagnostic marker through the system developer log. It does not assume the main-isolate DI container, routing, or UI exists. Background delivery remains subject to OS restrictions; this code does not guarantee delivery after force-stop or user termination.

## Failures and verification limits

Operations return AppResult and preserve AppFailure chains. The final routing or UI consumer logs failures. Diagnostic messages exclude notification contents and registration identifiers. No backend association, push sender, subscription/topic policy, or scheduled reminder has been added.

Changed-file analysis and the Android debug build pass in the applied Apollo checkout. Broad analysis has 192 baseline diagnostics and no added diagnostics. Xcode resolves the expected deployment target and entitlement settings; plists validate. The iOS simulator debug build passes through the existing Flutter/CocoaPods workflow. Signed provisioning checks and real-device behavior on both platforms remain pending. Repository-wide analysis still reports pre-existing test/dependency diagnostics and other unrelated notices. See `notifications_logs_test_spec.md` for device QA.

Primary references: [local plugin](https://pub.dev/packages/flutter_local_notifications), [Firebase setup](https://firebase.google.com/docs/cloud-messaging/flutter/get-started), [Firebase receive/interaction behavior](https://firebase.google.com/docs/cloud-messaging/flutter/receive-messages).
