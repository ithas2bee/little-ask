# Development Coding Standards

These standards apply across the Flutter/Dart mobile client and NestJS/TypeScript backend.

## General principles

- Optimize for readability and maintainability, including the developer who returns to the code years later.
- Use descriptive names. Avoid unexplained abbreviations.
- Keep each class, method, and file focused on a cohesive responsibility.
- Favor composition and explicit dependencies over hidden global state.
- Keep business rules separate from frameworks and delivery mechanisms.
- Avoid premature abstractions, speculative extensibility, and unnecessary dependencies.
- Handle errors intentionally. Do not swallow exceptions or return success after a failed operation.
- Add comments to explain important reasoning or non-obvious constraints, not to narrate obvious code.

## File and method size

There is no hard language-level line limit. As a team convention, files approaching or exceeding 300 lines should receive a maintainability review. Long methods should be decomposed when they mix responsibilities, contain deeply nested logic, or are difficult to test.

Do not create dozens of tiny files with no meaningful separation. Extract code when the new unit has a clear name, purpose, and boundary.

## Flutter / Dart

- Use the agreed feature-first folder structure.
- Keep widgets declarative and focused on presentation.
- Avoid business logic, API calls, and persistence in widget build methods.
- Use immutable data models where practical.
- Keep asynchronous loading and error states explicit.
- Use the project's formatter and analyzer.
- Write unit tests for domain/application behavior and widget tests for meaningful UI interactions.
- Provide accessible semantics and touch targets appropriate for children.

## NestJS / TypeScript

- Keep controllers limited to transport concerns.
- Validate external input at API boundaries.
- Keep application use cases focused on one workflow.
- Keep domain rules out of controllers and ORM entities.
- Use dependency injection and typed interfaces at meaningful boundaries.
- Enforce authorization at the backend for every protected resource.
- Use database migrations for schema changes.
- Test domain rules, application workflows, repository integration, and API authorization.

## API and data

- Use consistent naming and response conventions.
- Do not expose internal database models directly as public API contracts.
- Validate state transitions server-side.
- Use transactions where a workflow needs atomic changes.
- Store timestamps consistently in UTC; localize only for display.
- Avoid unnecessary personal data collection and sensitive logging.

## Testing and verification

- Every story should identify relevant tests.
- Tests should assert externally meaningful behavior and business rules.
- Run the narrowest relevant tests during development, then broader checks for the affected project.
- Run formatting, static analysis, and build checks before reporting completion.
- State clearly when a check cannot be run and why.

## Pull requests

- Keep each PR focused on its story.
- Explain the problem, implementation, and testing.
- Identify API/schema changes and migration implications.
- Call out any assumptions or deviations from the story.
- Do not include unrelated formatting or generated changes.
