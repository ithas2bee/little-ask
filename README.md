# Little Ask

Little Ask is a private parent-child connection app that makes it easier for children to ask their parents for quality time. Parents can also initiate invitations, making the experience two-way while keeping child-initiated requests at the center.

## Start here

- [Project design documentation](docs/project-design/README.md)
- [Development workflow](docs/development/workflow.md)
- [Coding standards](docs/development/coding-standards.md)
- [Agent instructions](AGENTS.md)
- [GitHub Copilot instructions](.github/copilot-instructions.md)

## Planning hierarchy

All planned work follows:

```text
EPIC
  └── Feature
        └── User Story
              └── Assign to Agent prompt
```

Use the GitHub issue forms to create each level. See [Development Workflow](docs/development/workflow.md) for the process and definition of done.

## Initial technology direction

- Flutter and Dart for the cross-platform mobile application.
- NestJS and TypeScript for the backend API.
- PostgreSQL for persistence.
- Docker Compose for local backend and database services.

See the project design documentation for product goals, MVP boundaries, requirements, use cases, design direction, and architecture.
