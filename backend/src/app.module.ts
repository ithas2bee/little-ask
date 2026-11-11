import { Module } from '@nestjs/common';
import { HealthModule } from './modules/health/health.module';
import { ValidationExampleModule } from './modules/validation-example/validation-example.module';

@Module({
  imports: [HealthModule, ValidationExampleModule],
})
export class AppModule {}
