# GitHub Development Workflow

## Purpose

Little Ask work is planned and delivered through a consistent hierarchy:

```text
EPIC
  └── Feature
        └── User Story
              └── Assign to Agent prompt
```

GitHub Issues do not provide native nested issue objects in every configuration. We represent hierarchy through explicit parent issue references in each Feature and User Story, and reciprocal links/checklists in the parent descriptions. Use GitHub Projects or issue relationships as an optional visualization layer, not as the only record of parentage.

## 1. EPIC

An EPIC represents a major development theme or strategic area, for example:
- Backend Foundation
- Mobile Application Foundation
- Identity and Family Setup
- Notifications and Delivery

An EPIC explains the objective, boundaries, dependencies, and completion criteria. It lists the Features that deliver the theme.

An EPIC should not be a catch-all task list and should not contain implementation-level acceptance criteria for every story.

## 2. Feature

A Feature represents a cohesive capability within one EPIC.

Examples under Backend Foundation:
- Domain Foundation
- Data Persistence
- API Foundation

A Feature describes expected behavior/capability and lists the User Stories needed to deliver it. Each Feature must identify its parent EPIC.

## 3. User Story

A User Story is the smallest planned unit of agent implementation that delivers a coherent, testable outcome.

Use the format:

> As a [user or system role], I want [capability], so that [value].

Each story must include:
- Parent Feature and parent EPIC references.
- Background/context.
- In-scope and out-of-scope boundaries.
- Testable acceptance criteria.
- Technical guidance and architectural constraints.
- Verification expectations.
- Relevant documentation and dependencies.
- A complete **Assign to Agent** prompt.

Avoid combining unrelated changes into one story. Create separate stories when work can be implemented, reviewed, or tested independently.

## 4. Assign to Agent prompt

The prompt is the execution contract for the coding agent. It must tell the agent to:
- Read repository-wide instructions and relevant design documentation.
- Inspect existing implementation before editing.
- Implement only the story's scope.
- Follow documented architecture and coding standards.
- Preserve privacy, security, and child-safety boundaries.
- Add or update tests.
- Run relevant verification.
- Report files changed, acceptance-criteria coverage, commands/results, assumptions, and remaining work.

The prompt should not contradict the story or project documentation. If requirements are unclear or conflicting, the agent must ask for clarification rather than invent product behavior.

## 5. Suggested labels

Create and use these labels:
- `epic`
- `feature`
- `user-story`
- `backend`
- `mobile`
- `architecture`
- `security`
- `privacy`
- `documentation`
- `bug`
- `blocked`

Hierarchy labels identify the issue type. Area labels identify affected concerns. Use both where appropriate.

## 6. Work execution lifecycle

1. Product owner defines or approves an EPIC.
2. Product owner defines Features under that EPIC.
3. Each Feature is decomposed into small User Stories.
4. Product owner reviews the story and its Assign to Agent prompt.
5. Agent implements the assigned story and provides a completion report.
6. Product owner reviews the diff and test evidence.
7. Changes are pulled and tested locally on target environments/devices as appropriate.
8. Feedback is recorded, and the story is closed only after acceptance.

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
