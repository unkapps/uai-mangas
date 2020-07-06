import {
  createConnection,
} from 'typeorm';

import { defaultConnectionConfig } from '../config/db.config';

(async () => {
  const connection = await createConnection({ ...await defaultConnectionConfig(), logging: true });

  await connection.runMigrations({
    transaction: 'all',
  });
  await connection.close();
})();
