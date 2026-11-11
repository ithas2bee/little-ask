const assert = require('node:assert/strict');
const { test } = require('node:test');
const {
  ConflictException,
  Controller,
  Get,
  Module,
  NotFoundException,
} = require('@nestjs/common');
const { NestFactory } = require('@nestjs/core');
const { AppModule } = require('../dist/app.module.js');
const {
  configureApiErrorHandling,
} = require('../dist/config/api-exception-filter.js');
const { configureApiValidation } = require('../dist/config/api-validation.js');

class ErrorTestController {
  notFound() {
    throw new NotFoundException('Private record 123 was not found');
  }

  conflict() {
    throw new ConflictException(
      'duplicate key value violates unique constraint "private_table"',
    );
  }

  unexpected() {
    throw new Error('SQL password and private child data');
  }
}

Controller('error-test')(ErrorTestController);
for (const [method, path] of [
  ['notFound', 'not-found'],
  ['conflict', 'conflict'],
  ['unexpected', 'unexpected'],
]) {
  Get(path)(
    ErrorTestController.prototype,
    method,
    Object.getOwnPropertyDescriptor(ErrorTestController.prototype, method),
  );
}

class ApiErrorsTestModule {}
Module({
  imports: [AppModule],
  controllers: [ErrorTestController],
})(ApiErrorsTestModule);

test('API errors use a stable shape and do not expose internal details', async () => {
  const app = await NestFactory.create(ApiErrorsTestModule, { logger: false });
  configureApiErrorHandling(app);
  configureApiValidation(app);

  try {
    await app.listen(0, '127.0.0.1');
    const address = app.getHttpServer().address();
    const baseUrl = `http://127.0.0.1:${address.port}`;

    const validationResponse = await fetch(`${baseUrl}/validation-example`, {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({ quantity: 'not-a-number' }),
    });
    assert.equal(validationResponse.status, 400);
    assert.deepEqual(await validationResponse.json(), {
      statusCode: 400,
      code: 'VALIDATION_ERROR',
      message: 'Request validation failed',
    });

    const notFoundResponse = await fetch(`${baseUrl}/error-test/not-found`);
    assert.equal(notFoundResponse.status, 404);
    assert.deepEqual(await notFoundResponse.json(), {
      statusCode: 404,
      code: 'NOT_FOUND',
      message: 'Resource not found',
    });

    const conflictResponse = await fetch(`${baseUrl}/error-test/conflict`);
    assert.equal(conflictResponse.status, 409);
    assert.deepEqual(await conflictResponse.json(), {
      statusCode: 409,
      code: 'CONFLICT',
      message: 'Request conflicts with the current state',
    });

    const unexpectedResponse = await fetch(`${baseUrl}/error-test/unexpected`);
    assert.equal(unexpectedResponse.status, 500);
    const unexpectedBody = await unexpectedResponse.json();
    assert.deepEqual(unexpectedBody, {
      statusCode: 500,
      code: 'INTERNAL_SERVER_ERROR',
      message: 'Internal server error',
    });
    assert.doesNotMatch(JSON.stringify(unexpectedBody), /SQL|password|child data/i);
  } finally {
    await app.close();
  }
});
