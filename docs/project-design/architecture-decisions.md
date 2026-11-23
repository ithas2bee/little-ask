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

-   Target child age range, launch jurisdictions, and legal/privacy
    implications; see ADR-009.
-   Adult and child sign-in, session, verification, family-linking,
    consent, device access, recovery, and retention decisions; see
    ADR-009.
-   Push notification provider.
-   Custom activity text in MVP.
-   Hosting and production operations.

## ADR-008: Use `go_router` for mobile navigation

**Status:** Accepted

### Context

The mobile app needs centralized route definitions that can grow with
parent and child experiences. The current scaffold has only one screen,
and authentication and role-selection flows are not finalized.

### Decision

Use `go_router` for navigation, with route paths and configuration
centralized in `mobile/lib/app/app_router.dart`; screens must not own
global routing configuration. Configure `LittleAskApp` with
`MaterialApp.router`. Keep `/` mapped to the existing architecture-example
counter as a clearly identified development placeholder, not an
authentication or production home screen.

### Rationale

-   `go_router` provides declarative route configuration and supports
    future nested routes and deep links as parent and child experiences
    are added.
-   The centralized configuration keeps route paths out of screen
    widgets and makes navigation behavior directly testable.

### Consequences

-   `go_router` is a direct mobile dependency.
-   Add parent and child routes to the centralized router when their
    screens are implemented; do not introduce placeholder product
    screens or role redirects before those flows are approved.
-   Revisit route guards when the authentication flow is defined.
-   Keep the development placeholder only until the approved app entry
    flow replaces it.

## ADR-009: Separate parent accounts from child profiles

**Status:** Proposed; product-owner and qualified legal/privacy review required

### Context

Little Ask needs to identify the participants in a private family
relationship, authorize both child-initiated requests and parent-initiated
invitations, and support parent-mediated setup. The product requirements
make authentication, approved relationships, data minimization, and
server-side authorization release requirements. They do not set a target
age range, require children to have independent credentials, or select a
verification process or identity provider.

This decision is consistent with [End Users](end-users.md),
[Product and System Requirements](requirements.md),
[MVP Scope](mvp-scope.md), [Use Cases](use-cases.md), and
[Architecture](architecture.md). It documents a proposed direction, not
an approved provider, legal interpretation, or final account policy.

### Proposed recommendation

- **Parent/guardian identity:** Each parent or guardian uses an adult
  account with an independently authenticated identity. The account is
  the adult's sign-in and session boundary. It can administer family
  setup while authorized, but this application-level role does not
  establish legal ownership of a child or prove guardianship.
- **Child identity:** Represent a child initially as a child-facing
  profile associated with one or more explicitly approved family
  relationships, rather than assuming a standalone adult-style account.
  Keep only the identifiers and profile information needed for those
  relationships and request flows. Do not require a child's own email
  address or phone number. This recommendation does not decide the
  intended age range or rule out a separately approved child sign-in
  model later.
- **Parent sign-in and sessions:** Keep the authentication provider and
  credential method open. The backend must establish the authenticated
  adult principal, issue and revoke its sessions, and authorize protected
  operations from server-side identity and relationship state. Never
  accept a client-supplied role, sender, recipient, or relationship as
  proof of authority. Session lifetime, re-authentication, and any
  stronger authentication requirements remain to be decided.
- **Child device access:** Prefer a child-specific, revocable app access
  session scoped to the selected child profile and approved
  relationships. Parent-authenticated setup may provision or restore
  that access, but a child-facing session must not expose the parent's
  authenticated session or adult account administration. Do not make a
  child's personal email or phone a prerequisite. The backend must
  validate the child's current relationship authorization for protected
  requests. Device registration, multiple-device use, shared-device
  switching, and offline behavior are not specified here.
- **Verification and family linking:** Do not provide public discovery
  of children or arbitrary adults. Family setup and linking should be
  explicitly initiated and approved, with relationship state maintained
  by the backend. A parent-created invitation or code may demonstrate
  control of that invitation, but by itself does not prove adult status,
  legal guardianship, or valid consent. The product and qualified
  reviewers must select and approve what verification and consent are
  appropriate before implementation or release.
- **Consent, privacy, and recovery:** Collect the minimum data needed;
  keep child information and requests private to authorized family
  members; minimize sensitive lock-screen notification content; and
  define deletion, retention, and recovery processes before public
  release. Parent account recovery must not silently restore access to
  child profiles or relationships without appropriate re-verification.
  Provide a way to revoke lost or compromised sessions and child-device
  access. Age-appropriate notice or child assent may be appropriate, but
  its form and any required parental consent must be determined through
  qualified review for the chosen audience and jurisdictions.

### Alternatives considered

- **Give every child independent email/phone-based credentials:** Could
  provide direct child sign-in, but assumes contact details and creates
  additional collection, age-policy, consent, and recovery questions.
  Not selected as the default recommendation; revisit only with explicit
  product and privacy approval.
- **Have children use a parent's credentials or session:** Reduces
  setup steps but conflates adult and child authority, exposes adult
  account access, and makes revocation and attribution harder. Not
  recommended.
- **Allow child access without a distinct server-validated identity or
  relationship scope:** Could simplify the client, but cannot reliably
  enforce the privacy and authorization requirements. Not recommended.
- **Select an identity provider or verification vendor now:** Would
  prematurely decide provider, jurisdiction, and data-processing
  questions that are outside this story. Deferred.

### Rationale and tradeoffs

Separating the adult sign-in identity from child-facing profiles aligns
with the documented parent-mediated setup while avoiding an unsupported
assumption that children have personal contact details. A distinct
child-scoped access context supports the child's primary request flow
without treating a parent session as child authentication. This approach
still requires a safe, usable way to provision, recover, and revoke child
device access, and the proposed profile model may need revision after
the target audience and applicable obligations are established.

### Consequences

- Backend authorization must distinguish authenticated adult accounts,
  child profiles, and approved family relationships; client role labels
  are presentation data, not authority.
- Linking, consent, session, and recovery workflows need approved rules
  before their implementation. No authentication package, provider,
  database schema, or credential flow is selected by this ADR.
- Product and qualified legal/privacy review are release dependencies.
  This ADR does not claim compliance with COPPA or any other law.

### Open decisions requiring approval

1. What target ages, launch jurisdictions, and age-assurance approach
   are appropriate? What laws, app-store rules, and qualified review
   apply?
2. What adult identity, guardian verification, family-linking, and
   consent process is sufficient? How are multiple guardians added and
   removed, and what evidence—if any—establishes authority?
3. Which provider, sign-in factors, session lifetime, re-authentication,
   and account-recovery process should be used?
4. How is child device access provisioned, restored, and revoked? Must
   the MVP support shared devices, multiple child devices, or multiple
   child profiles on one device?
5. Under what audience or circumstances, if any, should a child have
   independent credentials?
6. What child and family data is retained, for how long, and how are
   account deletion, relationship removal, support, and recovery handled?
