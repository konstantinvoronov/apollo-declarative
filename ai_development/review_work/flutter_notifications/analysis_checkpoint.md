# Notification Finalization Checkpoint

Date: 2026-11-01, Europe/Podgorica. Item: unassigned by explicit developer instruction.
Current scope spans Apollo application/framework changes and the corresponding blueprint workflow updates. Exact input hashes and revisions are in `scope_fingerprints.json`.

## Developer decisions and workflow correction

- Both iOS and Android required. Immediate local display/cancellation and opt-in push client are implemented. Scheduling, server sending and registration storage remain separate scope.
- Developer accepted the two-service architecture, and required Firebase/APNs configuration to belong to derived-app setup. The exact setup amendment was approved and applied.
- Developer explicitly selected the supplied complexity-review definition, overriding the earlier missing-local-copy availability block. The exact finalizer amendment allowing explicitly supplied guard definitions was then approved through the wording question and applied to the blueprint source only. No reviewer skill was copied into Apollo.
- No new qualifying developer-declared code violation exists. File-count feedback and setup direction are scope decisions, not violation declarations.

## Stage 1 — Completed guard coverage

| Guard | Result | Evidence |
|---|---|---|
| Solution approach | PASS / READY | Fresh separate Astra medium review: `solution_review_18b2b97d9235b734.md`. The finalizer clarification is non-algorithmic documentation. |
| Responsibility resolver and leakage | PASS | Profiles and actual inbound/outbound consumers checked below; no confirmed declaration violation or behavioral leak. |
| Pattern keeper | PASS | Apollo project-wide catalog has no concrete entries; routing's parameterized-push and completion patterns do not impose parameters/completion callbacks on the existing parameterless home route. Blueprint project catalog is empty. No other applicable ancestor catalogs were found. |
| Declarative rules | PASS | Domain/Services/Mapper/App/Controller placement, concrete/interface boundaries and both dependency directions checked; native/generated configuration retains platform ownership. Exact setup/finalizer Markdown approvals verified. main.dart, AGENTS guides and protected library source unchanged. |
| Naming | PASS | Service interfaces/concretes, Models, owner-layer ServiceMapper, existing screen Cubit/State, DI functions and native resource names match their declared roles. No Manager/use-case/repository introduced. |
| Task decomposition | PASS for accepted separate scopes | The developer answered yes to auditing notification implementation, derived-app setup workflow and finalizer correction separately. No staging or commit authorization was inferred. |

### Responsibility profiles and actual comparison

- Notification interfaces: app-wide Core Domain, abstractions named IAppLocalNotificationService/IAppPushNotificationService. Portable capability contracts; may consume own Domain Models and approved AppFailure representation; may be consumed by matching Services, App/DI and the feature Controller. Flutter/FCM/local-plugin implementations, UI and App wiring are forbidden outbound dependencies. Source signatures/imports contain none of those forbidden dependencies.
- Five new Models/status enums: app-wide Core Domain value declarations. Data only; pure Domain/Dart dependencies; consumed by capability contracts, adapters, App routing and the Controller. No I/O, routing or SDK types escape through these representations.
- Concrete local and push Services: app-wide Services implementations of the matching Domain contracts. Own SDK initialization, permission calls, registration, display/cancel and callback conversion. Depend on Domain contracts/values, the Services-owned Mapper and their SDKs. Constructed in Core DI; feature and App consumers receive interfaces. No feature implementation or App routing dependency exists. The background SDK entrypoint remains inside its concrete integration.
- AppNotificationServiceMapper: app-wide Services supporting responsibility, owner role Service. Pure representation conversion for the two Services, same owner-layer boundaries; consumes Domain values and dart:convert. No I/O, route selection or product display policy.
- Core/App DI and bootstrap: wiring only. Existing global DI still imports only its helpers; App Core helper still imports only public Core coordinator. Core coordinator constructs/initializes/disposes Core integrations. Bootstrap connects routing after first mount; no feature registration in Core or plugin imports into global DI.
- AppRouter: App routing composition. Consumes portable interaction contracts, maps only known home destination, deduplicates and owns subscription cleanup. Its feature boundary remains the public presentation/routing.dart entrypoint.
- AboutApolloCubit/State/Screen: feature Presentation. Controller consumes Domain contracts and owns the screen's user actions, foreground presentation and error/state transitions; Screen invokes its Controller. Existing feature-root DI constructs the Controller. No SDK integrations or multi-feature coordination were introduced in Presentation.
- Setup/finalizer instructions and conventions: harness workflow ownership, outside runtime source. Confirmed Firebase identity/progress belong to project records; no actual framework Firebase credentials/configuration were created. Synchronization changes are limited to the explicitly selected approved setup units.

