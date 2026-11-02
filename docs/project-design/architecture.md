# Architecture

## 1. Architecture goals

The architecture should be understandable, testable, and maintainable
years after the initial release. Keep files and classes focused. Avoid
giant screens, oversized services, and methods that coordinate unrelated
responsibilities.

Use clear boundaries between: - Presentation and UI state. - Application
workflows and use cases. - Domain rules and entities. - Data access and
external services.

Do not introduce abstractions without a reason, but preserve boundaries
that protect business rules from UI and infrastructure details.

## 2. Proposed technology stack

### Mobile application

-   **Flutter** for cross-platform iOS and Android UI.
-   **Dart** as the application language.
-   State management solution to be selected and documented before
    implementation (evaluate Riverpod as the initial candidate).
-   Routing solution to be selected consistently.
-   API client and serialization approach to be standardized.

### Backend

-   **NestJS** with **TypeScript**.
-   REST API for the initial MVP.
-   Request validation at the API boundary.
-   Application services/use cases for workflows.
-   PostgreSQL persistence.

### Development environment

-   Docker and Docker Compose for local backend and database services.
-   Flutter tooling runs on the developer workstation or CI environment;
    the mobile app itself is not normally run as a Docker container.
-   Environment-specific configuration and secrets must not be committed
    to source control.

### Notifications

Select a push provider after reviewing iOS and Android requirements,
token lifecycle, privacy, and delivery behavior. Notification delivery
is an external integration and must not be the only way a user can
discover a pending request.

## 3. System context

``` text
Flutter Mobile App (Child / Parent experiences)
                 |
                 | HTTPS / JSON
                 v
          NestJS REST API
                 |
        Application Use Cases
                 |
             Domain
                 |
        Repository Interfaces
                 |
       Infrastructure Adapters
          /             \
         v               v
   PostgreSQL       Push Provider
```

The mobile app communicates with the backend. The backend is
authoritative for identity, family relationships, authorization, request
state, and persistence.

## 4. Backend architecture

Use a feature-first modular structure, with clear internal layers.

The root `app.module.ts` composes implemented feature modules. Add each
feature only when its capability is implemented; do not create placeholder
modules or empty layer folders. The following example illustrates the
shape of one feature and does not describe files that currently exist:

``` text
backend/
  src/
    main.ts
    app.module.ts
    modules/
      activity-requests/
        activity-requests.module.ts
        presentation/
          activity-requests.controller.ts
          create-activity-request.dto.ts
        application/
          create-activity-request.use-case.ts
          ports/
            activity-request.repository.ts
        domain/
          activity-request.ts
        infrastructure/
```

This illustrative flow keeps the controller at the HTTP boundary: it
accepts a validated DTO and delegates to the use case. The use case
coordinates domain behavior through an application-owned repository port;
an infrastructure adapter can implement that port. The feature module
wires the controller, use case, and adapter using NestJS dependency
injection. This example does not require implementing the request workflow
or adding persistence.

### Layer responsibilities

-   **Presentation:** Controllers, request/response DTOs, validation,
    and HTTP concerns. Translate transport data and delegate; do not
    contain business workflows.
-   **Application:** Focused use cases, orchestration, transaction
    boundaries, and ports/interfaces required by workflows.
-   **Domain:** Entities, value objects, invariants, and business rules.
    Avoid framework dependencies here.
-   **Infrastructure:** PostgreSQL repositories, ORM mappings, push
    provider adapters, and external integrations.

Dependencies point inward toward the domain: presentation may depend on
application, application may depend on domain and its own ports, and
infrastructure implements application ports using domain concepts. The
feature module is the composition point that wires these components;
domain code does not depend on NestJS, HTTP, persistence, or provider
frameworks. Avoid importing another feature's internal layers; introduce
a shared boundary only when a real cross-feature need exists.

Use kebab-case feature directories and filenames, PascalCase TypeScript
types, and descriptive role suffixes such as `.module.ts`,
`.controller.ts`, `.dto.ts`, and `.use-case.ts`. Name use cases after
their action and domain types after the business concept.

NestJS modules organize the application, but should not become a reason
to put all business logic in controllers or providers with unrelated
responsibilities.

## 5. Flutter architecture

Use feature-first organization with presentation, application/domain,
and data boundaries. Keep widgets focused on rendering and user
interaction.

