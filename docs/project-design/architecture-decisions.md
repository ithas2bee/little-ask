# Architecture Decisions

This file records initial decisions and decisions that remain open.
Update it when a decision is made or superseded.

## ADR-001: Use Flutter and Dart for the mobile application

**Status:** Proposed

### Context

The product requires a polished mobile experience on both iOS and
Android. The team is intentionally open to learning a new ecosystem and
is not selecting technology solely to reuse prior experience.

### Decision

Use Flutter and Dart as the initial mobile technology direction.

### Rationale

-   One primary UI codebase for iOS and Android.
-   Strong control over consistent visual presentation.
-   Dart offers familiar object-oriented and asynchronous programming
    concepts while providing a distinct ecosystem to learn.

### Consequences

-   The team must learn Flutter's widget composition, state management,
    navigation, testing, and platform integration practices.
-   Native platform behavior and push notification setup still require
    iOS/Android configuration and testing.

## ADR-002: Use NestJS and TypeScript for the backend API

**Status:** Proposed

### Context

The backend needs clear modular boundaries, validation, testability, and
a mature ecosystem for HTTP APIs.

### Decision

Use NestJS with TypeScript for the initial backend.

### Rationale

NestJS provides modules, dependency injection, controllers, providers,
and testing conventions that support maintainable application structure.

### Consequences

-   The team must learn TypeScript and NestJS conventions.
-   Business rules should remain separate from controllers and
    framework-specific concerns.

## ADR-003: Use PostgreSQL

**Status:** Proposed

### Context

The product has relational data: accounts, family relationships,
requests, invitations, and statuses.

### Decision

Use PostgreSQL as the primary relational database.

### Rationale

It is a mature relational database with strong transactional and
integrity capabilities.

### Consequences

-   Define migrations, constraints, indexes, and backup practices.
-   Select and document the Node.js data-access/ORM approach before
    persistence implementation.

## ADR-004: Use Docker for local backend dependencies

**Status:** Accepted for development

### Context

A consistent local environment is useful for the API and database.

### Decision

Use Docker Compose to run backend services such as NestJS and PostgreSQL
during development.

### Rationale

It makes service setup repeatable and reduces differences between
developer environments.

### Consequences

-   Docker does not replace Flutter's normal mobile build/run toolchain.
-   Mobile-to-container networking must be configured for Android
    emulators, iOS simulators, and physical devices.

## ADR-005: Use feature-first organization with clean architectural boundaries

**Status:** Accepted

### Context

The project should remain understandable and maintainable over multiple
years without introducing unnecessary complexity.

### Decision

Organize code by business feature and separate presentation,
application, domain, and infrastructure/data responsibilities.

### Rationale

Feature-first organization keeps related code discoverable. Layer
boundaries keep business rules independent of UI and infrastructure.

### Consequences

-   Avoid giant shared folders and oversized classes.
-   Add abstractions when they protect a real boundary or enable
    meaningful testing.
-   Review file and method size as maintainability signals, not rigid
    numeric laws.

## ADR-006: Use Drizzle ORM and Drizzle Kit for PostgreSQL persistence

**Status:** Accepted

### Context

The NestJS backend needs typed PostgreSQL data access, repeatable migrations,
and a repository boundary without introducing persistence for all planned
product concepts at once.

### Decision

Use Drizzle ORM with the `pg` node-postgres driver for database access, and
Drizzle Kit to generate and apply SQL migrations. Keep repository interfaces
in the application layer and PostgreSQL implementations and schema definitions
in infrastructure.

### Rationale

-   Drizzle provides TypeScript-typed queries while keeping SQL concepts and
    generated migration SQL explicit and reviewable.
-   It is a smaller, SQL-oriented persistence layer than a full-featured ORM,
    which fits the backend's limited current persistence needs.
-   Drizzle Kit provides both migration generation from the schema and
    repeatable migration application without a separate migration framework.

### Consequences

-   The team adopts the Drizzle schema/query APIs and migration conventions.
-   Generated SQL migrations must be committed and reviewed with schema
    changes; migrations, rather than ORM synchronization, change databases.
-   The implementation remains PostgreSQL-specific through the `pg` driver.

## ADR-007: Use Flutter SDK primitives for initial UI state management

**Status:** Accepted

### Context

The Flutter app needs a consistent state-management approach without
introducing unnecessary architecture before MVP features exist. Riverpod
was identified as a candidate, alongside Flutter's built-in local state
and `ChangeNotifier`.

### Decision

Use `setState` for state private to one widget. Use Flutter's
`ChangeNotifier` with `ListenableBuilder` for feature UI state that needs
a separate controller or multiple listeners. Keep these controllers in
each feature's `presentation/` layer. Keep workflows in `application/`,
business rules in `domain/`, and data access in `data/`. Re-evaluate
Riverpod when a real feature requires shared asynchronous state or
injected dependencies across screens.

### Alternatives considered

-   **Flutter `setState`:** built in and appropriate for state used only
    by one widget, but unsuitable when feature state needs a separate
    controller or multiple listeners.
-   **Flutter `ChangeNotifier` and `ListenableBuilder`:** built in,
    testable, and sufficient for current feature UI state without an
    external package. Their mutable state and manual lifecycle
    management may need reconsideration as shared asynchronous state
    grows.
-   **Provider:** a familiar lightweight package based on
    `ChangeNotifier`, but adds a dependency without a current need for
    its provider wiring.
-   **Riverpod:** provides explicit dependencies, scoped test overrides,
    and support for asynchronous state, but adds a package and concepts
    not yet justified by any implemented feature.

### Rationale

-   Flutter SDK primitives are sufficient for the current scaffold and
    keep the dependency graph unchanged.
-   A separately testable `ChangeNotifier` keeps state updates out of
    widget rendering while retaining the simple Flutter lifecycle.
-   The choice is deliberately modest and can be revisited before
    adopting a package across real feature workflows.

### Dependencies

-   No additional packages. `ChangeNotifier` and `ListenableBuilder` are
    provided by Flutter; `flutter_test` is already an SDK dev dependency.

### Consequences

-   Feature UI state uses presentation-layer controllers and can be
    tested without rendering a full app.
-   Domain code remains independent of Flutter and state-management
    packages.
-   State is owned and disposed by the presentation widget that creates
    the controller; reassess this ownership if state becomes shared
    across screens.
-   The architecture-example counter is illustrative only; it is not a
    Little Ask workflow.

## Open decisions

-   Target child age range and legal/privacy implications.
-   Identity provider and child account authentication model.
-   Parent/guardian verification and family invitation flow.
-   Push notification provider.
-   Custom activity text in MVP.
-   Hosting and production operations.

## ADR-008: Use Flutter SDK named routes initially

**Status:** Accepted

### Context

The mobile app needs a consistent route convention, but currently has
only a scaffold screen and no finalized authentication or role-selection
flow.

### Decision

Use Flutter's built-in named routes, with route names and builders
centralized in `mobile/lib/app/app_routes.dart`. Keep the initial `/`
route mapped to the existing architecture-example counter as a clearly
identified development placeholder. Do not treat it as an authentication
or production home screen.

### Rationale

-   The current app needs only a shallow route table.
-   Flutter's built-in routing avoids adding a dependency or abstraction
    before nested navigation, deep links, or authentication guards are
    required.
-   Central route definitions keep screen widgets independent of global
    navigation configuration.

### Consequences

-   Replace the development placeholder when the authentication and
    role-aware entry flow is approved.
-   Re-evaluate the routing approach if nested navigation, deep links, or
    route guards become concrete requirements.
