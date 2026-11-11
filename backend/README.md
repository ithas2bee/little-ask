# Backend API

The API is a NestJS application with health endpoints, a request-validation
example endpoint, and a PostgreSQL persistence example.

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
Git. The backend connects to PostgreSQL through Drizzle ORM and the `pg`
driver. Its approach and tradeoffs are documented in
[ADR-006](../docs/project-design/architecture-decisions.md#adr-006-use-drizzle-orm-and-drizzle-kit-for-postgresql-persistence).

### Migrations and persistence

After starting the Compose database, open a shell in `backend/` and set
`DATABASE_URL` to the Compose database connection URL. With the local values
from `.env.example`, use the appropriate command below. Replace the values if
you changed `.env`; these example credentials are for local development only.

PowerShell:

```powershell
$env:DATABASE_URL = "******localhost:5432/little_ask_dev"
npm run db:generate -- --name=describe_change
npm run db:migrate
npm run test:integration
```

Bash:

```bash
export DATABASE_URL="******localhost:5432/little_ask_dev"
npm run db:generate -- --name=describe_change
npm run db:migrate
npm run test:integration
```

`db:generate` creates a checked-in SQL migration under `backend/drizzle/`;
`db:migrate` applies pending migrations and records them in PostgreSQL. To
recreate the schema from scratch, reset the local database volume as described
above, start the `db` service, and run `db:migrate`.

The `esbuild` override in `package.json` ensures that Drizzle Kit's transitive
`@esbuild-kit/core-utils` dependency uses a patched esbuild release. Without the
override, that dependency resolves to esbuild `0.24.2`, which is affected by
[GHSA-67mh-4wv8-2f99](https://github.com/advisories/GHSA-67mh-4wv8-2f99).

The persistence-example feature demonstrates the application-owned repository
port and its PostgreSQL adapter. It is an infrastructure proof only; it does
not add product workflows or future domain tables.

`npm run test:integration` requires `DATABASE_URL` and fails with a clear
message if it is missing. The regular `npm test` command may skip the
integration test when `DATABASE_URL` is not set.

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

### Request validation

The API configures a global NestJS `ValidationPipe` with transformation and
whitelisting enabled. DTO fields must declare validation decorators. Unknown
fields are rejected with a `400 Bad Request` rather than silently removed.
Invalid or missing DTO fields also receive a `400 Bad Request`.

All API errors use the same JSON shape:

```json
{
  "statusCode": 400,
  "code": "VALIDATION_ERROR",
  "message": "Request validation failed"
}
```

`code` and `message` identify the error category without exposing exception
details. Validation errors use `400` / `VALIDATION_ERROR`, missing resources
use `404` / `NOT_FOUND`, and conflicts use `409` / `CONFLICT`. Other HTTP errors
retain their HTTP status and use a generic response. Unexpected errors use
`500` / `INTERNAL_SERVER_ERROR`. Error responses do not include exception
messages, validation input, stack traces, or database details.

`POST /validation-example` is a focused boundary example, not a product
workflow. It accepts a required positive integer `quantity` (including a
numeric string, which is transformed to a number), rejects invalid or
unexpected fields, and passes the validated value to an application use case.

## Project checks

Run these commands from `backend/`:

```sh
npm run lint
npm run typecheck
npm test
npm run build
```

For a production run, build first and then run `npm run start:prod`.
