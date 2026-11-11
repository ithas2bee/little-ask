import { Injectable } from '@nestjs/common';

@Injectable()
export class ValidationExampleUseCase {
  execute(quantity: number): { quantity: number } {
    return { quantity };
  }
}
