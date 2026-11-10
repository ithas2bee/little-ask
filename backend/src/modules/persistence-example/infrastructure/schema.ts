import { pgTable, text, uuid } from 'drizzle-orm/pg-core';

export const persistenceExamples = pgTable('persistence_examples', {
  id: uuid('id').defaultRandom().primaryKey(),
  value: text('value').notNull(),
});
