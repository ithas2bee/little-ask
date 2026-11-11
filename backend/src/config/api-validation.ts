import { ValidationPipe, type INestApplication } from '@nestjs/common';

export function configureApiValidation(app: INestApplication): void {
  app.useGlobalPipes(
    new ValidationPipe({
      transform: true,
      whitelist: true,
      forbidNonWhitelisted: true,
    }),
  );
}
