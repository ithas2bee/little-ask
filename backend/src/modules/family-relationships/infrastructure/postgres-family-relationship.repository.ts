import { and, eq } from 'drizzle-orm';
import type { NodePgDatabase } from 'drizzle-orm/node-postgres';
import type { FamilyRelationshipRepository } from '../application/ports/family-relationship.repository';
import { FamilyRelationship } from '../domain/family-relationship';
import * as schema from './schema';

export class PostgresFamilyRelationshipRepository
  implements FamilyRelationshipRepository
{
  constructor(private readonly database: NodePgDatabase<typeof schema>) {}

  async save(relationship: FamilyRelationship): Promise<FamilyRelationship> {
    const [saved] = await this.database
      .insert(schema.familyRelationships)
      .values(relationship)
      .onConflictDoNothing({
        target: [
          schema.familyRelationships.parentAccountId,
          schema.familyRelationships.childProfileId,
        ],
      })
      .returning();

    if (saved) {
      return this.toDomain(saved);
    }

    const existing = await this.findByParticipants(
      relationship.parentAccountId,
      relationship.childProfileId,
    );

    if (!existing) {
      throw new Error('Family relationship could not be saved.');
    }

    return existing;
  }

  async findByParticipants(
    parentAccountId: string,
    childProfileId: string,
  ): Promise<FamilyRelationship | null> {
    const [relationship] = await this.database
      .select()
      .from(schema.familyRelationships)
      .where(
        and(
          eq(schema.familyRelationships.parentAccountId, parentAccountId),
          eq(schema.familyRelationships.childProfileId, childProfileId),
        ),
      )
      .limit(1);

    return relationship ? this.toDomain(relationship) : null;
  }

  private toDomain(
    relationship: typeof schema.familyRelationships.$inferSelect,
  ): FamilyRelationship {
    return FamilyRelationship.approve({
      id: relationship.id,
      parentAccountId: relationship.parentAccountId,
      childProfileId: relationship.childProfileId,
    });
  }
}
