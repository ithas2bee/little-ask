import 'reflect-metadata';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { loadApplicationConfig } from './config/application-config';
import { configureApiErrorHandling } from './config/api-exception-filter';
import { configureApiValidation } from './config/api-validation';

async function bootstrap() {
  const config = loadApplicationConfig();
  const app = await NestFactory.create(AppModule);
  configureApiErrorHandling(app);
  configureApiValidation(app);
  await app.listen(config.port);
}

void bootstrap();