Controlling sources: Apollo `ai_development/declarative_foldering_rules.md` sections 1-6; `lib/AGENTS.md`; `lib/core/AGENTS.md:9-26`; `lib/core/services/AGENTS.md:9-30`; `lib/app/AGENTS.md:15-39`; `lib/app/di/AGENTS.md:9-15,21-58`; feature root/Presentation/Controller blueprint guides. Core Flow allow-lists remain unchanged; no notification dependency was added there.

## Accepted separate scopes — prior split proposal retained

Mode: change-set audit. Two repositories; one notification capability plus two workflow outcomes. The finalizer correction is independently useful and has no runtime/setup dependency. Setup publication can also be reviewed separately from SDK/native delivery. This split concerns finalization/commit boundaries, not architectural layers or object removal. Preserve the current working-tree snapshot before any separately authorized staging/reorganization; this audit performed no Git mutation.

1. Notification capability in Apollo. Scope: the 36-file runtime/native/dependency/example/diagnostic group in the original implementation manifest, retaining all behavior, specification and verification evidence together. Outcome: local display/cancel and optional push receive/register/tap paths for both platforms. Acceptance/verification: existing scoped analysis and Android build evidence plus the remaining configured iOS/device matrix. Dependencies: selected app Firebase/APNs credentials for remote runtime verification; no backend storage invented. Intended commit boundary: one coherent notification capability delivery; only split local and push further if that preserves independently buildable review scopes.
2. Derived-app Firebase setup workflow in blueprint and Apollo. Scope: setup skill, project-management schema, required ticket-record contract publication, selected synchronization entries/state and workflow evidence. Outcome: collect and configure each derived app's native Firebase/APNs details and retain pending registration ownership. Depends on the framework capability contract, not a hardcoded Apollo Firebase project. Acceptance/verification: exact approved wording, valid skill/schema, matching synchronized content; live setup exercise remains explicitly unverified. Documentation: setup/conventions stay with this outcome; device diagnostics belong to the configured app rather than the skill itself. Intended boundary: matching workflow commits in each repository.
3. Explicit guard-definition selection in blueprint finalizer. Scope: `.agents/skills/finalize-job/SKILL.md` only and its own necessary review evidence. Outcome: a developer-supplied guard definition satisfies availability while reviewed-project rules remain authoritative. No notification dependency. Acceptance/verification: exact approved patch and skill validation; no runtime diagnostics applicable. Intended boundary: separate small harness correction.

Shared files inside a task's behavior/wiring/specification/native/dependency group move together. The finalizer file can be isolated without changing runtime or setup files. Keep shared setup schema/skill/sync records consistent across their repository commits. No reset, staging, commit, tracker mutation or cleanup was performed.

## Current resumption — exact approval scope confirmed

The developer clarified that approval applies to AGENTS.md files, requested the specific correction, then approved the full displayed replacement sentence with “aprove.” The blueprint guide changes only `.md` to `AGENTS.md` in that sentence. The approved wording was retained without another guide edit. The full public transcript records this confirmation.

Stage 1 remains PASS within the three accepted scopes. The application mechanism is unchanged. Focused rechecks cover the guide approval correction, documentation-only updates, and the Podfile matching the existing iOS 15 target plus CocoaPods-generated project/workspace/lock integration. The prior Astra approach assessment remains applicable; no fresh algorithm review was needed.

