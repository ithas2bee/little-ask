# Backend API

The API is a minimal NestJS application. No feature modules or endpoints are
implemented yet.

## Backend organization

Organize implemented capabilities under `src/modules/<feature>/`, with
presentation, application, domain, and infrastructure responsibilities
kept separate. Controllers handle HTTP translation and delegate workflows
to application use cases; domain rules remain independent of NestJS.
Dependency direction, naming, and an illustrative feature layout are
documented in the [backend architecture](../docs/project-design/architecture.md#4-backend-architecture).
The example there is documentation only; do not create placeholder
features or layer folders before implementing a capability.

## Local development

From the repository root:

```sh
cd backend
npm install
npm run start:dev
```

The server listens on port `3000` by default. Set `PORT` to use another port.

## Project checks

Run these commands from `backend/`:

```sh
npm run lint
npm run typecheck
npm test
npm run build
```

For a production run, build first and then run `npm run start:prod`.
