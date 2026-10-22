# Apollo Declarative

An AI-driven application development framework by [Konstantin Voronov](https://github.com/konstantinvoronov), with a Flutter scaffold and working examples of declarative development.

Apollo brings the [AI Declarative Foldering Architecture](https://github.com/konstantinvoronov/ai_declarative_foldering_architecture) into a real application. It combines explicit architectural responsibilities, reusable modules, implementation patterns, and project-local AI skills to support production-oriented development.

The project is actively evolving. Implemented examples and their verification limits are recorded in the development plans.

## Built on

- **[ai_declarative_foldering_architecture](https://github.com/konstantinvoronov/ai_declarative_foldering_architecture)** — folder-based declarations of ownership, architectural layers, responsibilities, naming, and dependency boundaries, together with skills for AI-assisted implementation and review.
- **[stateful_data](https://pub.dev/packages/stateful_data)** — explicit, typed lifecycles for individual data values, separate from a screen or Cubit's overall state.
- **[app_failure](https://pub.dev/packages/app_failure)** — structured failures, failure chains, and `AppResult<T>` for visible success and failure paths across layers.

## The declarative approach

Folders describe where code belongs and which dependencies it can use. The project's [foldering contract](ai_development/declarative_foldering_rules.md) defines the general rules; scoped `AGENTS.md` files declare specific overrides.

Features introduce the layers their responsibilities need. The initial example uses Screen + Cubit/State + routing + DI, with Core contracts for application-wide capabilities.

Project and folder patterns guide implementation consistency. AI skills help resolve responsibilities, review context and naming, check architectural boundaries, and explain changes by layer. These checks support human review; their findings and verification evidence remain explicit.

## Included examples and foundations

- About Apollo screen with application version/build metadata.
- Cubit/State patterns with typed status and error handling.
- Feature-root DI and public routing entrypoints.
- Light/dark themes, localization, and predefined typography/layout helpers.
- Legacy modal and alternative snapping bottom-sheet examples with typed completion callbacks.
- App-wide logging, settings/session foundations, and generic synchronous/asynchronous use-case contracts.
- Ten taps on the version/build label to prepare a password-protected session-log ZIP and request native sharing.
- Project-local AI skills, pattern and violation records, and shared-harness synchronization tooling.

## Project structure

```text
lib/
  app/                     startup, configuration, routing, and composition
  core/                    application-wide contracts and capabilities
  features/about_apollo/   example feature, its Controller, UI, DI, and routes
  libs/                    reusable modules with architectural paths
  shared/                  project-specific adaptations of reusable modules
ai_development/            architecture contract, patterns, plans, and harness
.agents/skills/            project-local AI development and review skills
packages/sheet/            vendored bottom-sheet package
```

Within each architectural scope, Domain, Data, Services, Infrastructure, and Presentation retain their declared responsibilities. Library ownership and Shared adaptation preserve those layer boundaries.

## Run locally

Use a Flutter SDK compatible with the [pubspec](pubspec.yaml), including Dart `^3.10.8`.

```sh
git clone https://github.com/konstantinvoronov/apollo-declarative.git
cd apollo-declarative
flutter pub get
flutter run
```

The native application identifier is `com.kvoronov.apollo`; its display name is **Apollo Declarative**.

## Working with an AI agent

Start with [lib/AGENTS.md](lib/AGENTS.md) and the [project-local AI harness](ai_development/ai_harness.md). Use Apollo's own `.agents/skills` and the rules applicable to the files involved in the task.

The [implementation plan](ai_development/implementation_plan.md) records migration progress, approvals, and verification. The [About Apollo specification](lib/features/about_apollo/ai_development/feature_spec.md) describes the current example.

Apollo carries its own harness and skills. Shared harness definitions can be synchronized with the architecture project through the documented sync workflow; patterns, violation history, and application source remain project-owned.

## AI skills by workflow stage

Invoke the linked project-local skills using `$skill-name` in a compatible AI tool. The agent performs their checks and reports evidence.

### Orientation and architectural design

- [human-developer-helper](.agents/skills/human-developer-helper/SKILL.md) — explain the current stage, useful next step, and why.
- [resolve-declarative-responsibilities](.agents/skills/resolve-declarative-responsibilities/SKILL.md) — resolve proposed objects' roles, names, layers, placement, and both dependency directions before implementation.

### After the initial plan is built

- [context-checker](.agents/skills/context-checker/SKILL.md) — verify the plan uses sufficient, relevant context and correctly interprets applicable instructions.
- [task-decomposer](.agents/skills/task-decomposer/SKILL.md) — review whether work should be split into smaller independent tasks; its current audit inputs are working-tree, staged, or committed changes. Use that evidence when available and distinguish planning recommendations from a completed change-set audit.

### When implementation is complete

Run [finalize-job](.agents/skills/finalize-job/SKILL.md). Its workflow automatically includes these project-local checks when the agent executes the skill:

- [pattern-keeper](.agents/skills/pattern-keeper/SKILL.md) — review the job against applicable implementation patterns and request corrections.
- [check-naming](.agents/skills/check-naming/SKILL.md) — verify names express established architectural roles.
- [check-declarative-rules](.agents/skills/check-declarative-rules/SKILL.md) — verify architectural declarations, dependency permissions, and approvals.
- [check-responsibility-leaks](.agents/skills/check-responsibility-leaks/SKILL.md) — compare actual behavior and dependencies with declared responsibilities.
- [task-decomposer](.agents/skills/task-decomposer/SKILL.md) — check the final change set for independent concerns requiring separation.
- [update-diagnostic-spec](.agents/skills/update-diagnostic-spec/SKILL.md) — audit affected features' diagnostic specifications; update mode is available during separately authorized diagnostics work.
- [violation](.agents/skills/violation/SKILL.md) — collect remaining developer-declared violations from the conversation before the final audits.

Finalization also checks verification evidence, feature documentation, protected files, and commit state. Invocation is an agent workflow requirement; evidence of execution establishes which checks actually ran.

### Understand changes and review code

- [update-by-layer](.agents/skills/update-by-layer/SKILL.md) — explain changes by architectural layer and responsibility, naming objects, files, and generated updates.
- [violation](.agents/skills/violation/SKILL.md) — record review findings declared by the developer, their cause, offending code, and confirmed intended correction.

### Investigate an existing violation

- [investigate-discovered-violation](.agents/skills/investigate-discovered-violation/SKILL.md) — explicitly reopen a discovered legacy-code or technical-debt finding for investigation, trace its evidenced causes and related occurrences, and propose remediation for approval. This is separate from recording a violation and can start outside an active task. It coordinates context, responsibility resolution, architecture, naming, and pattern reviews; approved corrections proceed through finalization and an update by layer. Historical evidence and current requirements are distinguished.

### Update Apollo Declarative in a derived project

- [update-framework-harness](.agents/skills/update-framework-harness/SKILL.md) — compare the project's recorded Apollo Declarative commit with latest upstream master, explain architectural harness changes with affected files, and offer adoption of all updates, selected improvements, or project-specific adaptations.

The project's [framework version](ai_development/apollo_declarative_version.json) is one upstream commit. After the developer's final decision and completion of selected changes, it advances to the commit inspected by that session, including when all updates are declined. The next session starts from that marker. A separate [update history](ai_development/apollo_declarative_update_history.md) explains completed sessions.

These tracking files remain project-owned. The skill uses the shared manifest to scope harness updates and preserves application source, local patterns, and violation history. Existing protected-file approvals remain active. Version tracking starts from the recorded baseline; the initial history entry explains how it was established.

### Periodic developer-led maintenance

- [maintain-ai-harness](.agents/skills/maintain-ai-harness/SKILL.md) — review harness consistency and performance using recent violations; help the developer resolve them and apply approved pattern or instruction updates.

## Start a project from Git

### Scenario 1: Use Apollo as your application scaffold

Create an empty destination repository, then:

```sh
git clone https://github.com/konstantinvoronov/apollo-declarative.git my-app
cd my-app
git remote rename origin apollo
git remote add origin https://github.com/YOUR_ACCOUNT/YOUR_REPOSITORY.git
git switch -c project-start
flutter pub get
flutter run
```

This preserves Apollo's starting history and keeps it as a reference remote. Push the approved baseline with `git push -u origin project-start` when ready.

First prompt:

```text
Read lib/AGENTS.md and ai_development/ai_harness.md. Use this project's local skills. Plan adapting Apollo for <describe the application>, including its display name, Dart package, native identifiers, and first feature. Identify the examples and reusable foundations to retain. Show proposed objects, responsibilities, layers, paths, and affected files; run context-checker before presenting the plan for approval.
```

Expected next step: approve the identity and first-feature adaptation. Apollo's current Dart package name remains `ai_declarative_foldering_architecture`; include its package imports in the identity review.

### Scenario 2: Start with architecture rules instead of the scaffold

Use the [architecture blueprint's Git startup instructions](https://github.com/konstantinvoronov/ai_declarative_foldering_architecture#start-a-project-from-git). Choose a published revision containing its current harness and skills, then plan the first minimal working feature. This route starts from architectural declarations rather than Apollo's implemented examples.

### Scenario 3: Adopt the harness in an existing application

Clone Apollo beside the existing project. From the Apollo directory, preview the explicitly listed shared files and sections:

```sh
python3 ai_development/sync_harness.py --source . --target /absolute/path/to/existing-project
```

First prompt:

```text
Review the harness synchronization preview against the existing project's instructions and architecture. Propose scoped adoption, preserving project-specific patterns, violation history, and source. Identify conflicts and exact instruction files requiring approval. Run context-checker on the plan and ask for approval before applying it.
```

Expected next step: approve selected changes and resolve conflicts. Apply the reviewed synchronization with the same command plus `--apply`; approve each affected AGENTS.md separately. The manifest transfers shared harness definitions; application source, project patterns, and violation history stay project-owned. The target's project-wide lib/AGENTS.md and pattern catalog need review alongside the shared definitions.

## Log sharing

Tap the version/build label ten times to request the native share sheet with a ZIP containing `session_log.txt`. The archive includes the existing application log contents; the user chooses the sharing destination.

Set the archive password at build/run time:

```sh
flutter run --dart-define=APOLLO_LOG_ARCHIVE_PASSWORD=your-support-password
```

The scaffold has a public development default. Build-embedded passwords are not confidential credentials; choose the log contents and distribution policy appropriate to your application.

## Status and attribution

Apollo is a reusable scaffold under active development. Check the plans for verified platforms and pending runtime checks; successful analysis or a build alone does not establish complete runtime coverage.

Created by **Konstantin Voronov**. Third-party dependencies retain their respective licenses; the vendored sheet package includes its [MIT license](packages/sheet/LICENSE).
