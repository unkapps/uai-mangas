
import { SnakeNamingStrategy } from 'typeorm-naming-strategies';
import { getConnectionOptions, ConnectionOptions } from 'typeorm';
import * as dotenv from 'dotenv';

import { envFilePath } from './env.config';

export const defaultConnectionConfig = async (): Promise<ConnectionOptions> => {
  dotenv.config({ path: envFilePath });

  const connectionOptions = await getConnectionOptions();

  return Object.assign(connectionOptions, {
    namingStrategy: new SnakeNamingStrategy(),
    logging: true,
  });
};
