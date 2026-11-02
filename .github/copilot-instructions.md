# GitHub Copilot Instructions: Little Ask

Copilot and coding agents must follow the repository-wide rules in `AGENTS.md`.

Before proposing or implementing changes, consult the relevant documentation under `docs/project-design/` and `docs/development/`.

## Product context
Little Ask is a private parent-child connection app. Children are empowered to initiate requests for quality time with a parent. Parents can also initiate invitations to children. Child-initiated requests are the primary experience, but both directions are core product behavior.

The MVP focuses on:
- Child creates and sends an activity request to an approved parent.
- Parent receives and accepts, or responds that now is not a good time and suggests later.
- Parent sends an activity invitation to an approved child.
- Child accepts or responds “Maybe later.”
- Both parties can see the current status.

Do not add chat, social feeds, gamification, points, streaks, rewards, family analytics, complex calendar features, location tracking, or other out-of-scope capabilities unless explicitly requested.

## Architecture
- Follow `docs/project-design/architecture.md`.
- Use feature-first organization and keep presentation, application, domain, and data/infrastructure responsibilities separate.
- Keep Flutter widgets focused on UI.
- Keep NestJS controllers thin.
- Put business workflows in application use cases/services.
- Keep domain rules independent of UI, HTTP, persistence, and provider frameworks.
- Prefer cohesive classes and small, readable methods.
- Treat files around 300 lines and very long methods as prompts to review responsibility boundaries, not as arbitrary hard limits.
- Avoid speculative abstractions and unnecessary dependencies.

## Safety and privacy
- Enforce identity and family relationship authorization on the backend.
- Never trust client-supplied sender/recipient identity or role without server-side validation.
- Protect child data and keep requests private to approved family members.
- Do not add tracking, advertising, or unnecessary collection of personal information.
- Use kind, age-appropriate language. Never label a child's request as “rejected.”

## Implementation expectations
- Inspect existing code before editing.
- Implement only the assigned story.
- Add or update tests for behavior and business rules.
- Run relevant formatters, analyzers, tests, and builds.
- Report exact verification commands and results.
- Do not claim completion for checks that were not run.
- Do not commit secrets or unrelated changes.

When requirements are ambiguous or conflict with product documentation, ask for clarification instead of inventing behavior.
