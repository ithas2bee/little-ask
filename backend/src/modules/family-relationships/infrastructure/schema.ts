import { check, pgTable, text, uniqueIndex, uuid } from 'drizzle-orm/pg-core';
import { sql } from 'drizzle-orm';

export const familyRelationships = pgTable(
  'family_relationships',
  {
    id: uuid('id').primaryKey(),
    parentAccountId: uuid('parent_account_id').notNull(),
    childProfileId: uuid('child_profile_id').notNull(),
    status: text('status').$type<'approved'>().notNull().default('approved'),
  },
  (table) => [
    uniqueIndex('family_relationships_participants_unique').on(
      table.parentAccountId,
      table.childProfileId,
    ),
    check(
      'family_relationships_status_approved',
      sql`${table.status} = 'approved'`,
    ),
    check(
      'family_relationships_distinct_participants',
      sql`${table.parentAccountId} <> ${table.childProfileId}`,
    ),
  ],
);
