# GitHub Development Workflow

## Purpose

Little Ask work is organized as a real parent-child issue hierarchy:

```text
EPIC
  └── Feature
        └── User Story
```

Use GitHub's native **sub-issues** relationships to establish the hierarchy. Labels identify the issue type (`epic`, `feature`, or `user story`), but labels alone do not establish parentage. Each Feature must be a sub-issue of exactly one EPIC, and each User Story must be a sub-issue of exactly one Feature.

## 1. EPIC

An EPIC represents the grand idea or major development theme, such as Backend Development, Mobile Application, or Identity and Family Setup.

An EPIC defines:
- The overall objective and why the theme exists.
- Major scope boundaries.
- Dependencies and risks.
- High-level completion criteria.
- The Features that live inside it.

An EPIC is not a collection of implementation tasks. Its Features are children of the EPIC.

## 2. Feature

A Feature is a distinct capability that belongs inside an EPIC.

A Feature defines:
- The capability it delivers.
- Expected product/system behavior.
- Scope and boundaries.
- Dependencies and requirements.
- Completion criteria.
- The User Stories that implement it.

Features must be created as native sub-issues of their parent EPIC. Do not create Features as independent siblings of User Stories.

## 3. User Story

A User Story is a small, focused unit of work that belongs inside one Feature.

Use the format:

> As a [user or system role], I want [capability], so that [value].

Each User Story includes:
- Its parent Feature (established through the native sub-issue relationship).
- Background and context.
- Scope and explicit out-of-scope boundaries.
- Testable acceptance criteria.
- Technical guidance and architectural constraints.
- Testing and verification expectations.
- Relevant documentation and dependencies.

User Stories are planning artifacts. **Do not include an Assign to Agent prompt when creating a User Story.**

Keep stories small enough to implement, review, and test independently. Avoid combining unrelated changes into one story.

## 4. Assign to Agent (implementation stage only)

The Assign to Agent prompt is created separately, only after the product owner selects a specific User Story for implementation.

At that point, the prompt should provide the coding agent with:
- Repository-wide instructions and relevant project documents to read.
- The exact User Story and acceptance criteria.
- Files/modules or architecture boundaries relevant to the work.
- Implementation constraints and explicit exclusions.
- Required tests and verification commands.
- Required completion report format.

The prompt must not silently expand the User Story. If requirements are ambiguous or conflict with product/architecture documentation, the agent must ask for clarification.

## 5. Labels

Use the repository's issue-type labels:
- `epic`
- `feature`
- `user story`

Use area labels such as backend, mobile, architecture, security, privacy, and documentation when they add useful filtering. A label is classification, not hierarchy.

## 6. Work planning and execution lifecycle

1. Product owner defines an EPIC.
2. Features are created as native sub-issues inside that EPIC.
3. User Stories are created as native sub-issues inside their Feature.
4. Product owner reviews the planned hierarchy, scope, and acceptance criteria.
5. When a particular story is ready for implementation, the product owner writes its Assign to Agent prompt and assigns the work.
6. Agent implements only that story and reports files changed, acceptance criteria coverage, verification results, assumptions, and remaining work.
7. Product owner reviews the changes, pulls them locally, and tests on target environments/devices.
8. Feedback is recorded; the story is closed only after acceptance.

## 7. Definition of Done for a User Story

- All acceptance criteria are implemented.
- Changes stay within the story's scope.
- Relevant tests are added or updated and pass.
- Formatting, static analysis, and build checks relevant to the change pass.
- Security and authorization implications are addressed.
- No secrets or unrelated generated files are included.
- Agent completion report identifies exact verification results.
- Product owner has reviewed the changes and completed required local testing.

## 8. Product-owner control

Agents implement approved stories. They do not independently redefine the product, expand the MVP, change architecture, or weaken privacy/security requirements. Significant changes require explicit product-owner approval and corresponding documentation updates.
