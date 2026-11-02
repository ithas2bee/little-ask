const assert = require('node:assert/strict');
const { test } = require('node:test');
const { NestFactory } = require('@nestjs/core');
const { AppModule } = require('../dist/app.module.js');

test('liveness and readiness endpoints report safe health status', async () => {
  const app = await NestFactory.create(AppModule, { logger: false });

  try {
    await app.listen(0, '127.0.0.1');
    assert.equal(app.getHttpServer().listening, true);

    const address = app.getHttpServer().address();
    const baseUrl = `http://127.0.0.1:${address.port}/health`;
    const liveness = await fetch(`${baseUrl}/live`);
    const readiness = await fetch(`${baseUrl}/ready`);

    assert.equal(liveness.status, 200);
    assert.deepEqual(await liveness.json(), { status: 'ok' });

    assert.equal(readiness.status, 200);
    assert.deepEqual(await readiness.json(), {
      status: 'ok',
      checks: {
        application: 'ok',
        dependencies: {},
      },
    });
  } finally {
    await app.close();
  }
});
