export interface ApplicationConfig {
  readonly port: number;
}

const DEFAULT_PORT = 3000;
const INVALID_PORT_MESSAGE =
  'Invalid configuration: PORT must be an integer between 1 and 65535.';

export function loadApplicationConfig(
  environment: NodeJS.ProcessEnv = process.env,
): ApplicationConfig {
  const configuredPort = environment.PORT;

  if (configuredPort === undefined) {
    return { port: DEFAULT_PORT };
  }

  if (!/^[1-9]\d*$/.test(configuredPort)) {
    throw new Error(INVALID_PORT_MESSAGE);
  }

  const port = Number(configuredPort);

  if (!Number.isSafeInteger(port) || port > 65535) {
    throw new Error(INVALID_PORT_MESSAGE);
  }

  return { port };
}
