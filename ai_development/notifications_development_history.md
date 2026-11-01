# Notification Development History

## Developer request and decisions

1. Developer: "For Apollo Declarative, we want to start introducing Flutter local notifications and the support for Firebase push notifications. And we wanted to do it architecturally correct. So we want to create the issue and then call decomposition skill and ask if we need decompositions and context and responsibility detector. So we build everything correct. So let's plan."
2. Planning located the target Apollo checkout at AndroidStudioProjects/apollo1, distinct from the blueprint chat workspace, and inspected its own folder rules, skills and implementation. Issue creation failed with the connector's 403; browser access was disabled. No issue was created.
3. Developer: "Remember, important to support iOS and Android."
4. Both platforms became required for local and remote capabilities. Decomposition recommended local delivery followed by Firebase client integration, with scheduling and backend sending as separate optional work. Detailed draft: the current job's temporary apollo_notifications_planning.txt; it is historical proposal evidence, not current code authority.
5. Developer: "Okay, we'll create the issue later. For now, let's start implementing this."
6. Implementation proceeded without a ticket under that explicit instruction. Immediate display/cancellation and client-side Firebase support were selected as the minimal starting scope; scheduling/server scope and related-ticket discovery remain unanswered. No broad related-ticket search was performed.

## Implementation review

Target naming review corrected the proposed Manager: Managers coordinate multiple features; this foundation uses service adapters, App routing, and the existing screen Controller. No architecture guide changes were made. Current dependencies resolved with Flutter 3.38.9 and Dart 3.10.8. Firebase 17 exposes installation-ID registration events and deprecates older token methods, so the public registration Model preserves that distinction.

Permission prompts occur only from user actions. The local display slot and interaction identity are distinct so repeated example notifications can each navigate. Live/cold interactions are suppressed by interaction ID; histories are bounded and local to their owner. Services do not navigate, and the background callback does not access main-isolate DI or display a duplicate remote alert.

## Verification

The changed files pass Dart analysis. Android debug APK builds succeeded in both the isolated copy and the applied Apollo checkout. Broad analysis comparison found 192 baseline diagnostics and no added diagnostics. Xcode build-setting inspection and plist validation passed; no iOS compilation or signed/device push verification was completed. Broad analysis exposed unrelated inherited test/dependency diagnostics. There was no connected Android device. No new test files or Git commits were created. The Xcode skill's CocoaPods exception and the optional automated-test question remain pending.

This history preserves the task-relevant developer messages and decisions available to the implementation turn. User-facing assistant updates are summarized here; the earlier temporary planning draft and active chat retain the detailed proposal and progress exchange. No hidden reasoning, credentials, or notification payload contents are retained.

## Full conversation record and finalization scope decision

The [full available conversation transcript](notifications_conversation_transcript.md) now supplements this earlier summary. It retains public chat messages, relayed voice requests and recorded speech without private reasoning or tool internals. Its coverage cutoff and unavailable material are explicit.

The developer accepted separate finalization scopes for notification implementation, derived-app Firebase setup and the finalizer skill-selection fix. Existing approach/responsibility/pattern/declarative/naming results remain reusable while their inputs match. This documentation correction records implemented screen behavior and supplies its diagnostic procedure; it changes no runtime behavior and makes no new device-verification claim.

## 2026-11-01 — Documentation correction and iOS build resumption

The developer narrowed explicit Markdown wording approval to AGENTS.md files. Applied the pending notification documentation/transcript correction under the existing task authorization. Diagnostic specifications now match the implemented permission markers and document native/device-only limits. Resumed iOS simulator compilation through the existing Flutter/CocoaPods workflow; the first attempt exposed an inferred iOS 13 deployment target, so the Podfile now explicitly matches the application's existing iOS 15 requirement. The retry completed successfully: native dependency installation and the iOS simulator debug build pass. CocoaPods generated its usual Xcode project/workspace integration and lockfile. No framework Firebase project was created.

## 2026-11-01 — Exact guide-wording approval

After the agent displayed the full replacement sentence limiting explicit wording approval to AGENTS.md files, the developer replied “aprove.” The approved wording was already in place and was retained without another guide edit. The full public transcript preserves the earlier interpretation, the exact displayed sentence and this confirmation.
