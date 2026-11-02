# Little Ask: Agent Instructions

These instructions apply to every coding agent and automated contributor working in this repository.

## 1. Read before changing code

Before implementing any task, read the relevant material in:
- `docs/project-design/README.md`
- `docs/project-design/product-goals.md`
- `docs/project-design/mvp-scope.md`
- `docs/project-design/requirements.md`
- `docs/project-design/use-cases.md`
- `docs/project-design/design-structure.md`
- `docs/project-design/architecture.md`
- `docs/project-design/architecture-decisions.md`

Also read `docs/development/coding-standards.md` and any feature-specific documentation relevant to the task.

Do not assume that a user story contains all product or technical context. The project documentation is authoritative unless the product owner explicitly approves a change.

## 2. Product principles are non-negotiable

- Child-initiated requests are the primary product experience.
- Parent-initiated invitations are also a core capability. The product is two-way.
- The app exists to help children confidently ask for time with a parent, not to monitor or control children.
- Keep the MVP focused on creating, receiving, and responding to activity requests/invitations.
- Do not introduce chat, feeds, points, rewards, streaks, analytics dashboards, complex calendars, location tracking, or other out-of-scope features without explicit approval.
- Use warm, age-appropriate, non-shaming language. Do not frame a parent's unavailability as rejection of the child.
- Child privacy and safety are foundational requirements. Never weaken authorization or privacy to simplify implementation.

## 3. Architecture and code quality

- Follow the architecture documented in `docs/project-design/architecture.md`.
- Use feature-first organization with explicit presentation, application, domain, and data/infrastructure responsibilities.
- Keep domain rules independent of Flutter widgets, HTTP controllers, database libraries, and external providers.
- Keep widgets focused on rendering and user interaction.
- Keep controllers focused on HTTP concerns and request/response translation.
- Place workflows in focused application use cases/services.
- Keep persistence and external integrations behind appropriate interfaces/adapters.
- Prefer small, cohesive classes and methods with clear names.
- A file exceeding approximately 300 lines or a method becoming difficult to scan is a review signal. Split by responsibility when doing so improves cohesion. Do not split code mechanically just to meet a line count.
- Avoid giant files, god objects, unrelated utility collections, speculative abstractions, and premature generalization.
- Do not add packages without explaining why they are needed.
- Do not introduce a new architecture or state-management pattern without documenting the decision.

## 4. User story execution

For each assigned user story:

1. Read the parent Feature and EPIC and the story's acceptance criteria.
2. Use the separate **Assign to Agent** prompt provided by the product owner when the story is selected for implementation.
3. Read the relevant product and architecture documents.
4. Inspect the existing code and tests before making changes.
5. Identify the smallest coherent implementation that satisfies the story.
6. Do not silently expand scope or implement adjacent stories.
7. If requirements conflict, are incomplete, or create a security/privacy concern, stop and report the issue instead of inventing product behavior.
8. Implement the code and appropriate tests.
9. Run relevant formatting, static analysis, unit, integration, and/or build checks available for the changed area.
10. Review the diff for unrelated edits, generated noise, secrets, and accidental scope expansion.
11. Report exactly what changed, what commands were run, their outcomes, and any remaining limitations.

A story is not complete merely because code was written. Acceptance criteria must be addressed and verification evidence must be provided.

## 5. Security and child privacy

- Enforce authentication and authorization on the server.
- Never trust client-supplied identity, family role, sender, recipient, or relationship claims without validating them against authenticated server-side state.
- Verify that a user belongs to the family relationship associated with every request they read or modify.
- Do not expose child data to unapproved accounts.
- Do not log credentials, tokens, sensitive personal information, or unnecessary child request content.
- Never commit secrets, signing keys, production credentials, or personal data.
- Do not add advertising, tracking, analytics, or third-party data sharing without explicit product and privacy approval.
- Consider locked-screen push notification previews and minimize sensitive content in notifications.
- Flag child-safety, consent, age-policy, or legal/privacy questions for product-owner review. Do not claim legal compliance without qualified review.

## 6. API and data integrity

- Validate incoming API data at the boundary.
- Enforce valid request state transitions on the backend.
- Persist successfully before returning a success response.
- Design operations to handle retries and duplicate submissions safely where appropriate.
- Use migrations for schema changes.
- Store timestamps consistently and convert for display at the client boundary.
- Avoid breaking existing API contracts without an explicitly approved story and migration plan.

## 7. Flutter and Dart

- Follow the established Flutter project structure and selected state-management/routing conventions once finalized.
- Do not put networking, business rules, or persistence logic in widget build methods.
- Extract reusable widgets when they represent a clear UI responsibility.
- Handle loading, success, empty, offline, and error states.
- Support accessibility: semantic labels, readable text, sufficient contrast, and appropriately sized touch targets.
- Test meaningful behavior, not only widget construction.

## 8. NestJS and TypeScript

- Keep controllers thin.
- Validate DTOs at the API boundary.
- Keep business logic out of controllers and framework plumbing.
- Use dependency injection consistently.
- Keep domain code free of NestJS-specific dependencies where practical.
- Use typed errors and consistent API response semantics.
- Add authorization checks to every protected operation.

## 9. Git and change management

- Work only on the assigned story.
- Do not push directly to the default branch unless explicitly instructed.
- Use a focused branch and pull request for implementation work when the repository workflow requires it.
- Do not rewrite shared history or force-push unless explicitly authorized.
- Do not close a story or claim completion until verification is reported.
- Keep commits focused and descriptive.

## 10. Communication format

At completion, provide:

### Summary
What the implementation accomplishes.

### Files changed
List each changed file and its purpose.

### Acceptance criteria
Show how each criterion was satisfied.

### Verification
List exact commands and results. Clearly state anything not run.

### Decisions or risks
Identify assumptions, unresolved questions, security/privacy concerns, and follow-up work.

### Scope confirmation
State whether work stayed within the story. Identify any requested work intentionally left for another story.

## 11. Source of truth and change control

When this file conflicts with an explicit product-owner instruction, stop and ask for clarification if the instruction would materially change architecture, privacy, security, or MVP scope. Do not silently reinterpret requirements.

Update architecture decisions and project documentation when an approved implementation decision changes the documented design.
