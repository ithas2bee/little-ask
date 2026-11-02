# Little Ask: Project Design

This folder contains the product and architecture documentation that defines what Little Ask is and how it should be built.

## Documentation map

| File | Purpose |
|---|---|
| [product-goals.md](product-goals.md) | Product vision, goals, principles, and success signals |
| [end-users.md](end-users.md) | Primary and secondary users, roles, and user needs |
| [use-cases.md](use-cases.md) | Core user journeys and interaction scenarios |
| [requirements.md](requirements.md) | Functional, non-functional, privacy, and safety requirements |
| [mvp-scope.md](mvp-scope.md) | MVP inclusions, exclusions, and release boundaries |
| [design-structure.md](design-structure.md) | UX principles, screen structure, and interaction guidance |
| [architecture.md](architecture.md) | Proposed technology stack, system boundaries, and code organization |
| [architecture-decisions.md](architecture-decisions.md) | Initial architecture decisions and rationale |

## Related development guidance

- [Repository-wide agent instructions](../../AGENTS.md)
- [GitHub Copilot instructions](../../.github/copilot-instructions.md)
- [Coding standards](../development/coding-standards.md)
- [EPIC → Feature → User Story workflow](../development/workflow.md)
- [Issue templates](../../.github/ISSUE_TEMPLATE/)

## Product summary

Little Ask helps children confidently ask their parents to spend time together. Parents can also invite their children to do something together, making the experience two-way while keeping child-initiated requests at the center.

The app is not a chore tracker, parental-control product, family calendar, reward system, or social network. Its MVP focuses on creating, receiving, and responding to activity requests and invitations.

## Initial technology direction

- **Mobile:** Flutter with Dart
- **Backend API:** NestJS with TypeScript
- **Database:** PostgreSQL
- **Local development:** Docker / Docker Compose
- **Notifications:** Provider to be selected during technical discovery

These are initial architecture decisions and must remain consistent with [architecture-decisions.md](architecture-decisions.md).

## Product guardrails

1. Child-initiated requests are the primary experience.
2. Parent-initiated invitations are supported; the product is genuinely two-way.
3. A delayed or unavailable response must not be framed to a child as personal rejection.
4. No points, streaks, leaderboards, feeds, or engagement metrics in the MVP.
5. Keep code modular, readable, testable, and understandable years later.
6. Treat child privacy and family authorization as foundational requirements.

## Naming

“Little Ask” is the working project name. It is not yet confirmed as the final public brand and must undergo name, domain, app-store, and trademark checks before launch.
