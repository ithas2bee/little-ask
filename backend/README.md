# Backend API

The API is a minimal NestJS application. No feature modules or endpoints are
implemented yet.

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
