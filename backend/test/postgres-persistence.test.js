const assert = require('node:assert/strict');
const { randomUUID } = require('node:crypto');
const { test } = require('node:test');
const { drizzle } = require('drizzle-orm/node-postgres');
const { eq } = require('drizzle-orm');
const { Pool } = require('pg');
const {
  PostgresPersistenceExampleRepository,
} = require('../dist/modules/persistence-example/infrastructure/postgres-persistence-example.repository.js');
const schema = require('../dist/modules/persistence-example/infrastructure/schema.js');

const databaseUrl = process.env.DATABASE_URL;

test(
  'PostgreSQL repository saves and retrieves a persistence example',
  { skip: databaseUrl ? false : 'Set DATABASE_URL to run PostgreSQL integration tests.' },
  async () => {
    const pool = new Pool({ connectionString: databaseUrl });
    const database = drizzle(pool, { schema });
    const repository = new PostgresPersistenceExampleRepository(database);
    const value = `integration-${randomUUID()}`;
    let id;

    try {
      const saved = await repository.save(value);
      id = saved.id;

      assert.equal(typeof saved.id, 'string');
      assert.equal(saved.value, value);
      assert.deepEqual(await repository.findById(saved.id), saved);
      assert.equal(await repository.findById(randomUUID()), null);
    } finally {
      try {
        if (id) {
          await database
            .delete(schema.persistenceExamples)
            .where(eq(schema.persistenceExamples.id, id));
        }
      } finally {
        await pool.end();
      }
    }
  },
);
