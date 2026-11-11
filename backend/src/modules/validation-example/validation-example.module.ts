import { Module } from '@nestjs/common';
import { ValidationExampleUseCase } from './application/validation-example.use-case';
import { ValidationExampleController } from './presentation/validation-example.controller';

@Module({
  controllers: [ValidationExampleController],
  providers: [ValidationExampleUseCase],
})
export class ValidationExampleModule {}
