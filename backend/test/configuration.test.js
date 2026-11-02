const assert = require('node:assert/strict');
const { test } = require('node:test');
const { loadApplicationConfig } = require('../dist/config/application-config.js');

test('configuration defaults to the documented port', () => {
  assert.deepEqual(loadApplicationConfig({}), { port: 3000 });
});

test('configuration accepts a valid port', () => {
  assert.deepEqual(loadApplicationConfig({ PORT: '65535' }), { port: 65535 });
});

test('configuration rejects invalid ports without exposing their values', () => {
  for (const port of ['0', '65536', 'not-a-port', ' 3000']) {
    assert.throws(
      () => loadApplicationConfig({ PORT: port }),
      (error) => {
        assert.equal(
          error.message,
          'Invalid configuration: PORT must be an integer between 1 and 65535.',
        );
        assert.equal(error.message.includes(port), false);
        return true;
      },
    );
  }
});
