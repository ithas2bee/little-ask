import type { FamilyRelationship } from '../../domain/family-relationship';

export interface FamilyRelationshipRepository {
  save(relationship: FamilyRelationship): Promise<FamilyRelationship>;
  findByParticipants(
    parentAccountId: string,
    childProfileId: string,
  ): Promise<FamilyRelationship | null>;
}
