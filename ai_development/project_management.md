# Apollo Declarative Project Management

## Project setup record

Each project owns `ai_development/project_setup.json`. Read it for confirmed identity, project management configuration, setup progress, and maintenance completion. New project management skills use the `-apollo-declarative` suffix.

Create or complete the record during setup using confirmed answers. Default scaffold identity includes the display name `Apollo Declarative` and Dart package `ai_declarative_foldering_architecture`. Repository role is established from the primary project remote and the developer's purpose; a retained upstream reference remote identifies ancestry.

The record has this shape; `null` means unknown and optional choices may be recorded as declined:

```json
{
  "repository_role": "derived",
  "setup_complete": false,
  "identity": {
    "display_name": null,
    "ios_bundle_id": null,
    "android_application_id": null
  },
  "project_management": {
    "system": null,
    "plugin": null,
    "project_id": null,
    "project_url": null,
    "state_mapping": {}
  },
  "firebase_notifications": {
    "choice": null,
    "project_id": null,
    "android_app_id": null,
    "ios_app_id": null,
    "configuration": {"android": null, "ios": null},
    "apns": null,
    "registration_owner": null,
    "verification": {"android": null, "ios": null},
    "pending_actions": []
  },
  "follow_up_chats": {
    "app_store_connect": null,
    "google_play": null,
    "icon": null
  },
  "upstream": {
    "repository_url": "https://github.com/konstantinvoronov/apollo-declarative",
    "star": null,
    "subscription": null,
    "update_check": null
  },
  "maintenance": {
    "last_completed_at": null,
    "chat": null
  }
}
```

Each accepted follow-up records the returned chat identifier/link and its actual progress; a declined offer records that choice. Set `setup_complete` after identity and project management choices are confirmed and the setup offers are resolved. Registration and artwork progress remain separate from setup completion. Maintenance completion uses an ISO 8601 timestamp with timezone after the maintenance skill completes its agreed scope.

Resolve the optional Firebase choice as enabled, declined or deferred. Firebase configuration, APNs readiness, registration handoff and device verification retain their own progress separately from core setup completion. Use `firebase_notifications` for confirmed identifiers, observed per-platform progress and pending actions; keep private credentials in the selected credential provider or secure local location.

Project setup and work-item records remain project-owned. Shared synchronization carries the instructions; each derived project establishes its own configuration. Plugin connections own credentials.

## Project management system

Ask which system and plugin the developer wants, recommending GitHub and GitHub Projects. Record the selected repository/project and inspect the connected capabilities for issues, milestone equivalents, statuses, and dashboard fields. Use the chosen system's terminology.

Map the workflow states below to available statuses or fields and offer a board/dashboard showing ongoing work. With limited plugin support, retain the confirmed state and the proposed tracker update in the work record and explain the available manual step. Core ticket work can continue independently of dashboard support.

## Work records and chat titles

Use the existing [ticket record contract](ticket_review_records.md) for context and review evidence. Keep the active item, its canonical title/URL, chat reference, confirmed workflow state, and pending tracker updates in `work_state.md` under that item's record folder. Unassigned work uses the contract's temporary job folder until associated with a real item.

Once the issue or milestone title is finalized, rename its working chat to `[State] Item title`. Update the prefix on meaningful transitions using the available chat-title tool. Match the actual work state:

| State | Evidence |
| --- | --- |
| Discussion | Scope or requirements are being resolved. |
| In progress | Authorized implementation is underway. |
| Needs attention | A developer decision or external action is required. |
| Pending finalization | Implementation is ready for outstanding completion checks. |
| Committed | The current work's commit has been verified. |

Update the mapped tracker status/field through the selected plugin within the authorized workflow, retaining the confirmed outcome. Keep commit evidence distinct from the provider's issue-closure criteria. If tracker or chat-title tools are unavailable, report the pending update precisely.

## Finalization handoff

After successful `finalize-job` verification, request the appropriate ticket-state update through the selected project management workflow. Apply the accepted update outside the audit and confirm it. Reflect the verified work state in the chat prefix and retain any pending tracker transition in the work record.
