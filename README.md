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
