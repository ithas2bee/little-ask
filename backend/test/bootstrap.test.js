const assert = require('node:assert/strict');
const { test } = require('node:test');
const { NestFactory } = require('@nestjs/core');
const { AppModule } = require('../dist/app.module.js');

test('NestJS application starts', async () => {
  const app = await NestFactory.create(AppModule, { logger: false });

  try {
    await app.listen(0, '127.0.0.1');
    assert.equal(app.getHttpServer().listening, true);
  } finally {
    await app.close();
  }
});
