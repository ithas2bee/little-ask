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

### PostgreSQL

From the repository root, create a local environment file and start the database:

```sh
cp .env.example .env
docker compose up -d db
docker compose ps
```

Compose reports the service as healthy when PostgreSQL accepts connections.
The database is available from the host at `localhost` on `POSTGRES_PORT`
(`5432` by default), using `POSTGRES_DB`, `POSTGRES_USER`, and
`POSTGRES_PASSWORD` from `.env`. For example, with the supplied local values:

```text
postgresql://little_ask_dev:local-development-only@localhost:5432/little_ask_dev
```

The password in `.env.example` is only a local placeholder; do not use it or
other development credentials outside local development. `.env` is ignored by
Git. The backend does not yet connect to PostgreSQL; this service is for local
database development.

Stop the service while keeping its data:

```sh
docker compose down
```

To reset the database and delete all its data:

```sh
docker compose down --volumes
docker compose up -d db
```

The volume removal is destructive. Flutter continues to run through its normal
Flutter toolchain and is not part of Docker Compose.

### Backend API

From the repository root:

```sh
cd backend
npm install
npm run start:dev
```

The server listens on port `3000` by default. Set `PORT` to use another port;
it must be an integer from `1` to `65535`, or startup fails with a safe
configuration error.

Health checks are available at `GET /health/live` and `GET /health/ready`.
Readiness reports application status and currently has no external dependency
checks because the backend does not yet use external services.

## Project checks

Run these commands from `backend/`:

```sh
npm run lint
npm run typecheck
npm test
npm run build
```

For a production run, build first and then run `npm run start:prod`.
