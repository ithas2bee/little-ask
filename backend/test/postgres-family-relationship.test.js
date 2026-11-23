const assert = require('node:assert/strict');
const { randomUUID } = require('node:crypto');
const { test } = require('node:test');
const { drizzle } = require('drizzle-orm/node-postgres');
const { eq } = require('drizzle-orm');
const { Pool } = require('pg');
const {
  FamilyRelationship,
} = require('../dist/modules/family-relationships/domain/family-relationship.js');
const {
  PostgresFamilyRelationshipRepository,
} = require('../dist/modules/family-relationships/infrastructure/postgres-family-relationship.repository.js');
const schema = require('../dist/modules/family-relationships/infrastructure/schema.js');

const databaseUrl = process.env.DATABASE_URL;

test(
  'PostgreSQL repository stores an approved relationship idempotently',
  {
    skip: databaseUrl
      ? false
      : 'Set DATABASE_URL to run PostgreSQL integration tests.',
  },
  async () => {
    const pool = new Pool({ connectionString: databaseUrl });
    const database = drizzle(pool, { schema });
    const repository = new PostgresFamilyRelationshipRepository(database);
    const relationship = FamilyRelationship.approve({
      id: randomUUID(),
      parentAccountId: randomUUID(),
      childProfileId: randomUUID(),
    });
    let id;

    try {
      const saved = await repository.save(relationship);
      id = saved.id;

      assert.equal(saved.status, 'approved');
      assert.deepEqual(
        await repository.findByParticipants(
          relationship.parentAccountId,
          relationship.childProfileId,
        ),
        saved,
      );

      const duplicate = await repository.save(
        FamilyRelationship.approve({
          id: randomUUID(),
          parentAccountId: relationship.parentAccountId,
          childProfileId: relationship.childProfileId,
        }),
      );
      assert.deepEqual(duplicate, saved);
      assert.equal(
        await repository.findByParticipants(randomUUID(), randomUUID()),
        null,
      );
    } finally {
      try {
        if (id) {
          await database
            .delete(schema.familyRelationships)
            .where(eq(schema.familyRelationships.id, id));
        }
      } finally {
        await pool.end();
      }
    }
  },
);
