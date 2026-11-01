# Notification Diagnostic Specification

## Native/device acceptance runs

Use this matrix when validating native/device behavior in a configured derived app. Framework source/build verification does not establish these runtime outcomes; unrun cases remain pending in the app's setup verification record. Run the cases on an Android device/emulator and an iOS device. Use a build with real Firebase/APNs configuration for remote cases. Establish a fresh process and send one controlled message at a time. Record platform, OS version, build, permission state and expected destination without storing notification bodies or registration identifiers in diagnostic logs.

## Existing evidence

The `notifications` logger category emits:

| Event | Evidence and limit |
|---|---|
| `notifications.local.initialized` | Plugin initialized and Android channel creation completed; no proof of permission or visible delivery. |
| `notifications.permission.authorized`, `.provisional`, `.denied` | Permission request result on a supported platform; denied does not prove the user previously rejected a prompt. Unsupported platforms return unavailable without logging this event. |
| `notifications.local.display.requested` | Native display call completed; verify visible presentation separately. |
| `notifications.local.cancelled` | Native cancellation call completed; inspect the tray separately. |
| `notifications.local.interaction` | A live local interaction converted to the typed contract. |
| `notifications.push.disabled` | Client integration skipped for this build/platform. |
| `notifications.push.initialized` | Firebase listeners are installed; no proof of registration/delivery. |
| `notifications.push.registration.requested` | Registration call completed; wait for registered outcome. |
| `notifications.push.registered`, `.unregistered` | SDK registration event observed, with identifier omitted. |
| `notifications.push.foreground.received` | Foreground message converted to the Domain representation. |
| `notifications.push.interaction` | Warm remote interaction converted successfully. |
| `notifications.routing.opened` | Accepted interaction requested the home route. Observe the mounted destination. |
| `notifications.routing.destination.rejected` | Destination was outside the supported route contract. |

`notifications.push.background.received` is emitted through `dart:developer` in the background execution context. Background initialization failures use the AppFailure marker `notifications.push.background.failed` in the same system log. Collect the system/device log for these markers; it is not guaranteed to be present in the main-isolate session log export.

Failure chains identify initialization, permission, display, cancellation, message conversion, registration, malformed payload and launch-interaction failures. Routing consumes and logs interaction failures. About Apollo emits ControllerFailure to its existing UI listener, which logs and renders it. Do not require one failure log per layer.

## Ordered verification

1. Default build: confirm local initialization and push-disabled evidence. Starting the app must not request notification permission.
2. Tap Enable notifications. Compare the permission event and visible status with the OS outcome. Verify denial and changing permission in system settings; test display rechecks current OS permission.
3. Show a test notification. Confirm one display-request marker and one visible notification, with the correct Android small icon/channel and iOS presentation. A successful call alone cannot pass this case.
4. Tap it with the app running, backgrounded and cold-started. Confirm the mounted home destination and one routing-open marker per interaction. A cold launch need not emit the live local-interaction marker.
5. Display and tap a new example in the same process. It must open again despite using native slot 1001. Then cancel the example and inspect the tray.
6. With Firebase configured/enabled, grant permission and request registration. Expect initialized, registration requested and registered evidence; asynchronous ordering of requested/registered can vary. Inspect the typed registration stream using the test harness/debugger when validating its identifier; no raw identifier belongs in logs.
7. Send a version-1 routable notification in foreground. Expect foreground received and one local display request while About Apollo's Controller is alive. Tap the local alert and verify the home route. Repeat the same message delivery to exercise suppression within that Controller's lifetime.
8. Send remote notification payloads in background and terminated states. Inspect OS presentation, system background evidence when delivered, and warm/cold tap navigation. No extra local display request should be issued by the background callback. Exercise supported iOS/APNs and Android behavior independently.
9. Send a data-only message. Foreground receipt may be observed; no automatic visible notification is required. Background receipt is OS-dependent.
10. Exercise a malformed/unsupported payload and an unknown destination. Confirm failure/rejection evidence and no unauthorized navigation. Reinitialize/dispose the owning app/controller and verify listener cleanup without duplicate display or navigation.
11. Exercise SDK registration refresh and unregister/register using the public contract. Verify registered/unregistered events and future backend ownership separately; no server upload is implemented here.

## Limitations

Logs cannot prove visible tray presentation, permission dialogs, signed APNs entitlement validity, OS delivery guarantees, or final mounted navigation. Controlled runtime observations are required. Deduplication histories are bounded and process/Controller-local, not persistent exactly-once guarantees. Successful local presentation without an SDK message ID cannot establish remote duplicate suppression. No message contents or raw registration identifiers are logged, so uncontrolled concurrent deliveries cannot be reliably correlated from these redacted markers alone.
