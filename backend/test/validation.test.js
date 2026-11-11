const assert = require('node:assert/strict');
const { test } = require('node:test');
const { NestFactory } = require('@nestjs/core');
const { AppModule } = require('../dist/app.module.js');
const { configureApiValidation } = require('../dist/config/api-validation.js');

test('request DTO validation transforms input and rejects invalid fields', async () => {
  const app = await NestFactory.create(AppModule, { logger: false });
  configureApiValidation(app);

  try {
    await app.listen(0, '127.0.0.1');
    const address = app.getHttpServer().address();
    const endpoint = `http://127.0.0.1:${address.port}/validation-example`;

    const validResponse = await fetch(endpoint, {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({ quantity: '3' }),
    });
    assert.equal(validResponse.status, 201);
    const validResult = await validResponse.json();
    assert.deepEqual(validResult, { quantity: 3 });
    assert.equal(typeof validResult.quantity, 'number');

    for (const body of [
      { quantity: 'not-a-number' },
      {},
      { quantity: '3', unexpected: true },
    ]) {
      const response = await fetch(endpoint, {
        method: 'POST',
        headers: { 'content-type': 'application/json' },
        body: JSON.stringify(body),
      });

      assert.equal(response.status, 400);
    }
  } finally {
    await app.close();
  }
});
