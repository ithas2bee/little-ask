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

## Open decisions

-   Target child age range and legal/privacy implications.
-   Identity provider and child account authentication model.
-   Parent/guardian verification and family invitation flow.
-   State management and routing packages for Flutter.
-   ORM/data access approach for NestJS and PostgreSQL.
-   Push notification provider.
-   Custom activity text in MVP.
-   Hosting and production operations.
