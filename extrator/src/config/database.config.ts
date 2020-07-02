import { createConnection, getConnectionOptions, Connection } from 'typeorm';
import { SnakeNamingStrategy } from 'typeorm-naming-strategies';
import { autoInjectable } from 'tsyringe';

@autoInjectable()
export default class DatabaseConfig {
  public async createConnection(): Promise<Connection> {
    const connectionOptions = await getConnectionOptions();

    return createConnection(Object.assign(connectionOptions, {
      namingStrategy: new SnakeNamingStrategy(),
      entities: [
        `${__dirname}/../entity/**/*{.ts,.js}`,
      ],
      migrations: [
        `${__dirname}/../migration/*{.ts,.js}`,
      ],
    }));
  }
}
