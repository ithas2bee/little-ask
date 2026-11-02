# Little Ask

**Working project name:** Little Ask (provisional; final product name
not yet selected)\
**Product type:** Parent-child connection mobile application\
**Status:** Product definition and MVP planning

## Purpose

Little Ask helps children confidently ask their parents to spend time
together. Parents can also invite their children to do something
together, making the experience two-way while keeping child-initiated
requests at the center.

The product is about making it easier to express a desire for
connection. It is not a chore tracker, parental-control product, family
calendar, reward system, or social network.

## Documentation map

  -----------------------------------------------------------------------
  File                                Purpose
  ----------------------------------- -----------------------------------
  `product-goals.md`                  Product vision, goals, principles,
                                      and success signals

  `end-users.md`                      Primary and secondary users, roles,
                                      and user needs

  `use-cases.md`                      Core user journeys and interaction
                                      scenarios

  `requirements.md`                   Functional, non-functional,
                                      privacy, and safety requirements

  `mvp-scope.md`                      Explicit MVP inclusions,
                                      exclusions, and release boundaries

  `design-structure.md`               UX principles, screen structure,
                                      and interaction guidance

  `architecture.md`                   Proposed technology stack, system
                                      boundaries, and code organization

  `architecture-decisions.md`         Initial architecture decisions and
                                      rationale
  -----------------------------------------------------------------------

## Product in one paragraph

A child opens the app, chooses a parent, selects an activity or writes a
simple request, and sends it. The parent receives the request and can
accept it or respond that they cannot right now and suggest another
time. A parent can also send an activity invitation to a child, who can
accept or say maybe later. The child experience receives the greatest
design emphasis because empowering children to initiate connection is
the central purpose.

## Initial technology direction

-   **Mobile:** Flutter with Dart
-   **Backend API:** NestJS with TypeScript
-   **Database:** PostgreSQL
-   **Local development and service orchestration:** Docker / Docker
    Compose
-   **Notifications:** Push notification provider to be selected during
    technical discovery
-   **Source control and delivery:** Git-based workflow and automated
    checks

These are initial decisions, not a reason to introduce unnecessary
infrastructure. The MVP should remain small and maintainable.

## Current product guardrails

1.  Child-initiated requests are the primary experience.
2.  Parent-initiated invitations are supported; the product is genuinely
    two-way.
3.  A declined or delayed request must not be framed to a child as
    personal rejection.
4.  No points, streaks, leaderboards, feeds, or engagement metrics in
    the MVP.
5.  No unnecessary features that distract from creating and responding
    to a request.
6.  Keep code modular, readable, testable, and understandable years
    later.
7.  Treat child privacy and account relationships as foundational
    requirements, not later enhancements.

## Naming note

"Little Ask" is used as a working project name because it describes the
core interaction. It has not been approved as the final public brand and
must undergo name, domain, app-store, and trademark checks before
launch.
