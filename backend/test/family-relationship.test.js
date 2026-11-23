const assert = require('node:assert/strict');
const { test } = require('node:test');
const { FamilyRelationship } = require('../dist/modules/family-relationships/domain/family-relationship.js');

const validRelationship = {
  id: 'a8e98ef3-0b10-4db4-bf12-4ca93a2af682',
  parentAccountId: '6110aaeb-58c2-42e5-bf83-7a69cb85f641',
  childProfileId: '081c719e-94be-47a5-b116-55f622d3d5fa',
};

test('approved relationship identifies a parent account and child profile', () => {
  const relationship = FamilyRelationship.approve(validRelationship);

  assert.equal(relationship.id, validRelationship.id);
  assert.equal(relationship.parentAccountId, validRelationship.parentAccountId);
  assert.equal(relationship.childProfileId, validRelationship.childProfileId);
  assert.equal(relationship.status, 'approved');
});

test('relationship rejects invalid identifiers', () => {
  assert.throws(
    () =>
      FamilyRelationship.approve({
        ...validRelationship,
        childProfileId: 'not-a-uuid',
      }),
    /identifiers must be UUIDs/,
  );
});

test('relationship rejects the same participant in both roles', () => {
  assert.throws(
    () =>
      FamilyRelationship.approve({
        ...validRelationship,
        childProfileId: validRelationship.parentAccountId.toUpperCase(),
      }),
    /two distinct participants/,
  );
});
