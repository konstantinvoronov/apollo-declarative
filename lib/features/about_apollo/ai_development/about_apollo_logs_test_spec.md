# About Apollo Notification Diagnostic Specification

Scope: the current notification controls, registration observation, foreground presentation and notification-error handling in AboutApolloCubit/State/Screen. Existing sheet and log-sharing features retain their separate verification work.

Use the Core [notification diagnostic specification](../../../../ai_development/notifications_logs_test_spec.md) for exact service/router events and the ordered iOS/Android lifecycle matrix. Run one controlled operation at a time. Logs omit notification bodies and registration identifiers.

| Feature behavior | Existing evidence | Required observation or limit |
|---|---|---|
| Permission action | `notifications.permission.authorized`, `.provisional` or `.denied`; State holds the result | Inspect the OS dialog and visible status. No prompt is requested during initialization. Unsupported platforms return unavailable without emitting a permission-result event and hide mobile controls. |
| Show/cancel example | `notifications.local.display.requested` and `.cancelled` | Inspect actual tray presentation/removal. Display-call completion does not prove visible delivery. |
| Tap example repeatedly | `notifications.routing.opened` after each distinct interaction | Verify mounted home, including warm and cold starts. Native slot 1001 is stable; each displayed example has a distinct interaction identity. |
| Foreground push | `notifications.push.foreground.received`, followed by one local display request for presentable content | Requires a configured derived app and a living AboutApolloCubit. Repeated known SDK message IDs are suppressed within its bounded history. Data-only messages require no visible presentation. |
| Registration action/events | Registration-requested, registered/unregistered service events and the retained registration Model | This is SDK registration evidence; no backend upload or user/device association is implemented. Event ordering can vary. |
| Failures | The existing UI failure listener consumes the ControllerFailure chain | Confirm the failure is rendered/cleared through the existing handler. Do not expect redundant failure records at every layer. |
| Repeated actions and disposal | Controller busy state and source-owned subscription cancellation | Verify disabled controls while busy, then fresh actions after completion. Listener cleanup and mounted UI behavior require runtime observation. No extra logging-only implementation is required. |

AI verification: establish build/platform/permission state; run permission, display, cancellation and live/cold tap cases; then run configured registration and foreground/background remote cases; compare redacted service/router events with actual UI/tray outcomes. Record which cases were observed, failed or could not run. iOS simulator compilation passes; both-platform device QA remains unverified. Logs alone cannot establish signed APNs readiness, OS delivery guarantees, visible display or final mounted navigation.
