import 'reflect-metadata';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { loadApplicationConfig } from './config/application-config';

async function bootstrap() {
  const config = loadApplicationConfig();
  const app = await NestFactory.create(AppModule);
  await app.listen(config.port);
}

void bootstrap();
