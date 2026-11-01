---
name: setup-apollo-declarative
description: Set up a derived Apollo application with its name, application IDs, project management choice, optional Firebase notifications for iOS and Android, and registration, icon, and upstream follow-ups. Use on explicit setup requests or the root guide's incomplete-default-project trigger.
---

# Setup Apollo Declarative

Use the active project's [project management conventions](../../../ai_development/project_management.md). Resume confirmed answers and recorded follow-ups from its setup record.

Ask for the application display name, iOS bundle ID, and Android application ID. Record the confirmed choices; application identity changes follow the project's implementation and approval workflow.

Offer Firebase push-notification setup for the derived application's iOS and Android apps. Ask whether to use an existing Firebase project, create a new project, or defer this integration; reuse confirmed setup answers. Apollo's upstream framework carries the capability and setup instructions without a project-specific Firebase configuration.

When accepted, inspect available Firebase tools and authentication, confirm the selected account/project and the native identifiers established above, then reuse matching Firebase app registrations or create the missing registrations within the authorized setup. Prefer connected tools; use available Firebase setup skills and the CLI when needed. Fetch the matching Android and iOS configuration files programmatically, install them in the derived app, and verify that the iOS configuration is bundled in Runner's resources. Follow the target project's native dependency workflow and protected-file approvals.

Collect the Apple team, APNs key identifier and secure local credential location, and complete the Firebase/APNs and push-capable signing configuration with the developer using available capabilities. Keep private key material and service-account credentials out of setup records, transcripts and shared framework files. Record unavailable access or remaining manual actions precisely. Enable the derived app's Firebase integration after its required configuration is ready; preserve local notifications when Firebase is deferred.

Ask which app-specific backend or consumer owns registration identifiers, user/device association and refresh/removal. Inspect the installed SDK's registration contract before calling an identifier a token. Use the framework's existing registration events for the handoff. If no owner exists, record targeted sending and persistence as pending; configuring Firebase does not authorize building a backend or adding storage to the framework.

Retain the choice, project/app IDs, per-platform configuration and verification, APNs progress, registration owner and remaining actions in the project's `firebase_notifications` setup record. Verify receipt, display and tap routing in foreground, background and cold-start scenarios on both iOS and Android when credentials and devices are available. Distinguish configuration from verified delivery; resume only unfinished steps.

Offer help registering the application in App Store Connect and Google Play Console. For each accepted offer, create a separate project chat with the confirmed identity and an explicit goal to complete that store's application registration. Let the registration chat establish account prerequisites and complete the process with the developer. Tell the developer which chats were actually created and record their references. Reuse an existing matching registration chat when resuming.

Ask which project management system or plugin to use, recommending GitHub with GitHub Projects. Establish the selected repository/project and the available state/dashboard mapping under the shared conventions.

Offer an app-icon chat. On acceptance, create a separate project chat invoking the local `create-icon-apollo-declarative` skill with the confirmed app details. Explain that its current version is a placeholder and record the chat reference.

Offer to star [Apollo Declarative](https://github.com/konstantinvoronov/apollo-declarative). Act on acceptance using an available authorized capability. After the star is confirmed, offer to subscribe to repository updates and act on acceptance. If an action needs manual completion, provide its repository link and record the actual outcome.

Explain that the local `update-framework-harness` skill reviews upstream changes for selective adoption. Ask whether to check now; run that skill when accepted and retain its baseline and approval procedure.

Use the available project-chat tools for accepted follow-ups and include their registration goals in the opening prompts; set an explicit goal within each registration chat when goal tracking is available. Report unavailable capabilities and retain the accepted follow-up as pending. Finish by saving setup progress under the shared completion convention.