## Stage 2 — Current results

- Documentation: PASS. Feature specification/plan/history now describe the notification controls. Both project histories link the full public typed/voice transcript; original unrelated history remains intact. The feature-specific diagnostic document is present and references the Core specification.
- Diagnostic specification alignment: PASS / COVERED. Permission, display/cancel, interactions, foreground/background reception, registration and failures match source. Unsupported platforms return unavailable without a permission-result marker. Native/device-only diagnostic limits are documented; no runtime code was added solely for logging.
- Scoped Dart analysis and Android debug build: PASS, reused for unchanged code.
- iOS simulator debug build: PASS. CocoaPods initially inferred iOS 13; the Podfile now explicitly matches the app's existing iOS 15 target. Dependency installation and Xcode compilation succeeded. Evidence: /private/tmp/apollo_notifications_ios_build.log and build/ios/iphonesimulator/Runner.app. CocoaPods generated standard project/workspace integration and Podfile.lock.
- Configured-app native/device acceptance: NOT APPLICABLE to the current unconfigured framework delivery; remains pending and unverified for derived-app setup. Earlier treating a Firebase-configured device run as an Apollo-framework completion gate was a scope interpretation error. The developer explicitly required no project-specific Firebase configuration for Apollo. Appropriate framework verification is the completed source/architecture review, scoped analysis and both native compilation checks. No native UI or real delivery outcome is claimed. Inventory on resumption found no Android device and one booted iOS simulator; no app was installed or exercised.
- Setup-workflow and finalizer/approval-rule scopes: Stage 2 PASS for instruction/documentation validation. Skill validators, schema example, local links and targeted setup synchronization pass. Live setup was not executed against a derived app and is not claimed as tested. Feature-runtime diagnostics are not applicable to these documentation-only scopes.

## Stage 3 — Completion status

All three scopes have passed applicable Stages 1 and 2 for the framework/instruction delivery. Derived-app native/device acceptance remains explicitly unverified rather than passed. Git completion: FAIL because current-job changes and retained records are uncommitted. No commits, staging, tracker changes or broad cleanup were performed. Ticket creation remains explicitly deferred.

Useful review evidence, fingerprints, diagnostic specifications and transcript references are retained. Owned temporary artifacts remain pending final retention. This is partial finalization, not a finalized job.

Next: separately authorized local commits for the accepted scopes, followed by read-only Git verification. Derived-app setup owns its later representative runtime notification verification. Reuse unaffected completed checks. Ordinary Markdown no longer requires separate wording approval; AGENTS.md modifications retain the explicit proposed-content approval requirement.

## Latest resumption

Current reviewed file hashes and repository heads were unchanged at invocation; completed guards/builds were reused. Scope clarification above applies the developer's existing framework requirement rather than requiring a Firebase project on Apollo. No runtime case was relabeled as passed. Final commit grouping is recorded in /private/tmp/apollo_finalization_commit_plan.json. No commit or staging action was performed by the audit.

## Commit preparation — developer authorization received

The developer requested explanation level 1; the unchanged implementation was explained from the retained Astra medium review after validating all 62 planned input hashes. The subsequent explicit instruction “commit” authorizes the four local commits in the reviewed plan. No push is authorized or planned. Before staging, the public transcript was refreshed and retention readiness recorded here. Applicable source, documentation and compilation checks remain valid; runtime notification acceptance remains unverified for configured derived apps.

Useful review evidence is retained in this folder and the project/feature documentation. Temporary approval patches, build/analysis logs, scope snapshots and the exact commit plan remain available for provenance; no cleanup is required to create the commits. Git completion is awaiting execution and subsequent read-only verification. This checkpoint records pre-commit readiness; later readers must combine it with actual Git history/status. Tracker creation and transition remain deferred by the developer; no ticket closure is claimed. The committed work state may be reported only after verification.