Suggested starting structure:

``` text
mobile/
  lib/
    app/
      app.dart
      routing/
      theme/
    core/
      errors/
      networking/
      shared/
    features/
      family/
        presentation/
        application/
        domain/
        data/
      activity_requests/
        presentation/
        application/
        domain/
        data/
      invitations/
        presentation/
        application/
        domain/
        data/
```

The exact boundaries can be refined as features are implemented. Avoid
premature abstractions and avoid putting the entire app into a generic
`services` folder.

### Layer responsibilities

-   **Presentation:** Screens, reusable widgets, and UI
    state/controllers.
-   **Application:** Feature workflows and coordination of
    domain/repository operations.
-   **Domain:** Core concepts and rules that should not depend on
    Flutter or networking.
-   **Data:** API data sources, DTOs, mapping, and repository
    implementations.

## 6. Initial domain concepts

Start by defining and discussing these concepts before creating database
tables:

### FamilyMember

Represents a person participating in a family relationship. Determine
whether this is a domain concept, a profile, or an identity reference
based on the final account model.

Potential attributes include an identifier, display name, and role. Do
not put authentication secrets in this entity.

### FamilyRelationship

Represents an approved association between a parent/guardian and a
child. It is central to authorization.

### ActivityRequest

Represents a child-initiated request for an activity with a parent.

### ActivityInvitation

Represents a parent-initiated invitation for a child to participate in
an activity.

Consider whether `ActivityRequest` and `ActivityInvitation` should share
a common `ConnectionRequest` model with an explicit initiator and
recipient. Choose the simplest model that preserves clear state
transitions and role-specific behavior. Do not duplicate models merely
to make the names feel symmetrical.

### Activity

Represents an activity choice from the curated catalog. It may be a
reference to catalog data rather than a rich entity in the first
release.

## 7. API boundary

Use versioned REST endpoints. Candidate endpoint shapes for discussion:

``` text
POST   /api/v1/activity-requests
GET    /api/v1/activity-requests/inbox
GET    /api/v1/activity-requests/{requestId}
POST   /api/v1/activity-requests/{requestId}/accept
POST   /api/v1/activity-requests/{requestId}/suggest-later

POST   /api/v1/activity-invitations
GET    /api/v1/activity-invitations/inbox
POST   /api/v1/activity-invitations/{invitationId}/respond
```

These are illustrative contracts, not finalized API specifications.
Authorization must verify the authenticated user's relationship to the
request. Never trust a client-supplied sender identity or role.

## 8. Data and persistence

PostgreSQL is the initial relational database. Use migrations and
explicit constraints. Store timestamps in a consistent UTC
representation and convert for display using the user's locale/time
zone.

Persist: - User/account identity references. - Family relationships and
their verification/approval state. - Activity catalog entries, if
catalog data is stored server-side. - Requests/invitations,
participants, status, and relevant timestamps. - Suggested time details
when applicable. - Notification delivery metadata only as needed.

Define deletion, retention, and audit requirements before public
release, especially for child-associated data.

## 9. Testing strategy

-   Domain unit tests for request state transitions and authorization
    rules.
-   Application tests for each use case.
-   Repository/integration tests against PostgreSQL.
-   API tests for validation, authentication, and authorization.
-   Flutter widget tests for child and parent flows.
-   End-to-end tests for the complete two-way request workflow.
-   Manual testing on physical iOS and Android devices.

## 10. Code quality rules

-   Keep methods focused on one responsibility.
-   Avoid large widget build methods; extract meaningful widgets.
-   Avoid files that become difficult to navigate. A 300-line file is a
    review signal, not an arbitrary language limit.
-   Prefer explicit names over clever abbreviations.
-   Keep business rules out of UI widgets and HTTP controllers.
-   Do not create generic abstractions until there is a concrete need.
-   Add tests around business behavior, not just implementation details.
-   Document meaningful architectural decisions.

## 11. Deployment direction

For local development, Docker Compose should run the API and PostgreSQL,
with configuration supplied through environment variables. Flutter
builds and runs through Flutter's toolchain and connects to the local
API using platform-appropriate networking configuration.

Production hosting, secrets management, backups, monitoring, push
credentials, and app-store release processes will be designed separately
before launch.
