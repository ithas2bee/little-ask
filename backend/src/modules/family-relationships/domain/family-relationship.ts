export type FamilyRelationshipStatus = 'approved';

export interface ApprovedFamilyRelationshipDetails {
  id: string;
  parentAccountId: string;
  childProfileId: string;
}

export class FamilyRelationship {
  readonly status: FamilyRelationshipStatus = 'approved';

  private constructor(
    readonly id: string,
    readonly parentAccountId: string,
    readonly childProfileId: string,
  ) {}

  static approve(
    details: ApprovedFamilyRelationshipDetails,
  ): FamilyRelationship {
    for (const id of [
      details.id,
      details.parentAccountId,
      details.childProfileId,
    ]) {
      if (!/^[\da-f]{8}-(?:[\da-f]{4}-){3}[\da-f]{12}$/i.test(id)) {
        throw new Error('Family relationship identifiers must be UUIDs.');
      }
    }

    if (
      details.parentAccountId.toLowerCase() ===
      details.childProfileId.toLowerCase()
    ) {
      throw new Error(
        'A family relationship requires two distinct participants.',
      );
    }

    return new FamilyRelationship(
      details.id,
      details.parentAccountId,
      details.childProfileId,
    );
  }
}
