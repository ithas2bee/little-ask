import { eq } from 'drizzle-orm';
import type { NodePgDatabase } from 'drizzle-orm/node-postgres';
import type { PersistenceExample } from '../domain/persistence-example';
import type { PersistenceExampleRepository } from '../application/ports/persistence-example.repository';
import * as schema from './schema';

export class PostgresPersistenceExampleRepository
  implements PersistenceExampleRepository
{
  constructor(private readonly database: NodePgDatabase<typeof schema>) {}

  async save(value: string): Promise<PersistenceExample> {
    const [example] = await this.database
      .insert(schema.persistenceExamples)
      .values({ value })
      .returning({
        id: schema.persistenceExamples.id,
        value: schema.persistenceExamples.value,
      });

    return example;
  }

  async findById(id: string): Promise<PersistenceExample | null> {
    const [example] = await this.database
      .select({
        id: schema.persistenceExamples.id,
        value: schema.persistenceExamples.value,
      })
      .from(schema.persistenceExamples)
      .where(eq(schema.persistenceExamples.id, id))
      .limit(1);

    return example ?? null;
  }
}
