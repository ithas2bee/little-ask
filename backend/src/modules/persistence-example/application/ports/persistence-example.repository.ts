import type { PersistenceExample } from '../../domain/persistence-example';

export interface PersistenceExampleRepository {
  save(value: string): Promise<PersistenceExample>;
  findById(id: string): Promise<PersistenceExample | null>;
}
