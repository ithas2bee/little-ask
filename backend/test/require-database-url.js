if (!process.env.DATABASE_URL?.trim()) {
  console.error(
    'DATABASE_URL is required for npm run test:integration. Set it to the PostgreSQL connection URL and retry.',
  );
  process.exit(1);
}
